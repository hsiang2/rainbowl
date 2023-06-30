//
//  BackpackViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/28.
//

import SwiftUI
import Firebase

class BackpackViewModel: ObservableObject {
    
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
    @Published var creatures = [Creature]()
    @Published var creaturesInUse = [CreatureInUse]()
    
    init() {

        fetchBackpack()
//        AuthViewModel().fetchGame()
    }
    
    func fetchBackpack() {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.creatures = documents.compactMap({ try? $0.data(as: Creature.self) })
        }
//        COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").getDocuments { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            self.creatures = documents.compactMap({ try? $0.data(as: Creature.self) })
//        }
    }
    
//    func fetchGame() {
//        COLLECTION_POSTS.getDocuments { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
//        }
//    }
//    
    func addToBackpack(category: String, name: String, colors: [String], width: Float) {

        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let data = [
                "category": category,
                "name": name,
                "colors": colors,
                "width": width,
                "qty": 1
        ] as [String : Any]
        
        let docRef = COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures")
        docRef.whereField("name", isEqualTo: name).getDocuments { snapshot, error in
             guard let snapshot = snapshot else { return }
             if snapshot.documents.isEmpty  {
                 COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").addDocument(data: data)
             } else {
                 
                 let document = snapshot.documents[0]
                 let documentID = document.documentID
                 let updatedQty = (document.data()["qty"] as? Int ?? 0) + 1

                 print(updatedQty)
                COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").document(documentID).updateData(["qty": updatedQty])
             }
        }
//        fetchBackpack()
    }
    
    func deleteBackpack(name: String) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let docRef = COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures")
        docRef.whereField("name", isEqualTo: name).getDocuments { snapshot, error in
             guard let snapshot = snapshot else { return }
                 let document = snapshot.documents[0]
                 let documentID = document.documentID
                let qty = document.data()["qty"] as? Int ?? 0
            if(qty > 1) {
                COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").document(documentID).updateData(["qty": qty - 1])
            } else {
                COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").document(documentID).delete()
            }
        }
//        fetchBackpack()
    }
    
    
}


