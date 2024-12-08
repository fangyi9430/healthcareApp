//
//  HistoryControllerManager.swift
//  Final
//
//  Created by Eva H on 12/7/24.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore


extension HistoryViewController {
    
    func getAppointmentHistory() {
        guard let user = currentUser else {
            print("No user is signed in.")
            return
        }
        
        print(currentUser?.uid ?? "user id invalid")
        
        let collectionAppointment = self.database.collection("appointments").document(currentUser?.uid ?? "")
            .collection("userAppointments")
        
        collectionAppointment .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.appointments = []
                
                for document in querySnapshot!.documents {
                    if let appointment = try? document.data(as: Appointment.self) {
                        
                        self.appointments.append(appointment)
                    }
                }
                
                print("appointment:  \(self.appointments)")
                
                DispatchQueue.main.async {
                    self.historyView.appointmentView.tableViewAppointments.reloadData()
                }
            }
        }
    }
    
    func getSymptomHistory() {
        
        let collectionSymptoms = self.database.collection("symptoms").document(currentUser?.uid ?? "")
            .collection("userSymptoms")
        
        collectionSymptoms.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.symptoms = []
                
                for document in querySnapshot!.documents {
                    if let symptom = try? document.data(as: Symptom.self) {
                        
                        self.symptoms.append(symptom)
                    }
                }
                
                print("symptoms:  \(self.symptoms)")
                
                DispatchQueue.main.async {
                    self.historyView.symptomView.tableViewSymptoms.reloadData()
                }
                
                
            }
                
            }
            
            
        }
        
    }
