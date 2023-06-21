//
//  Food.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/20.
//

import Foundation

struct Food: Decodable, Hashable {
    var color: String
    var name: String
    var image: String
    var size: Float
    var unit: String
    var gram: Float
    var calorie: Float
}

//extension Food {
//    static var sampleData: [Food] {
//        [
//            Food(
//                color: "紅",
//                name: "西瓜",
//                image: "西瓜",
//                size: 0,
//                unit: "",
//                gram: 0,
//                calorie: 0
//            )
//        ]
//    }
//}
