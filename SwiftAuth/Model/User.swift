//
//  User.swift
//  SwiftAuth
//
//  Created by Ashraf Hatia on 15/03/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var firstName: String
    var lastName: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        
        var components = PersonNameComponents()
            components.givenName = firstName
            components.familyName = lastName
            formatter.style = .abbreviated
        
        return formatter.string(from: components)
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, firstName: "Michael" , lastName : "James", email: "test@gmail.com")
}
