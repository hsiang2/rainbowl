//
//  RecordViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/21.
//

import SwiftUI
import Firebase

class RecordViewModel: ObservableObject {
  
    @Published var records = [Record]()
    
    init() {
        fetchRecords()
    }
    
    func fetchRecords() {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let start = calendar.date(from: components)!
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        
        let query = COLLECTION_RECORDS
                        .whereField("user", isEqualTo: user.id ?? "")
                        .whereField("timestamp", isGreaterThan: start)
                        .whereField("timestamp", isLessThan: end)
        query.addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let records = documents.compactMap({ try? $0.data(as: Record.self) })
            self.records = records.sorted(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
            
        }
        print("Fetched records: \(self.records)")

    }
   
    
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
        AuthViewModel.shared.addColor(color: color)
    }
    
    func deleteRecord(id: String, color: String, records: [Record]) {
        
        COLLECTION_RECORDS.document(id).delete()
//        fetchRecords()
        AuthViewModel.shared.deleteColor(color: color, records: records)

    }
    
//    func like() {
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        guard let postId = post.id else { return }
//
//        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).setData([:]) { _ in
//            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).setData([:]) { _ in
//
//                COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes + 1])
//
//                NotificationsViewModel.uploadNotification(toUid: self.post.ownerUid, type: .like, post: self.post)
//
//                self.post.didLike = true
//                self.post.likes += 1
//            }
//        }
//    }
//
//    func unlike() {
//        guard post.likes > 0 else { return }
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        guard let postId = post.id else { return }
//
//        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
//            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
//
//                COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes - 1])
//
//                self.post.didLike = false
//                self.post.likes -= 1
//            }
//        }
//    }
}


