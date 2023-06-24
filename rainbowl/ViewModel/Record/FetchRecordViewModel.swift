//
//  FetchRecordViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/21.
//

import SwiftUI


class FetchRecordViewModel: ObservableObject {
//    @Published var records = [Record]()
//    
//    init() {
//        fetchRecords()
//    }
//    
//    func fetchRecords() {
//        guard let user = AuthViewModel.shared.currentUser else {
//            return
//        }
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: Date())
//        let start = calendar.date(from: components)!
//        let end = calendar.date(byAdding: .day, value: 1, to: start)!
//        
//        let query = COLLECTION_RECORDS
//                        .whereField("user", isEqualTo: user.id ?? "")
//                        .whereField("timestamp", isGreaterThan: start)
//                        .whereField("timestamp", isLessThan: end)
//        query.addSnapshotListener { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            let records = documents.compactMap({ try? $0.data(as: Record.self) })
//            self.records = records.sorted(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
//            
//        }
//        print("Fetched records: \(self.records)")
//
//    }
    
}



