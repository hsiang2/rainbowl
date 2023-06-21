//
//  JSONFileManager.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/20.
//

import Foundation

class JSONFileManager {
    static func load<T: Decodable>(_ filename: String) -> T {
        
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else{
            fatalError("Couldn't find the file in main bundle: \(filename)")
        }
        
        
        do{
            
            data = try Data(contentsOf: file)
        } catch {
            fatalError("file couldn't be loaded \(filename)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)

            fatalError("can't parse the file \(filename)")
        }
    }
}
