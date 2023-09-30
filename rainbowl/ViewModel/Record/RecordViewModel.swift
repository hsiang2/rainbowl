//
//  RecordViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/21.
//

import SwiftUI
import Firebase

class RecordViewModel: ObservableObject {

    func addRecord(name: String, color: String, calorie: Float, qty: Float, completion: ((Error?) -> Void)?) {
        
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let data = [
                "user": user.id ?? "",
                "name": name,
                "color": color,
                "calorie": calorie,
                "qty": qty,
                "timestamp": Timestamp(date: Date())] as [String : Any]
        
        COLLECTION_RECORDS.addDocument(data: data) { error in
            if let error = error {
                       completion?(error)
            } else {
                AuthViewModel.shared.addColor(color: color) { updatedColorArray in
                    if let updatedColorArray = updatedColorArray {
                        // Handle the updated color array, e.g., update UI
                        print("updateed in record", updatedColorArray)
                        self.checkUpdate(colorArray: updatedColorArray)
                    }
                }
            }
//            {(success) -> Void in
//                if success {
//                    self.checkUpdate()
//                }
//            }
        }
        
    }
    
    func deleteRecord(id: String, color: String, records: [Record]) {
        
        COLLECTION_RECORDS.document(id).delete()
        AuthViewModel.shared.deleteColor(color: color, records: records)

    }
//    
    func checkUpdate(colorArray: [Float?]) {
        print("checking...", colorArray)
        var bookCreatures: [CreatureInBook] = []
        BookViewModel.shared.fetchBook() { (success) -> Void in
            if success {
                bookCreatures = BookViewModel.shared.creatures.filter({
                                    $0.status == "initial"
                })
                
                print(bookCreatures)
        //        print(AuthViewModel.shared.creatures)
        //        print(bookCreatures)
                for creature in AuthViewModel.shared.creatures {
                    if (bookCreatures.contains {(bookCreature) -> Bool in
                        bookCreature.name == creature.name}) {
                        var isColored = true
                        for color in creature.colors {
                            switch color {
                                case "紅":
                                    isColored = colorArray[0] ?? 0 >= 1 ? true : false
                                case "橙":
                                    isColored = colorArray[1] ?? 0 >= 1 ? true : false
                                    print(colorArray[1] ?? 0)
                                case "黃":
                                    isColored = colorArray[2] ?? 0 >= 1 ? true : false
                                case "綠":
                                    isColored = colorArray[3] ?? 0 >= 1 ? true : false
                                case "紫":
                                    isColored = colorArray[4] ?? 0 >= 1 ? true : false
                                case "白":
                                    isColored = colorArray[5] ?? 0 >= 1 ? true : false
                                default:
                                    break
                                //                                    return AnyView(EmptyView())
                            }
                            if(!isColored) {
                                break
                            }
                        }
                        print(creature.name,isColored)
                        
                        if (isColored) {
                            BookViewModel().updateBook(name: creature.name)
                        }
                    }
                }

            }
        }
        
    }

    
}


