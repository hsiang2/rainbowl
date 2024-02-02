//
//  ColorContentView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/1.
//

import SwiftUI

struct FoodListView: View {

    let user: User
    
    @Binding var editFoodType: FoodCustom?
    
    @Binding var selectedIndex: String
    @State private var selectedBtn: Food?
    
    @Binding var addFoodType: Bool
    
    @State private var allFood = [Food]()
    
    @State private var allCustomFood = [FoodCustom]()
    
    
    @ObservedObject var viewModel = FoodTypeViewModel()
    
    var customFood: [FoodCustom] {
        return viewModel.foodTypes.filter({
            $0.color.contains(selectedIndex)
        })
    }
    
    var food: [Food] {
        return allFood.filter({
            $0.color.contains(selectedIndex)
        })
    }
    
    var body: some View {
        
        if (selectedIndex != "") {

            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        //蔬果列
                        ForEach(food, id: \.self) { food in
                            Button(action: {
                                selectedBtn = food
                                SoundPlayer.shared.playClickSound()
                            }) {
                                ZStack{
                                    if (selectedBtn == food) {
                                        Image("food_bg_focus")
                                    } else {
                                        Image("food_bg")
                                    }
                                    Image(food.name).resizable().scaledToFit().frame(width: 45, height: 45)
                                }.padding(.leading, 10)

                            }
                        }
                        
                        
                        
                        //自訂蔬果列
                        ForEach(customFood, id: \.self) { food in
                            Button(action: {
//                                selectedBtn = food
                            }) {

                                ZStack{
                                    // Now 'food' can be treated as a Food instance

                                   
                                    if (selectedBtn == Food(color: food.color, name: food.name, size: food.size, unit: food.unit, gram: food.gram, calorie: food.calorie)) {
                                        Image("food_bg_focus")
                                    } else {
                                        Image("food_bg")
                                    }
                                    Text(food.name.prefix(1))
                                        .font(.system(size: 25))
                                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
//                                    Image(food.name).resizable().scaledToFit().frame(width: 45, height: 45)
                                }.padding(.leading, 10)
                                  
//                                    .gesture(
//                                    LongPressGesture(minimumDuration: 0.5)
//                                        .onEnded { _ in
//                                            addFoodType = true
//
//                                        }
//
//                                )

                            }.simultaneousGesture(
                                LongPressGesture()
                                    .onEnded { _ in
//                                        print("Loooong")
                                        editFoodType = food
//                                        addFoodType = true
                                    }
                            )
                            .highPriorityGesture(
                                TapGesture()
                                    .onEnded { _ in
                                       
                                            selectedBtn = Food(color: food.color, name: food.name, size: food.size, unit: food.unit, gram: food.gram, calorie: food.calorie)
                                        SoundPlayer.shared.playClickSound()
                                     
                                    }
                            )
                        }
                        
                        //自訂按鈕
                        Button(action: {
//                            selectedBtn = "custom"
                            addFoodType = true
                            SoundPlayer.shared.playClickSound()
                        }) {
                            ZStack{
                                Image("food_bg")
                                Image(systemName: "plus").resizable().scaledToFit().frame(width: 30).foregroundColor(Color(red: 220/255, green: 196/255, blue: 126/255))
                            }.padding(.leading, 10)

                        }
    
                    }.padding()
                }
                if ((selectedBtn != nil) && selectedBtn?.color == selectedIndex) {
                    AddFoodView(user: user, food: (selectedBtn)!)
                }
            }.background(Color(red: 238/255, green: 238/255, blue: 238/255))
            .onAppear {
                allFood = JSONFileManager.load("food.json")
            }
        }
        
    }
}

//struct FoodListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodListView(selectedIndex: .constant("紅"))
//    }
//}
