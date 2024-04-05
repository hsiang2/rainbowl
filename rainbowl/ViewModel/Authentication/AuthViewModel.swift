//
//  AuthViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/4.
//

import SwiftUI
import FirebaseAuth


class AuthViewModel: ObservableObject {
    @Published var currentColors: [Float] = []
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didSendPasswordLink = false
    
    @Published var creatures = [CreatureInUse]()
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
        fetchGame()
    }
    
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Login faild\(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    
    func register(withEmail email: String, password: String, username: String, avatar: String, avatarColor: Int) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Registration error: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            print("Successfully register user...")
            
            let data = [
                "email": email,
                "username": username,
                "avatar": avatar,
                "avatarColor": avatarColor,
                "id": user.uid,
                "money": 1000,
//                "colors": [0, 0, 0, 0, 0]
                "red": [0, 0, 0, 0, 0],
                "orange": [0, 0, 0, 0, 0],
                "yellow": [0, 0, 0, 0, 0],
                "green": [0, 0, 0, 0, 0],
                "purple": [0, 0, 0, 0, 0],
                "white": [0, 0, 0, 0, 0],
            ] as [String : Any]
            
            COLLECTION_USERS.document(user.uid).setData(data) { error in
                if let error = error {
                    print("Error uploading user data: \(error.localizedDescription)")
                    return
                }
                print("Successfully uploaded user data...")
                self.userSession = user
                self.fetchUser()
            }
        }
    }
    
    func update(withEmail email: String, username: String, avatar: String, avatarColor: Int) {
        
        COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData([
            "email": email,
            "username": username,
            "avatar": avatar,
            "avatarColor": avatarColor
        ]){ error in
            if let error = error {
                print("Error updating color: \(error.localizedDescription)")
            } 
        }
           
    }
    
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Failed to send link with error \(error.localizedDescription)")
                return
            }
            
            self.didSendPasswordLink = true
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).addSnapshotListener { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
            
            self.currentColors = [
                self.currentUser?.red?.reduce(0) { $0 + $1 } ?? 0,
                self.currentUser?.orange?.reduce(0) { $0 + $1 } ?? 0,
                self.currentUser?.yellow?.reduce(0) { $0 + $1 } ?? 0,
                self.currentUser?.green?.reduce(0) { $0 + $1 } ?? 0,
                self.currentUser?.purple?.reduce(0) { $0 + $1 } ?? 0,
                self.currentUser?.white?.reduce(0) { $0 + $1 } ?? 0
            ]
        }
    }
    
    func addColor(color: String, records: [Record], completion: (([Float]?) -> Void)?) {
        let full = records.filter({
            $0.color.contains(color)
        }).count
        if (full == 0) {
            
            var colorArray = [Float]()
            let money = (self.currentUser?.money ?? 0) + 5
            
            switch color {
                
            case "紅":
                colorArray = self.currentUser?.red ?? []
                colorArray[4] = 0.2
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "red": colorArray]){ error in
                    if let error = error {
                        print("Error updating color: \(error.localizedDescription)")
                        completion?(nil)
                    } 
                    else {
                        completion?(self.currentColors)
                    }
                    
                }
            case "橙":
                colorArray = self.currentUser?.orange ?? []
                colorArray[4] = 0.2
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "orange": colorArray]){ error in
                    if let error = error {
                        print("Error updating color: \(error.localizedDescription)")
                        completion?(nil)
                    } else {
                        print("add orange", self.currentColors)
                        completion?(self.currentColors)
                    }
                }
            case "黃":
                colorArray = self.currentUser?.yellow ?? []
                colorArray[4] = 0.2
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "yellow": colorArray]){ error in
                    if let error = error {
                        print("Error updating color: \(error.localizedDescription)")
                        completion?(nil)
                    } else {
                        completion?(self.currentColors)
                    }
                }
            case "綠":
                colorArray = self.currentUser?.green ?? []
                colorArray[4] = 0.2
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "green": colorArray]){ error in
                    if let error = error {
                        print("Error updating color: \(error.localizedDescription)")
                        completion?(nil)
                    } else {
                        completion?(self.currentColors)
                    }
                }
            case "紫":
                colorArray = self.currentUser?.purple ?? []
                colorArray[4] = 0.2
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "purple": colorArray]){ error in
                    if let error = error {
                        print("Error updating color: \(error.localizedDescription)")
                        completion?(nil)
                    } else {
                        completion?(self.currentColors)
                    }
                }
            case "白":
                colorArray = self.currentUser?.white ?? []
                colorArray[4] = 0.2
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "white": colorArray]){ error in
                    if let error = error {
                        print("Error updating color: \(error.localizedDescription)")
                        completion?(nil)
                    } else {
                        completion?(self.currentColors)
                    }
                }
            default:
                break
            }
        }
//        completion(true)
        
    }
    
   
    

    func deleteColor(color: String, records: [Record]) {

        let full = records.filter({
            $0.color.contains(color)
        }).count
        if (full <= 1) {
            var colorArray = [Float]()
            let money = (self.currentUser?.money ?? 0) - 5 <= 0 ? 0 : (self.currentUser?.money ?? 0) - 5
            
            switch color {
                
            case "紅":
                colorArray = self.currentUser?.red ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "red": colorArray])
            case "橙":
                colorArray = self.currentUser?.orange ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "orange": colorArray])
            case "黃":
                colorArray = self.currentUser?.yellow ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "yellow": colorArray])
            case "綠":
                colorArray = self.currentUser?.green ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "green": colorArray])
            case "紫":
                colorArray = self.currentUser?.purple ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "purple": colorArray])
            case "白":
                colorArray = self.currentUser?.white ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["money": money, "white": colorArray])
            default:
                break
            }
            
        }

    }
    
    func updateColors() {
        guard let uid = userSession?.uid else { return }
        var redArray = [Float]()
        var orangeArray = [Float]()
        var yellowArray = [Float]()
        var greenArray = [Float]()
        var purpleArray = [Float]()
        var whiteArray = [Float]()
        
        redArray = self.currentUser?.red ?? []
        orangeArray = self.currentUser?.orange ?? []
        yellowArray = self.currentUser?.yellow ?? []
        greenArray = self.currentUser?.green ?? []
        purpleArray = self.currentUser?.purple ?? []
        whiteArray = self.currentUser?.white ?? []
        
        redArray = moveArray(array: redArray)
        orangeArray = moveArray(array: orangeArray)
        yellowArray = moveArray(array: yellowArray)
        greenArray = moveArray(array: greenArray)
        purpleArray = moveArray(array: purpleArray)
        whiteArray = moveArray(array: whiteArray)

        COLLECTION_USERS.document(uid).updateData([
            "red": redArray,
            "orange": orangeArray,
            "yellow": yellowArray,
            "green": greenArray,
            "purple": purpleArray,
            "white": whiteArray
        ])
    }
    
    func moveArray(array: [Float]) -> [Float] {
        let n = 5
        var a = array

        for i in 0...n-2 {
            a[i] = a[i+1]
        }
        a[n-1] = 0
        
        return a
    }
    
    func fetchGame() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).collection("creatures").addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.creatures = documents.compactMap({ try? $0.data(as: CreatureInUse.self) })
        }
    }
    
    func updateCreaturePosition(id: String, x: Float, y: Float) {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).collection("creatures").document(id).updateData(["locationX": x, "locationY": y])
    }
    
    func changeMoney(money: Int) {
        guard let uid = userSession?.uid else { return }
        
        let money = (self.currentUser?.money ?? 0) + money
        
        COLLECTION_USERS.document(uid).updateData([
            "money": money
        ])
    }
    
}
