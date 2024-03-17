//
//  SocialViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/13.
//

import SwiftUI
import Firebase

class SocialViewModel: ObservableObject {
    @Published var notificationList = [UserNotification]()
    @Published var friendList = [Friend]()
    // 分隔線
    @Published var users = [User]()
    @Published var creatures = [CreatureInUse]()
    
    init() {
        fetchNotificationList()
        fetchUsers()
        fetchFriendList()
    }
    
    func fetchUsers() {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        COLLECTION_USERS.getDocuments{ snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let users = documents.compactMap({ try? $0.data(as: User.self) })
            self.users = users.filter({
                $0.id != user.id
            })
        }
    }
    
    func fetchCreatures(uid: String) {
        COLLECTION_USERS.document(uid).collection("creatures").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.creatures = documents.compactMap({ try? $0.data(as: CreatureInUse.self) })
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.username.lowercased().contains(lowercasedQuery) })
//        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery) })
    }
    
    func fetchNameById(user: String) -> String {
//        let index = users.firstIndex {$0.id == user}
//        return users[index ?? 0].username
        return users.first {$0.id == user}?.username ?? ""
    }
    
    func fetchUserById(user: String) -> User? {
        return users.first {$0.id == user}
        
    }
    // 分隔線
    
    func fetchNotificationList() {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        COLLECTION_NOTIFICATION.document(user.id ?? "").collection("notification").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let notifications = documents.compactMap({ try? $0.data(as: UserNotification.self) })
            self.notificationList = notifications.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
            print(notifications)
        }
    }
    
    // 拿有幾則通知
    func fetchNotificationNumber() -> Int {
        return notificationList.count
    }
    
    // 拿好友列表（含邀請中）
    func fetchFriendList() {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        COLLECTION_FRIENDSLIST.document(user.id ?? "").collection("friendsList").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.friendList = documents.compactMap({ try? $0.data(as: Friend.self) })
        }
    }
    
    // 拿好友列表
    func fetchRealFriendList() -> [User] {
        
        let realfriendList: [Friend] = friendList.filter {$0.status.contains("friend")}
        
        return realfriendList.compactMap {fetchUserById(user: $0.id)}

    }
    
    func filteredFriends(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        
        let realfriendList: [Friend] = friendList.filter({$0.status.contains("friend")})
        let friendUserList: [User] = realfriendList.compactMap({fetchUserById(user: $0.id)})
        
        return friendUserList.filter({
            $0.username.lowercased().contains(lowercasedQuery)
        })
//        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery) })
    }
    
    //刪好友
    func deleteFriend(friendId: String) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let myDocRef = COLLECTION_FRIENDSLIST.document(user.id ?? "").collection("friendsList")
        myDocRef.whereField("id", isEqualTo: friendId).getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
                let document = snapshot.documents[0]
                let documentID = document.documentID
               COLLECTION_FRIENDSLIST.document(user.id ?? "").collection("friendsList").document(documentID).delete()
        }
        
        let friendDocRef = COLLECTION_FRIENDSLIST.document(friendId).collection("friendsList")
        friendDocRef.whereField("id", isEqualTo: user.id ?? "").getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
                let document = snapshot.documents[0]
                let documentID = document.documentID
               COLLECTION_FRIENDSLIST.document(friendId).collection("friendsList").document(documentID).delete()
        }
    }
    
    //交友邀請
    func sendInvitation(invitee: String) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let data = [
                "sender": user.id ?? "",
                "type": "friendInvitation",
                "timestamp": Timestamp(date: Date())
        ] as [String : Any]
        
        
        COLLECTION_FRIENDSLIST.document(user.id ?? "").collection("friendsList").addDocument(data: ["id": invitee, "status": "pending"])
        COLLECTION_FRIENDSLIST.document(invitee).collection("friendsList").addDocument(data: ["id": user.id ?? "", "status":"request"])
        
        COLLECTION_NOTIFICATION.document(invitee).collection("notification").addDocument(data: data)
    }

    //接受交友邀請
    func acceptInvitation(inviter: String) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        let notificationData = [
                "sender": user.id ?? "",
                "type": "friendAccept",
                "timestamp": Timestamp(date: Date())
        ] as [String : Any]
        
        let inviterDocRef = COLLECTION_FRIENDSLIST.document(inviter).collection("friendsList")
        inviterDocRef.whereField("id", isEqualTo: user.id ?? "").getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
                let document = snapshot.documents[0]
                let documentID = document.documentID
               COLLECTION_FRIENDSLIST.document(inviter).collection("friendsList").document(documentID).updateData(["status": "friend"])
          
        }
        
        let inviteeDocRef = COLLECTION_FRIENDSLIST.document(user.id ?? "").collection("friendsList")
        inviteeDocRef.whereField("id", isEqualTo: inviter).getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
                let document = snapshot.documents[0]
                let documentID = document.documentID
               COLLECTION_FRIENDSLIST.document(user.id ?? "").collection("friendsList").document(documentID).updateData(["status": "friend"])
          
        }

//        COLLECTION_FRIENDSLIST.document(inviter).collection("friendsList").addDocument(data: ["id": user.id ?? "", "status": "friend"])
//        COLLECTION_FRIENDSLIST.document(user.id ?? "").collection("friendsList").addDocument(data: ["id": inviter, "status":"friend"])
        
        COLLECTION_NOTIFICATION.document(inviter).collection("notification").addDocument(data: notificationData)
    }

    func deleteNotification(id: String) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        
        COLLECTION_NOTIFICATION.document(user.id ?? "").collection("notification").document(id).delete()
    }
    
    func fetchFriendStatus(user: String) -> String {
        return friendList.first {$0.id == user}?.status ?? ""
    }
}


