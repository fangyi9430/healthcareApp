//
//  AddNewSymptomsViewController.swift
//  Final
//
//  Created by 李方一 on 12/6/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class AddNewSymptomsViewController: UIViewController {
    
    let addSymptomsView = AddNewSymptomsView()
    
    var selectedCategory = "head issue"
    
    var selectedHour = "0"
    var selectedMinute = "0"
    
    override func loadView() {
        view = addSymptomsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSymptomsView.buttonSelectCategory.menu = getMenuTypes()
        
        addSymptomsView.hourPicker.dataSource = self
        addSymptomsView.hourPicker.delegate = self
        addSymptomsView.minutePicker.dataSource = self
        addSymptomsView.minutePicker.delegate = self
        
        addSymptomsView.saveButton.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)

    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getMenuTypes() -> UIMenu{
        var menuItems = [UIAction]()
        
        for type in Utilities.CategoryTypes{
            let menuItem = UIAction(title: type,handler: {(_) in
                self.selectedCategory = type
                self.addSymptomsView.buttonSelectCategory.setTitle(self.selectedCategory, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select type", children: menuItems)
    }
    
    @objc func onSaveButtonTapped() {
        print("123")
        guard checkValidInputs() else { return }
        
        let notes = addSymptomsView.notes.text ?? ""
            let timestamp = Date()
            let symptomRecord = SymptomRecord(
                symptom: selectedCategory,
                duration: (hours: selectedHour, minutes: selectedMinute),
                notes: notes,
                timestamp: timestamp
        )
        
        guard let userId = Auth.auth().currentUser?.uid else {
                print("User not logged in")
                return
        }
        
        let db = Firestore.firestore()
        
        let recordData: [String: Any] = [
            "category": symptomRecord.symptom,
            "duration": [
                "hours": symptomRecord.duration.hours,
                "minutes": symptomRecord.duration.minutes
            ],
            "notes": symptomRecord.notes,
            "timestamp": symptomRecord.timestamp
        ]
        
        db.collection("users")
            .document(userId)
            .collection("symptomRecord")
            .addDocument(data: recordData) { error in
                if let error = error {
                    print("Error saving record: \(error)")
                } else {
                    print("Record saved successfully")
                }
            }
    
    }
    
    func checkValidInputs() -> Bool {

        if selectedCategory.isEmpty {
            showAlert(message: "Please select a symptom category.")
            return false
        }
        
        if addSymptomsView.notes.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert(message: "Notes cannot be empty.")
            return false
        }
        
        return true
    }

    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}

extension AddNewSymptomsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == addSymptomsView.hourPicker {
            return Utilities.hours.count
        } else if pickerView == addSymptomsView.minutePicker {
            return Utilities.minutes.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == addSymptomsView.hourPicker {
            return Utilities.hours[row]
        } else if pickerView == addSymptomsView.minutePicker {
            return Utilities.minutes[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == addSymptomsView.hourPicker {
            selectedHour = Utilities.hours[row]
        } else if pickerView == addSymptomsView.minutePicker {
            selectedMinute = Utilities.minutes[row]
        }
    }
}


