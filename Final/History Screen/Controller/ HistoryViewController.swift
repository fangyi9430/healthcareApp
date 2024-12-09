//
//  HistoryViewController.swift
//  Final
//
//  Created by Eva H on 11/21/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HistoryViewController: UIViewController, UITabBarDelegate {

    let database = Firestore.firestore()
    
    var currentUser: FirebaseAuth.User?
    
    // Reference to the custom view
    var historyView = HistoryView()
    
    var appointments: [Appointment] = []
    
    var symptoms: [Symptom] = []
    
    var doctorView = DoctorAppointmentScreenViewController()

    public let symptomTab = UITabBarItem(title: "Symptom", image: UIImage(systemName: "heart.fill"), tag: 0)
    public let appointmentTab = UITabBarItem(title: "Appointment", image: UIImage(systemName: "calendar"), tag: 1)

    override func loadView() {
        // Set the custom view as the main view
        historyView = HistoryView()
        
        view = historyView
        
    }
    

    override func viewDidLoad() {
        currentUser = Auth.auth().currentUser
        getAppointmentHistory()
        getSymptomHistory()
        //label title
        let titleLabel = UILabel()
        titleLabel.text = "History"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        super.viewDidLoad()
        
        // Set navigation bar preferences
       

        // Configure the tab bar
        historyView.tabBar.delegate = self
        historyView.tabBar.items = [symptomTab, appointmentTab]
        historyView.tabBar.selectedItem = symptomTab
        
        historyView.appointmentView.buttonAddAppointment.addTarget(self, action: #selector(onAddAppointmentButtonTapped), for: .touchUpInside)
        
        historyView.appointmentView.tableViewAppointments.delegate = self
        historyView.appointmentView.tableViewAppointments.dataSource = self
        
        //还没加
        historyView.symptomView.tableViewSymptoms.delegate = self
        historyView.symptomView.tableViewSymptoms.dataSource = self
        
        historyView.appointmentView.tableViewAppointments.rowHeight = UITableView.automaticDimension
        historyView.appointmentView.tableViewAppointments.estimatedRowHeight = 120 
        
        // Initially show the SymptomView
        updateVisibleView(for: .symptom)
    }
    
    @objc func onAddAppointmentButtonTapped(){
        navigationController?.pushViewController(doctorView, animated: true)
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == symptomTab {
            updateVisibleView(for: .symptom)
        } else if item == appointmentTab {
            updateVisibleView(for: .appointment)
        }
    }

    public func updateVisibleView(for tab: TabType) {
        historyView.symptomView.isHidden = (tab != .symptom)
        historyView.appointmentView.isHidden = (tab != .appointment)
    }
    
    
}

public enum TabType {
    case symptom
    case appointment
}
