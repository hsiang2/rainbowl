//
//  Knowledge.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/5/11.
//

import Foundation

struct Knowledge: Decodable, Hashable  {
    let name: String
    let bgColor: [Double]
    let color: [Double]
    let wordColor: [Double]
    let nutrition: String
    let description: String
    let images: [String]
}
