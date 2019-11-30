//
//  Post.swift
//  pursuitstagram
//
//  Created by Radharani Ribas-Valongo on 11/26/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Post {
    let imageURL: String?
    let id: String
    let creatorID: String
    let dateCreated: Date?
    
    init(imageURL: String, body: String, creatorID: String, dateCreated: Date? = nil) {
        self.imageURL = imageURL
        self.creatorID = creatorID
        self.id = UUID().description
        self.dateCreated = dateCreated
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let imageURL = dict["imageURL"] as? String,
            let userID = dict["creatorID"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        self.imageURL = imageURL
        self.creatorID = userID
        self.id = id
        self.dateCreated = dateCreated
    }
    
    var fieldsDict: [String: Any] {
        return [
            "imageURL": self.imageURL,
            "creatorID": self.creatorID
        ]
    }
}
