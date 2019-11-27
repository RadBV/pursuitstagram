//
//  AppUsers.swift
//  pursuitstagram
//
//  Created by Radharani Ribas-Valongo on 11/26/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct AppUser {
    let email: String?
    let uid: String
    let username: String?
    let dateCreated: Date?
    let photoURL: String?
    
    init(from user: User) {
        self.username = user.displayName
        self.email = user.email
        self.uid = user.uid
        self.dateCreated = user.metadata.creationDate
        self.photoURL = user.photoURL?.absoluteString
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let userName = dict["username"] as? String,
            let email = dict["email"] as? String,
            let photoURL = dict["photoURL"] as? String,
            //MARK: TODO - extend Date to convert from Timestamp?
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        self.username = userName
        self.email = email
        self.uid = id
        self.dateCreated = dateCreated
        self.photoURL = photoURL
    }
    
    var fieldsDict: [String: Any] {
        return [
            "username": self.username ?? "",
            "email": self.email ?? ""
        ]
    }
}
