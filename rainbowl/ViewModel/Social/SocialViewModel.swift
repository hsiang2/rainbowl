//
//  SocialViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/13.
//

import SwiftUI
import Firebase

class SocialViewModel: ObservableObject {
    @ObservedObject var backpackViewModel: BackpackViewModel
    
    @Published var notificationList = [UserNotification]()
    @Published var friendList = [Friend]()
    // 分隔線
    @Published var users = [User]()
//    @Published var creatures = [CreatureInUse]()
    
    init(backpackViewModel: BackpackViewModel) {
        self.backpackViewModel = backpackViewModel
        fetchNotificationList()
        fetchUsers()
        fetchFriendList()
    }
    
    func fetchUsers() {
        guard let user = Auth.auth().currentUser else { return }
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching user documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let users = documents.compactMap({ try? $0.data(as: User.self) })
            self.users = users.filter({
                $0.id != user.uid
            })
        }
    }
    
    func fetchCreatures(uid: String, completion: @escaping ([CreatureInUse]) -> Void) {
        var creatureList: [CreatureInUse] = []
        COLLECTION_USERS.document(uid).collection("creatures").addSnapshotListener { snapshot, error in
            if let error = error {
                       // Handle error
                       print("Error fetching creatures: \(error.localizedDescription)")
                       completion([])
                       return
                   }
                   
                   guard let documents = snapshot?.documents else {
                       // Handle no documents
                       completion([])
                       return
                   }
                   
                   creatureList = documents.compactMap({ try? $0.data(as: CreatureInUse.self) })
                   completion(creatureList)
//            guard let documents = snapshot?.documents else { return }
//            creatureList = documents.compactMap({ try? $0.data(as: CreatureInUse.self) })
////            self.creatures = documents.compactMap({ try? $0.data(as: CreatureInUse.self) })
        }
//        return creatureList
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
        }
        print(notificationList)
    }
    
    //
    func newNotificationsCount() -> Int {
        var count = 0
        for notification in notificationList {
            if !notification.isRead {
                count += 1
            }
        }
        
        return count
    }
    
    func markUnreadNotificationsAsRead() {
        for index in notificationList.indices {
            if !notificationList[index].isRead {
                updateNotificationInFirebase(notificationList[index])
            }
        }
    }

    func updateNotificationInFirebase(_ notification: UserNotification) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }

        let notificationRef = COLLECTION_NOTIFICATION
            .document(user.id ?? "")
            .collection("notification")
            .document(notification.id ?? "")

        notificationRef.updateData(["isRead": true]) { error in
            if let error = error {
                print("Error updating notification: \(error.localizedDescription)")
            } else {
                print("Notification updated successfully in Firebase")
            }
        }
    }


    // Update the notification in Firebase
//    func readNotification(notificationId: String) {
//        guard let user = AuthViewModel.shared.currentUser else {
//            return
//        }
//
//        let notificationRef = COLLECTION_NOTIFICATION
//            .document(user.id ?? "")
//            .collection("notification")
//            .document(notificationId)
//
//        // Update the isRead property in Firebase
//        notificationRef.updateData(["isRead": true]) { error in
//            if let error = error {
//                print("Error updating notification: \(error.localizedDescription)")
//            } else {
//                print("Notification updated successfully in Firebase")
//            }
//        }
//    }

    
    // 拿有幾則通知
//    func fetchNotificationNumber() -> Int {
//        return notificationList.count
//    }
    
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
                "timestamp": Timestamp(date: Date()),
                "isRead": false
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
                "timestamp": Timestamp(date: Date()),
                "isRead": false
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
    
    //送禮物
    
    func sendGift(friend: String, creature: Creature, message: String) {
        guard let user = AuthViewModel.shared.currentUser else {
            return
        }
        let data = [
                "sender": user.id ?? "",
                "type": "gift",
                "timestamp": Timestamp(date: Date()),
                "creatureName": creature.name,
                "message": message,
                "isRead": false
        ] as [String : Any]
        
        backpackViewModel.deleteBackpack(name: creature.name)
        backpackViewModel.addToBackpack(category: creature.category, name: creature.name, colors: creature.colors, width: creature.width, friend: friend)
        
        COLLECTION_NOTIFICATION.document(friend).collection("notification").addDocument(data: data)
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


