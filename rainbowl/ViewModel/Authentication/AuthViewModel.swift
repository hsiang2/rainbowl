//
//  AuthViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/4.
//

import SwiftUI
import FirebaseAuth


class AuthViewModel: ObservableObject {
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
    
    func register(withEmail email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            print("Successfully register user...")
            
            let data = [
                "email": email,
                "username": username,
                "uid": user.uid,
//                "colors": [0, 0, 0, 0, 0]
                "red": [0, 0, 0, 0, 0],
                "orange": [0, 0, 0, 0, 0],
                "yellow": [0, 0, 0, 0, 0],
                "green": [0, 0, 0, 0, 0],
                "purple": [0, 0, 0, 0, 0],
                "white": [0, 0, 0, 0, 0],
            ] as [String : Any]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                print("successfully uploaded user data...")
                self.userSession = user
                self.fetchUser()
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
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
    
    func addColor(color: String) {
        var colorArray = [Float]()
        
        switch color {
            
        case "紅":
            colorArray = self.currentUser?.red ?? []
            colorArray[4] = 0.2
            COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["red": colorArray]){ _ in
                self.fetchUser()
            }
        case "橙":
            colorArray = self.currentUser?.orange ?? []
            colorArray[4] = 0.2
            COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["orange": colorArray]){ _ in
                self.fetchUser()
            }
        case "黃":
            colorArray = self.currentUser?.yellow ?? []
            colorArray[4] = 0.2
            COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["yellow": colorArray]){ _ in
                self.fetchUser()
            }
        case "綠":
            colorArray = self.currentUser?.green ?? []
            colorArray[4] = 0.2
            COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["green": colorArray]){ _ in
                self.fetchUser()
            }
        case "紫":
            colorArray = self.currentUser?.purple ?? []
            colorArray[4] = 0.2
            COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["purple": colorArray]){ _ in
                self.fetchUser()
            }
        case "白":
            colorArray = self.currentUser?.white ?? []
            colorArray[4] = 0.2
            COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["white": colorArray]){ _ in
                self.fetchUser()
            }
        default:
            break
        }
    }

    func deleteColor(color: String, records: [Record]) {

        let full = records.filter({
            $0.color.contains(color)
        }).count
        print(full)
        if (full <= 1) {
            var colorArray = [Float]()
            
            switch color {
                
            case "紅":
                colorArray = self.currentUser?.red ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["red": colorArray]){ _ in
                    self.fetchUser()
                }
            case "橙":
                colorArray = self.currentUser?.orange ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["orange": colorArray]){ _ in
                    self.fetchUser()
                }
            case "黃":
                colorArray = self.currentUser?.yellow ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["yellow": colorArray]){ _ in
                    self.fetchUser()
                }
            case "綠":
                colorArray = self.currentUser?.green ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["green": colorArray]){ _ in
                    self.fetchUser()
                }
            case "紫":
                colorArray = self.currentUser?.purple ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["purple": colorArray]){ _ in
                    self.fetchUser()
                }
            case "白":
                colorArray = self.currentUser?.white ?? []
                colorArray[4] = 0
                COLLECTION_USERS.document(self.currentUser?.id ?? "").updateData(["white": colorArray]){ _ in
                    self.fetchUser()
                }
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
        ]){ _ in
            self.fetchUser()
        }
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
    
    func addToGame(category: String, name: String, colors: [String], width: Float) {
//        guard let user = AuthViewModel.shared.currentUser else {
//            return
//        }
        guard let uid = userSession?.uid else { return }
        
        let data = [
                "category": category,
                "name": name,
                "colors": colors,
                "width": width,
                "locationX": 1160,
                "locationY":650
        ] as [String : Any]
        COLLECTION_USERS.document(uid).collection("creatures").addDocument(data: data){ _ in
            AuthViewModel().fetchGame()
        }

        BackpackViewModel().deleteBackpack(name: name)
    }
    
    func updateCreaturePosition(id: String, x: Float, y: Float) {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).collection("creatures").document(id).updateData(["locationX": x, "locationY": y])
    }
    
    func deleteGame(id: String, category: String, name: String, colors: [String], width: Float) {
//        guard let user = AuthViewModel.shared.currentUser else {
//            return
//        }
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).collection("creatures").document(id).delete()
//        { _ in
//            AuthViewModel().fetchGame()
//        }

        BackpackViewModel().addToBackpack(category: category, name: name, colors: colors, width: width)
    }
    
}
