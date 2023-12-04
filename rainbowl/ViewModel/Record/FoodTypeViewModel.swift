//
//  FoodTypeViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/3.
//

import SwiftUI
import Firebase

class FoodTypeViewModel: ObservableObject {

    @Published var foodTypes = [FoodCustom]()
    
    
    init() {
        fetchFoodTypes{ (success) -> Void in }
    }
    
    func fetchFoodTypes(completion: @escaping (_ success: Bool) -> Void) {
        guard let user = AuthViewModel.shared.currentUser else {
            completion(false)
            return
        }
        COLLECTION_FOODTYPE.document(user.id ?? "").collection("foodTypes").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else {
                completion(false)
                return
            }
            self.foodTypes = documents.compactMap({ try? $0.data(as: FoodCustom.self) })
            
            completion(true)
        }

    }
    
    func addFoodType(color: String, name: String, size: Float, unit: String, gram: Float, calorie: Float, completion: ((Error?) -> Void)?) {
        
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let data = [
            "color": color,
            "name": name,
            "size": size,
            "unit": unit,
            "gram": gram,
            "calorie": calorie,
        ] as [String : Any]
        
        let docRef = COLLECTION_FOODTYPE.document(user.id ?? "").collection("foodTypes")
        docRef.whereField("name", isEqualTo: name).getDocuments { snapshot, error in
             guard let snapshot = snapshot else { return }
             if snapshot.documents.isEmpty  {
                 COLLECTION_FOODTYPE.document(user.id ?? "").collection("foodTypes").addDocument(data: data)
             }
        }
        
    }
    
    func deleteFoodType(id: String) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
//        let docRef = COLLECTION_FOODTYPE.document(user.id ?? "").collection("foodTypes")
//        docRef.whereField("name", isEqualTo: name).getDocuments { snapshot, error in
//             guard let snapshot = snapshot else { return }
//                 let document = snapshot.documents[0]
//                 let documentID = document.documentID

            COLLECTION_FOODTYPE.document(user.id ?? "").collection("foodTypes").document(id).delete()
//        }
    }
    
        
    func updateFoodType( id: String, name: String, size: Float, unit: String, gram: Float, calorie: Float, completion: ((Error?) -> Void)?) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
//        let docRef = COLLECTION_FOODTYPE.document(user.id ?? "").collection("foodTypes")
//        docRef.whereField("name", isEqualTo: name).getDocuments { snapshot, error in
//             guard let snapshot = snapshot else { return }
//
//            if let document = snapshot.documents.first {
//                let documentID = document.documentID
                
                
                COLLECTION_FOODTYPE.document(user.id ?? "").collection("foodTypes").document(id).updateData([
                    "name": name,
                    "size": size,
                    "unit": unit,
                    "gram": gram,
                    "calorie": calorie,
                ])
                
//                completion?(nil)
//            }
//        }
    }
    
}
