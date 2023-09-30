//
//  BackpackViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/28.
//

import SwiftUI
import Firebase

class BackpackViewModel: ObservableObject {
 
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

//                 print(updatedQty)
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


