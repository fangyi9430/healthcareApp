//
//  Contact.swift
//  Final
//
//  Created by Eva H on 11/22/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable{

    var name: String
    var email: String
    var phone: String?
    var dateOfBirth: String?
    var height: String?
    var weight: String?
    var sex: String?
    var profilePictureURL: String?
    var userID:String?
  
    init(userID: String, name: String, email: String, phone: String? = nil, dateOfBirth: String? = nil, height: String? = nil, weight: String? = nil, sex: String? = nil, profilePictureURL: String? = nil) {
        self.userID = userID
        self.name = name
        self.email = email
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.sex = sex
        self.profilePictureURL = profilePictureURL
    }
}

struct SymptomRecord {
    var symptom: String
    var duration: (hours: String, minutes: String)
    var notes: String
    var timestamp: Date
}



