//
//  AppointmentViw.swift
//  Final
//
//  Created by Eva H on 12/5/24.
//

import Foundation
import UIKit

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == historyView.appointmentView.tableViewAppointments {
            return appointments.count
        } else if tableView == historyView.symptomView.tableViewSymptoms {
            return symptoms.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == historyView.appointmentView.tableViewAppointments {
            let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewAppointments, for: indexPath) as! AppointmentViewCell
            
            let appointment = appointments[indexPath.row]
            
            cell.labelNameOfDoctor.text = appointment.doctorName
            cell.labelDate.text = appointment.date
            cell.labelTimeSlot.text = appointment.timeSlot
            cell.delegate = self  // Set the delegate
            
            return cell
            
        } else if tableView == historyView.symptomView.tableViewSymptoms {
            let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewSymptoms, for: indexPath) as! SymptomViewCell
            
            let symptom = symptoms[indexPath.row]
            
            cell.labelCategory.text = symptom.category
            cell.labelHours.text = symptom.duration.hours
            cell.labelMinutes.text = symptom.duration.minutes
            cell.labelNotes.text = symptom.notes
            cell.labelTimestamp.text = symptom.timestamp
            cell.delegate = self 
            
            return cell
        }
        
        return UITableViewCell() // Default case
    }
}
    
    
    
extension HistoryViewController: AppointmentViewCellDelegate {
        
    // MARK: - AppointmentViewCellDelegate Methods
    func didTapCancelButton(for cell: AppointmentViewCell) {
        if let indexPath = historyView.appointmentView.tableViewAppointments.indexPath(for: cell) {
            let appointment = appointments[indexPath.row]
            // Handle cancel action
            showCancelConfirmationAlert(for: appointment)
        }
    }
        
        
    // MARK: - Helper Methods
    private func showCancelConfirmationAlert(for appointment: Appointment) {
        let alert = UIAlertController(
            title: "Cancel Appointment?",
            message: "Are you sure you want to cancel your appointment with Dr. \(appointment.doctorName) on \(appointment.date)?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Yes, Cancel", style: .destructive) { [weak self] _ in
            self?.cancelAppointment(appointment)
        })
            
        alert.addAction(UIAlertAction(title: "No, Keep", style: .cancel))
            
        present(alert, animated: true)
    }
        
    private func cancelAppointment(_ appointment: Appointment) {
        guard let user = currentUser else { return }
        
        let appointmentRef = database.collection("appointments")
            .document(user.uid)
            .collection("userAppointments")
            .document(appointment.id ?? "")
            
        appointmentRef.delete { error in
            if let error = error {
                print("Error removing appointment: \(error)")
            } else {
                print("Successfully removed appointment")
                // Refresh the appointments list
                self.getAppointmentHistory()
            }
        }
    }
}



extension HistoryViewController:SymptomViewCellDelegate {
    // MARK: - SymptomViewCellDelegate Methods
    
    func didTapDeleteButton(for cell: SymptomViewCell) {
        if let indexPath = historyView.symptomView.tableViewSymptoms.indexPath(for: cell) {
            let symptom = symptoms[indexPath.row]
            showDeleteConfirmationAlert(for: symptom)
        }
    }
    
    
    private func showDeleteConfirmationAlert(for symptom: Symptom) {
        let alert = UIAlertController(
            title: "Delete Symptom Record?",
            message: "Are you sure you want to delete this symptom record?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Yes, Delete", style: .destructive) { [weak self] _ in
            self?.deleteSymptom(symptom)
        })
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        
        present(alert, animated: true)
    }
    
    
    //这里要修改
    private func deleteSymptom(_ symptom: Symptom) {
        guard let user = currentUser else { return }
        
        database.collection("symptoms")
            .document(user.uid)
            .collection("userSymptoms")
            .document(symptom.id ?? "")
            .delete() { error in
                if let error = error {
                    print("Error deleting symptom: \(error)")
                } else {
                    print("Successfully deleted symptom")
                    self.getSymptomHistory()
                }
            }
    }
}
    
