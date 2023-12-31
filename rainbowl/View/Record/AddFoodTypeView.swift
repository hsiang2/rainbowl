//
//  AddFoodTypeView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/3.
//

import SwiftUI

struct AddFoodTypeView: View {
//    var food: Food
//    let user: User
    
    
    @Binding var selectedIndex: String
    
    @Binding var addFoodType: Bool
    
    @State private var name: String = ""
    @State private var size: String = ""
    @State private var unit: String = ""
    @State private var gram: String = ""
    @State private var calorie: String = ""

    @ObservedObject var viewModel = FoodTypeViewModel()
//    @StateObject var recordsViewModel = FetchRecordViewModel(date: Date())
    
//    @StateObject var authViewModel = AuthViewModel()
    
//    init(user: User, food: Food) {
//        self.food = food
//        self.user = user
//    }

    
    var body: some View {
        VStack {
            HStack {
                Text("自訂\(selectedIndex)色蔬果").font(.system(size: 20, weight: .medium)).foregroundColor(Color(red: 120/255, green: 97/255, blue: 61/255))
                Spacer()
            }
            
            ZStack(alignment: .leading) {
                if name.isEmpty {
                    Text("")
                        .padding(.top, 30)
                        .tint(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                }
        
                VStack(alignment: .leading) {
                    Text("蔬果名稱")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                    TextField("", text: $name)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(Color(red: 171/255, green: 147/255, blue: 84/255))
                    Divider().overlay(Color(red: 139/255, green: 128/255, blue: 101/255))
                }
            }.padding(.top, 30)
            HStack {
                Text("定義份量")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                Spacer()
            }.padding(.top, 20)
            
            HStack {
               
                    Text("一份 ＝ ")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                        .padding(.top, 30)
                  
                ZStack(alignment: .leading) {
                    if size.isEmpty {
                        Text("")
                            .padding(.top, 30)
                            .tint(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                    }
            
                    VStack(alignment: .leading) {
                        Text("數量")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                        TextField("0.8", text: $size)
                            .foregroundColor(Color(red: 171/255, green: 147/255, blue: 84/255))
                            .keyboardType(.numberPad)
                        Divider().overlay(Color(red: 139/255, green: 128/255, blue: 101/255))
                    }
                }
                ZStack(alignment: .leading) {
                    if unit.isEmpty {
                        Text("")
                            .padding(.top, 30)
                            .tint(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                    }
            
                    VStack(alignment: .leading) {
                        Text("單位")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                        TextField("碗", text: $unit)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(Color(red: 171/255, green: 147/255, blue: 84/255))
                        Divider().overlay(Color(red: 139/255, green: 128/255, blue: 101/255))
                    }
                }
                
            }.padding(.top, 10)
//                .padding(.horizontal, 30)
            
            HStack {
                Text(" ＝ ")
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
//                    .padding(.top, 30)
                ZStack(alignment: .leading) {
                    if gram.isEmpty {
                        Text("")
                            .padding(.top, 30)
                            .tint(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                    }
            
                    VStack(alignment: .leading) {
//                        Text("公克")
//                            .font(.system(size: 18))
//                            .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                        TextField("", text: $gram)
                            .keyboardType(.numberPad)
                            .foregroundColor(Color(red: 171/255, green: 147/255, blue: 84/255))
                        Divider().overlay(Color(red: 139/255, green: 128/255, blue: 101/255))
                    }
                }
                Text("公克 (g)")
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
//                    .padding(.top, 30)
            }.padding(.top, 10)
           
            HStack {
                Text(" ＝ ")
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                ZStack(alignment: .leading) {
                    if calorie.isEmpty {
                        Text("")
                            .padding(.top, 30)
                            .tint(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                    }
                    
                    VStack(alignment: .leading) {
                        TextField("", text: $calorie)
                            .keyboardType(.numberPad)
                            .foregroundColor(Color(red: 171/255, green: 147/255, blue: 84/255))
                        Divider().overlay(Color(red: 139/255, green: 128/255, blue: 101/255))
                    }
                }
                Text("卡路里 (kcal)")
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
            }.padding(.top, 10)
//            HStack {
//                Spacer()
                Button {
                    viewModel.addFoodType(color: selectedIndex, name: name, size: Float(size) ?? 0, unit: unit, gram: Float(gram) ?? 0, calorie: Float(calorie) ?? 0) { error in
//                        name = ""
//                        size = 0
//                        unit = ""
//                        gram = 0
//                        calorie = 0
                        if let error = error {
                            print("Error adding record: \(error.localizedDescription)")
                        }
                    }
                    addFoodType = false
                    
                } label: {
                    Text("確認")
                        .font(.headline)
                        .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                        .frame(width: 314, height: 48)
                        .background(Color(red: 184/255, green: 175/255, blue: 153/255))
                        .cornerRadius(9)
                        .shadow(color: Color(red: 216/255, green: 214/255, blue: 209/255), radius: 6, x: 0, y: 4)
                        .padding(.top, 42)
//                        .padding(.top, 70)
//                        .font(.system(size: 12))
//                        .foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255))
//                        .frame(width: 85, height: 30)
//                        .background(Color(red: 188/255, green: 209/255, blue: 208/255))
//                        .cornerRadius(9)
                }
               
//            }.padding(.top, 42)
        }.padding(.horizontal, 30)
        .padding(.vertical, 20)
        
    }

}
    
//    struct AddFoodTypeView_Previews: PreviewProvider {
//        static var previews: some View {
//            AddFoodTypeView()
//        }
//    }
