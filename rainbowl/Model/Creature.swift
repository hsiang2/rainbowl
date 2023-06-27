//
//  Creature.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import FirebaseFirestoreSwift
import Firebase

struct Creature: Identifiable, Decodable {
    @DocumentID var id: String?
    
    let category: String
    let name: String
    let colors: [String]
    let width: Float
    
    let location: CGPoint

    

}
