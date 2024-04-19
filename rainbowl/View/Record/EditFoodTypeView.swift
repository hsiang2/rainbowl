//
//  EditFoodTypeView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/4.
//

import SwiftUI

struct EditFoodTypeView: View {
        let food: FoodCustom?
        @Binding var editFoodType: FoodCustom?
        
        @State private var category: String = ""
        
        @State private var name: String = ""
        @State private var size: String = ""
        @State private var unit: String = ""
        @State private var gram: String = ""
        @State private var calorie: String = ""

        @ObservedObject var viewModel = FoodTypeViewModel()

    init(food: FoodCustom?, editFoodType: Binding<FoodCustom?>) {
        self.food = food 
        _editFoodType = editFoodType
        _name = State(initialValue: food?.name ?? "")
        _size = State(initialValue: String(food?.size ?? 0))
        _unit = State(initialValue: food?.unit ?? "")
        _gram = State(initialValue: String(food?.gram ?? 0))
        _calorie = State(initialValue: String(food?.calorie ?? 0))
        _category = State(initialValue: food?.category ?? "")
    }
        
        var body: some View {
            ScrollView {
                HStack {
                    Text("編輯").font(.system(size: 20, weight: .medium)).foregroundColor(Color(red: 120/255, green: 97/255, blue: 61/255))
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("種類")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                       //TODO
                        HStack (spacing: 20) {
                            RadioButtonView(category: "蔬菜", selectedCategory: $category)
                            RadioButtonView(category: "水果", selectedCategory: $category)
                        }.padding(.top, 10)
                    }.padding(.top, 20)
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
                }.padding(.top, 20)
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
                                .keyboardType(.decimalPad)
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
                
                HStack {
                    Text(" ＝ ")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                    ZStack(alignment: .leading) {
                        if gram.isEmpty {
                            Text("")
                                .padding(.top, 30)
                                .tint(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                        }
                
                        VStack(alignment: .leading) {
                            TextField("", text: $gram)
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color(red: 171/255, green: 147/255, blue: 84/255))
                            Divider().overlay(Color(red: 139/255, green: 128/255, blue: 101/255))
                        }
                    }
                    Text("公克 (g)")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
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
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color(red: 171/255, green: 147/255, blue: 84/255))
                            Divider().overlay(Color(red: 139/255, green: 128/255, blue: 101/255))
                        }
                    }
                    Text("卡路里 (kcal)")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                }.padding(.top, 10)
                HStack {
                    Button {
                        viewModel.deleteFoodType(id: food?.id ?? "")
                        editFoodType = nil
                        SoundPlayer.shared.playClickSound()
                    } label: {
                        Text("刪除")
                            .font(.headline)
                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                            .frame(width: 150, height: 48)
                            .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                            .cornerRadius(9)
                            .shadow(color: Color(red: 216/255, green: 214/255, blue: 209/255), radius: 6, x: 0, y: 4)
                        
                    }
                    Spacer()
                    Button {
                        viewModel.updateFoodType(id: food?.id ?? "",name: name, size: Float(size) ?? 0, unit: unit, gram: Float(gram) ?? 0, calorie: Float(calorie) ?? 0, category: category) { error in
                            if let error = error {
                                print("Error adding record: \(error.localizedDescription)")
                            }
                        }
                        editFoodType = nil
                        SoundPlayer.shared.playClickSound()
                        
                    } label: {
                        Text("確認")
                            .font(.headline)
                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                            .frame(width: 150, height: 48)
                            .background(Color(red: 184/255, green: 175/255, blue: 153/255))
                            .cornerRadius(9)
                            .shadow(color: Color(red: 216/255, green: 214/255, blue: 209/255), radius: 6, x: 0, y: 4)
                    }
                   
                }.padding(.top, 35)
            }.padding(.horizontal, 40)
            .padding(.top, 80)
            .scrollIndicators(.hidden)
            
        }

    }

//struct EditFoodTypeView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFoodTypeView()
//    }
//}
