//
//  BackpackViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/28.
//

import SwiftUI
import Firebase

class BackpackViewModel: ObservableObject {
    private let userId = AuthViewModel.shared.currentUser?.id
//    private let backpackCollection = COLLECTION_BACKPACK.document(AuthViewModel.shared.currentUser?.id ?? "").collection("creatures")

    @Published var creatures = [Creature]()
//    @Published var creaturesInUse = [CreatureInUse]()
    
    init() {
        fetchBackpack()
    }
    
    func fetchBackpack() {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        
//        COLLECTION_BACKPACK.document(userId).collection("creatures").addSnapshotListener { snapshot, error in
//            guard let documents = snapshot?.documents else {
//                print("Error fetching backpack documents: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            self.creatures = documents.compactMap({ try? $0.data(as: Creature.self) })
//        }
        COLLECTION_BACKPACK.document(userId ?? "").collection("creatures").addSnapshotListener { snapshot, _ in
                   guard let documents = snapshot?.documents else { return }
                   self.creatures = documents.compactMap({ try? $0.data(as: Creature.self) })
               }
    }
    
    func addToBackpack(category: String, name: String, colors: [String], width: Float, friend: String?) {

//        guard let user = AuthViewModel.shared.currentUser else {
//            return
//        }
//        guard let user = user else { return }
        
//        let id = friend ?? user.id ?? ""
        let id = friend ?? userId ?? ""
        
        let data = [
                "category": category,
                "name": name,
                "colors": colors,
                "width": width,
//                "qty": 1
                "qty": FieldValue.increment(Int64(1))
        ] as [String : Any]
        COLLECTION_BACKPACK.document(id).collection("creatures").whereField("name", isEqualTo: name).getDocuments { snapshot, error in
                   guard let snapshot = snapshot else { return }

                   let batch = Firestore.firestore().batch()

                   if snapshot.documents.isEmpty {
                       batch.setData(data, forDocument: COLLECTION_BACKPACK.document(id).collection("creatures").document())
                   } else {
                       let document = snapshot.documents[0]
                       let documentID = document.documentID
                       let updatedQty = (document.data()["qty"] as? Int ?? 0) + 1
                       batch.updateData(["qty": updatedQty], forDocument: COLLECTION_BACKPACK.document(id).collection("creatures").document(documentID))
                   }

                   batch.commit()
               }
        
//        let docRef = COLLECTION_BACKPACK.document(id).collection("creatures").whereField("name", isEqualTo: name)
        
//        docRef.getDocuments { snapshot, error in
//             guard let snapshot = snapshot else {
//                 print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
//                 return
//             }
//            
//             if snapshot.documents.isEmpty  {
//                 COLLECTION_BACKPACK.document(id).collection("creatures").addDocument(data: data)
//             } else {
//                 
//                 let document = snapshot.documents[0]
//                 let documentID = document.documentID
//                 let updatedQty = (document.data()["qty"] as? Int ?? 0) + 1
//                COLLECTION_BACKPACK.document(id).collection("creatures").document(documentID).updateData(["qty": updatedQty])
//             }
//        }
    }
    
    func deleteBackpack(name: String) {
//        guard let user = AuthViewModel.shared.currentUser else {
//            return
//        }
//        guard let user = user else { return }
        
        COLLECTION_BACKPACK.document(userId ?? "").collection("creatures").whereField("name", isEqualTo: name).getDocuments { snapshot, error in
                   guard let snapshot = snapshot else { return }

                   let batch = Firestore.firestore().batch()

                   if let document = snapshot.documents.first {
                       let documentID = document.documentID
                       let qty = document.data()["qty"] as? Int ?? 0

                       if qty > 1 {
                           batch.updateData(["qty": qty - 1], forDocument: COLLECTION_BACKPACK.document(self.userId ?? "").collection("creatures").document(documentID))
                       } else {
                           batch.deleteDocument(COLLECTION_BACKPACK.document(self.userId ?? "").collection("creatures").document(documentID))
                       }
                   }

                   batch.commit()
               }
        
//        let docRef = COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures")
//        docRef.whereField("name", isEqualTo: name).getDocuments { snapshot, error in
//             guard let snapshot = snapshot else { return }
//                 let document = snapshot.documents[0]
//                 let documentID = document.documentID
//                let qty = document.data()["qty"] as? Int ?? 0
//            if(qty > 1) {
//                COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").document(documentID).updateData(["qty": qty - 1])
//            } else {
//                COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").document(documentID).delete()
//            }
//        }
    }
    
    func addToGame(category: String, name: String, colors: [String], width: Float) {
//        guard let uid = userSession?.uid else { return }
        
        let data = [
                "category": category,
                "name": name,
                "colors": colors,
                "width": width,
                "locationX": 1179,
                "locationY": 912
        ] as [String : Any]
        COLLECTION_USERS.document(userId ?? "").collection("creatures").addDocument(data: data)

        deleteBackpack(name: name)
    }
    
    func deleteGame(id: String, category: String, name: String, colors: [String], width: Float) {
//        guard let user = AuthViewModel.shared.currentUser else {
//            return
//        }
//        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(userId ?? "").collection("creatures").document(id).delete()
//        { _ in
//            AuthViewModel().fetchGame()
//        }

        addToBackpack(category: category, name: name, colors: colors, width: width, friend: nil)
    }
    
    
}


