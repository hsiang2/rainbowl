//
//  FetchRecordViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/21.
//

import SwiftUI

class FetchRecordViewModel: ObservableObject {
    @Published var records = [Record]()
    
    init() {
        fetchRecords()
    }
    
    func fetchRecords() {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let query = COLLECTION_RECORDS.whereField("user", isEqualTo: user.id ?? "")
        query.addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let records = documents.compactMap({ try? $0.data(as: Record.self) })
            self.records = records.sorted(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
            
        }
        print("Fetched records: \(self.records)")
        
//        COLLECTION_RECORDS.whereField("user", isEqualTo: user.id ?? "").getDocuments { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            let records = documents.compactMap({ try? $0.data(as: Record.self) })
//            self.records = records.sorted(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
            
//            DispatchQueue.main.async {
//                           print("Fetched records: \(self.records)")
//                       }
//        }
        
    }
    
}
