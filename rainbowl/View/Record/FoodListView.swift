//
//  ColorContentView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/1.
//

import SwiftUI

struct FoodListView: View {
    @Binding var selectedIndex: String
    @State private var selectedBtn: Food?
    
    @State private var allFood = [Food]()
    
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
                        ForEach(food, id: \.self) { food in
                            Button(action: {
                                selectedBtn = food
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
                        Button(action: {
//                            selectedBtn = "custom"
                        }) {
                            ZStack{
                                Image("food_bg")
                                Image(systemName: "plus").resizable().scaledToFit().frame(width: 30).foregroundColor(Color(red: 220/255, green: 196/255, blue: 126/255))
                            }.padding(.leading, 10)

                        }
    
                    }.padding()
                }
                if ((selectedBtn != nil) && selectedBtn?.color == selectedIndex) {
                    AddFoodView(food: (selectedBtn)!)
                }
            }.background(Color(red: 238/255, green: 238/255, blue: 238/255))
            .onAppear {
                allFood = JSONFileManager.load("food.json")
            }
        }
        
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(selectedIndex: .constant("紅"))
    }
}
