
//
//  DoctorAppointmentScreenViewController.swift
//  Final
//
//  Created by Eva H on 11/26/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class DoctorAppointmentScreenViewController: UIViewController {
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    var doctorView = DoctorAppointmentScreenView()
    
    var appointmentController = AddAppointmentViewController()
    
    var doctors: [Doctor] = []

    
    override func loadView() {
        getDoctorList()
        
        view = doctorView
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("DEBUG: ViewDidLoad started")
        
        doctorView.tableViewDoctors.dataSource = self
        doctorView.tableViewDoctors.delegate = self
        
        print("DEBUG: TableView delegates set")
        
        doctorView.tableViewDoctors.rowHeight = UITableView.automaticDimension
//        doctorView.tableViewDoctors.estimatedRowHeight = 100
        
        //---head title-- do not move or change//
        
        let titleLabel = UILabel()
        titleLabel.text = "Doctors List"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a container view
        let titleContainer = UIView()
        titleContainer.addSubview(titleLabel)
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to the label
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleContainer.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleContainer.centerYAnchor)
        ])
        
        navigationItem.titleView = titleContainer
        
        navigationController?.navigationBar.prefersLargeTitles = false
        //---head title-- do not move or change//
        
//        print("this is the doctor appontment view")
        
    }
    
    func addAppointment(doctor: Doctor) {
        print("add appointment screen showed for doctor ID: \(String(describing: doctor.id))")
        
        if let navigationController = self.navigationController {
            let appointmentController = AddAppointmentViewController()
            
            appointmentController.addAppointmentView.selectedDoctor = doctor
            navigationController.pushViewController(appointmentController, animated: true)
        } else {
            print("Navigation controller not found")
        }
    }
    
    
    func getDoctorList() {
        
        if let currentUser = Auth.auth().currentUser {
            print("User is signed in: \(currentUser.email ?? "No Email")")
        } else {
            print("No user is signed in.")
        }
        
        let collectionDoctor = self.database.collection("doctor")
        
        
        collectionDoctor .addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                // Clear the messages array before adding new data
                self.doctors = []
                
                for document in querySnapshot!.documents {
                    if var doctor = try? document.data(as: Doctor.self) {
                        doctor.id = document.documentID
                        self.doctors.append(doctor)
                    }
                }
                
                DispatchQueue.main.async {
                    self.doctorView.tableViewDoctors.reloadData()
                }
                
                
                print(self.doctors)
            }
        }
    }

}
