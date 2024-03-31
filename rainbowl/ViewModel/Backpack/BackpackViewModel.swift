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

    @Published var creatures = [Creature]()
    
    init() {
        fetchBackpack()
    }
    
    func fetchBackpack() {
        COLLECTION_BACKPACK.document(userId ?? "").collection("creatures").addSnapshotListener { snapshot, _ in
                   guard let documents = snapshot?.documents else { return }
                   self.creatures = documents.compactMap({ try? $0.data(as: Creature.self) })
               }
    }
    
    func addToBackpack(category: String, name: String, colors: [String], width: Float, isMoving: Bool, friend: String?) {
        let id = friend ?? userId ?? ""
        
        let data = [
                "category": category,
                "name": name,
                "colors": colors,
                "width": width,
                "isMoving": isMoving,
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
        
    }
    
    func deleteBackpack(name: String) {
        
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
    }
    
    func addToGame(category: String, name: String, colors: [String], width: Float, isMoving: Bool) {
        
        let data = [
                "category": category,
                "name": name,
                "colors": colors,
                "width": width,
                "locationX": 1179,
                "locationY": 912,
                "isMoving": isMoving
        ] as [String : Any]
        COLLECTION_USERS.document(userId ?? "").collection("creatures").addDocument(data: data)

        deleteBackpack(name: name)
    }
    
    func deleteGame(id: String, category: String, name: String, colors: [String], width: Float, isMoving: Bool) {

        COLLECTION_USERS.document(userId ?? "").collection("creatures").document(id).delete()


        addToBackpack(category: category, name: name, colors: colors, width: width, isMoving: isMoving, friend: nil)
    }
    
    
}


