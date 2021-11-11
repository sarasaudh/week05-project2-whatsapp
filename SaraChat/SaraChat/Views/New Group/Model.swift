//
//  RegisterViewController.swift
//  chatApp
//
//  Created by SARA SAUD on 3/23/1443 AH.
//

import Foundation
import FirebaseFirestore

struct User {
    let id : String
    let name : String
     let status : String
    
}


struct Message {
    let id : String
    let sender : String
    let receiver : String
    let content : String
    let timestamp : Timestamp
}
