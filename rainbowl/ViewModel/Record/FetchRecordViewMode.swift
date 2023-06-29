//
//  FetchRecordViewMode;.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/26.
//

import SwiftUI
import Firebase

class FetchRecordViewModel: ObservableObject {
  
    @Published var records = [Record]()
    var date: Date? = Date()
    
    init(date: Date) {
        self.date = date
        fetchRecords(date: date)
    }
    
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
//    }
    
    func fetchRecords(date: Date? = Date()) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let query = COLLECTION_RECORDS
                        .whereField("user", isEqualTo: user.id ?? "")
        query.addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let records = documents.compactMap({ try? $0.data(as: Record.self) })
            self.records = records.sorted(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                .filter({
                    self.compareDate(date1: $0.timestamp.dateValue(), date2: date ?? Date())
            })
            
            
        }
        print("Fetched records: \(self.records)")
    }
   
    func compareDate(date1:Date, date2:Date) -> Bool {
        let order = NSCalendar.current.compare(date1, to: date2, toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    

    
}
