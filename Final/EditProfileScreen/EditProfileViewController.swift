//
//  EditProfileViewController.swift
//  Final
//
//  Created by 李方一 on 12/1/24.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let editProfileView = EditProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEditProfileNotification(_:)),
            name: Notification.Name(NotificationNames.userDidSelectEditProfile),
            object: nil
        )
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc private func handleEditProfileNotification(_ notification: Notification) {
        if let user = notification.userInfo?["user"] as? User {
            print("Received User data: \(user)")
            self.updateView(with: user)
        }
    }

    private func updateView(with user: User) {
        editProfileView.nameLabel.text = "Name: \(user.name)"
        editProfileView.emailLabel.text = "Email: \(user.email)"
    }

}
