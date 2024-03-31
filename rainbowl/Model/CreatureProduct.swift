//
//  Creatures.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/29.
//

import Foundation

struct CreatureProduct: Decodable, Hashable {
    var category: String
    var name: String
    var colors: [String]
    var width: Float
    let isMoving: Bool
}
