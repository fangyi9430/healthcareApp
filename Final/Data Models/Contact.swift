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

struct Doctor: Codable{
    var id: String?
    var name: String
    var description: String
    var type: String
    
    init(name: String, description: String, type:String, id: String) {
        self.name = name
        self.description = description
        self.type = type
        self.id = id
    }
}

struct Appointment: Codable {
    var id: String?
    var doctorId: String?
    var doctorName: String
    var patientId: String
    var date: String
    var status: String // "pending", "confirmed", "canceled"
    var timeSlot: String // e.g. "09:00 AM"
    var notes: String?
}

struct Symptom: Codable {
    var id: String?
    var category: String
    var duration: Duration
    var notes: String
    var timestamp: String  // or Date if you want to parse it
    
    struct Duration: Codable {
        var hours: String
        var minutes: String
    }
}
