//
//  SearchUserViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

//import SwiftUI
//
//class SearchUserViewModel: ObservableObject {
//    @Published var users = [User]()
//    
//    @Published var creatures = [CreatureInUse]()
//    
//    init() {
//        fetchUsers()
//    }
//    
//    func fetchUsers() {
//        COLLECTION_USERS.getDocuments{ snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            
//            self.users = documents.compactMap({ try? $0.data(as: User.self) })
//        }
//    }
//    
//    func fetchCreatures(uid: String) {
//        COLLECTION_USERS.document(uid).collection("creatures").addSnapshotListener { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            self.creatures = documents.compactMap({ try? $0.data(as: CreatureInUse.self) })
//        }
//    }
//    
//    func filteredUsers(_ query: String) -> [User] {
//        let lowercasedQuery = query.lowercased()
//        return users.filter({ $0.username.lowercased().contains(lowercasedQuery) })
////        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery) })
//    }
//    
//    func fetchNameById(user: String) -> String {
//        guard let index = users.firstIndex(where: {$0.id == user}) else { return "" }
//        return users[index].username
//    }
//    
//}
