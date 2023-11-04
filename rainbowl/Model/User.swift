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
//    var colors: [[Float]]
    var money: Int
    var red: [Float]?
    var orange: [Float]?
    var yellow: [Float]?
    var green: [Float]?
    var purple: [Float]?
    var white: [Float]?
    
}
