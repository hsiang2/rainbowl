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
        
        COLLECTION_RECORDS.addDocument(data: data, completion: completion)
        
    }
    func deleteRecord(id: String) {
        COLLECTION_RECORDS.document(id).delete()
    }
}
