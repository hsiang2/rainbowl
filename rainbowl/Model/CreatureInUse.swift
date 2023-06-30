//
//  CreatureInUse.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/28.
//

import FirebaseFirestoreSwift
import Firebase

struct CreatureInUse: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?

    var category: String
    let name: String
    let colors: [String]
    let width: Float
    let locationX: Float?
    let locationY: Float?
}
