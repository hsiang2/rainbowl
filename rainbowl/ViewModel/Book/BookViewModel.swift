//
//  BookViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/9/9.
//

import SwiftUI
import Firebase

class BookViewModel: ObservableObject {
 
//    @Published var creatures = [Creature]()
//    @Published var creaturesInUse = [CreatureInUse]()
    @Published var creatures = [CreatureInBook]()
    
    init() {
        fetchBook()
    }
    
    func fetchBook() {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        COLLECTION_BOOK.document(user.id ?? "").collection("creatures").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.creatures = documents.compactMap({ try? $0.data(as: CreatureInBook.self) })
        }

    }
    
    func addToBook(name: String) {

        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let data = [
                "name": name,
                "status": "initial"
        ] as [String : Any]
        
        let docRef = COLLECTION_BOOK.document(user.id ?? "").collection("creatures")
        docRef.whereField("name", isEqualTo: name).getDocuments { snapshot, error in
             guard let snapshot = snapshot else { return }
             if snapshot.documents.isEmpty  {
                 COLLECTION_BOOK.document(user.id ?? "").collection("creatures").addDocument(data: data)
             }
        }
    }
    
    func updateBook(name: String) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let docRef = COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures")
        docRef.whereField("name", isEqualTo: name).getDocuments { snapshot, error in
             guard let snapshot = snapshot else { return }
                 let document = snapshot.documents[0]
                 let documentID = document.documentID
                
                COLLECTION_BACKPACK.document(user.id ?? "").collection("creatures").document(documentID).updateData(["status": "completed"])
           
        }
    }
    
    
}


