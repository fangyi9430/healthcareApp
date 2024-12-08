
//
//  AddAppointmentViewController.swift
//  Final
//
//  Created by Eva H on 12/5/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol AddAppointmentDelegate: AnyObject {
    func appointmentDidSubmit(doctorId: String)
}

class AddAppointmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let addAppointmentView = AddAppointmentView()
    let database = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    weak var delegate: AddAppointmentDelegate?
    
    override func loadView() {
        view = addAppointmentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule Appointment"
        currentUser = Auth.auth().currentUser
        
        addAppointmentView.timeSlotPicker.delegate = self
        addAppointmentView.timeSlotPicker.dataSource = self
        
        addAppointmentView.submitButton.addTarget(self,
                                                action: #selector(submitAppointment),
                                                for: .touchUpInside)
    }
    
    @objc func submitAppointment() {
        guard let currentUser = currentUser else {
            return
        }
        
        guard let doctor = addAppointmentView.selectedDoctor else {
            // Handle case where no doctor is selected
            print("No doctor selected")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: addAppointmentView.datePicker.date)
        let selectedTimeSlot = addAppointmentView.timeSlots[addAppointmentView.timeSlotPicker.selectedRow(inComponent: 0)]
        
        // First check for existing appointments
        let userAppointmentsRef = database.collection("appointments")
            .document(currentUser.uid)
            .collection("userAppointments")
        
        userAppointmentsRef.getDocuments { [weak self] querySnapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error checking existing appointments: \(error)")
                return
            }
            
            // Check each document for time conflict
            var hasConflict = false
            if let documents = querySnapshot?.documents {
                for document in documents {
                    if let existingAppointment = try? document.data(as: Appointment.self) {
                        // Check if the appointment is on the same date and time
                        if existingAppointment.date == dateString &&
                           existingAppointment.timeSlot == selectedTimeSlot &&
                           existingAppointment.status != "cancelled" {  // Only check non-cancelled appointments
                            hasConflict = true
                            break
                        }
                    }
                }
            }
            
            if hasConflict {
                // Show alert for existing appointment
                let alert = UIAlertController(
                    title: "Appointment Conflict",
                    message: "You already have an appointment scheduled for \(dateString) at \(selectedTimeSlot). Please select a different time.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                return
            }
            
            // If no conflict found, create the new appointment
            let appointment = Appointment(
                doctorId: doctor.id ?? "",
                doctorName: doctor.name,
                patientId: currentUser.uid,
                date: dateString,
                status: "pending",
                timeSlot: selectedTimeSlot,
                notes: self.addAppointmentView.notesTextView.text
            )
            
            self.saveAppointment(appointment)
        }
    }
    
    func saveAppointment(_ appointment: Appointment) {
        do {
            // Create a reference to the user's appointments collection
            let userAppointmentsRef = database.collection("appointments")
                .document(currentUser?.uid ?? "")
                .collection("userAppointments")
            
            // First create a document reference to get an ID
            let newDocumentRef = userAppointmentsRef.document()
            
            // Create a mutable copy of the appointment and set its ID
            var mutableAppointment = appointment
            mutableAppointment.id = newDocumentRef.documentID
            
            // Now save the appointment with the ID included
            try newDocumentRef.setData(from: mutableAppointment) { error in
                if let error = error {
                    print("Error saving appointment: \(error)")
                } else {
                    self.showSuccessAndDismiss()
                }
            }
        } catch {
            print("Error encoding appointment: \(error)")
        }
    }
    
    func showSuccessAndDismiss() {
        let alert = UIAlertController(
            title: "Success!",
            message: "Your appointment request has been submitted.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            // Pop back to root view controller (History View)
            if let navigationController = self.navigationController,
               let historyVC = navigationController.viewControllers.first as? HistoryViewController {
                
                // First navigate back
                navigationController.popToRootViewController(animated: true)
                
                // Then switch to appointment tab
                historyVC.historyView.tabBar.selectedItem = historyVC.appointmentTab
                historyVC.historyView.symptomView.isHidden = true
                historyVC.historyView.appointmentView.isHidden = false
                historyVC.updateVisibleView(for: .appointment)
                
                // Refresh the appointments list
                historyVC.getAppointmentHistory()
            }
        })
        
        present(alert, animated: true)
    }
    
    // MARK: - UIPickerViewDelegate & DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addAppointmentView.timeSlots.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addAppointmentView.timeSlots[row]
    }
}
