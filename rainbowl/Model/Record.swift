//
//  Record.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/21.
//

import FirebaseFirestoreSwift
import Firebase

struct Record: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    let user: String
    let category: String
    let name: String
    let color: String
    let calorie: Float
    let qty: Float
    let timestamp: Timestamp
}
