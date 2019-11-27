//
//  Constants.swift
//  pursuitstagram
//
//  Created by Radharani Ribas-Valongo on 11/26/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import Foundation

struct Constants {
    enum Storyboard: String {
        case homeVC
    }
    
    enum Fields: String {
        case error
        case email
        case password
        case username
    }
    
    enum FireStoreCollections: String {
        case users
        case pictures
        case comments
    }
}

