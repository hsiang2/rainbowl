//
//  Food.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/20.
//

import FirebaseFirestoreSwift
import Firebase

protocol FoodProtocol {
    var color: String { get set }
    var name: String { get set }
    var size: Float { get set }
    var unit: String { get set }
    var gram: Float { get set }
    var calorie: Float { get set }
    var category: String { get set }
}

struct Food: FoodProtocol, Decodable, Hashable {
    var color: String
    var name: String
    var size: Float
    var unit: String
    var gram: Float
    var calorie: Float
    var category: String
}

struct FoodCustom: FoodProtocol, Decodable, Hashable {
    var color: String
    var name: String
    var size: Float
    var unit: String
    var gram: Float
    var calorie: Float
    var category: String
    @DocumentID var id: String?
}


