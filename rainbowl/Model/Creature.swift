//
//  Creature.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import FirebaseFirestoreSwift
import Firebase

struct Creature: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    
    let category: String
    let name: String
    let colors: [String]
    let width: Float
    let qty: Int
    let isMoving: Bool
}
