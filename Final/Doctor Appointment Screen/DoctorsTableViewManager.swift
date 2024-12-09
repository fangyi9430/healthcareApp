//
//  DoctorsTableViewManager.swift
//  Final
//
//  Created by Eva H on 12/5/24.
//

import Foundation
import UIKit

extension DoctorAppointmentScreenViewController: UITableViewDelegate, UITableViewDataSource,DoctorsTableViewCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewDoctorsID, for: indexPath) as! DoctorsTableViewCell
        
        let doctor = doctors[indexPath.row]
        cell.labelName.text = doctor.name
        cell.labelDescription.text = doctor.description
        cell.labelType.text = doctor.type
        cell.delegate = self // Set the delegate here
        
        
        return cell
    }

    
    func didTapAddAppointmentButton(for cell: DoctorsTableViewCell) {
        if let indexPath = doctorView.tableViewDoctors.indexPath(for: cell) {
            let doctor = doctors[indexPath.row]
            addAppointment(doctor: doctor)  
        }
    }
    
}
