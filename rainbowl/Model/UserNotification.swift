//
//  Notification.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/13.
//

import FirebaseFirestoreSwift
import Firebase

struct UserNotification: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    
    let sender: String
    let type: String
    var isRead: Bool
    let timestamp: Timestamp
    let creatureName: String?
    let message: String?
}
