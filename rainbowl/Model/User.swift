//
//  User.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/5.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    let username: String
    let email: String
    @DocumentID var id: String?
    
}
