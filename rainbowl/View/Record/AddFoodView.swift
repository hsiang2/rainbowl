//
//  AddFoodView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/20.
//
import SwiftUI

struct AddFoodView: View {
    var food: Food
    let user: User
    @State var qty: Float = 1
    @ObservedObject var viewModel = RecordViewModel()
    
    @StateObject var recordsViewModel = FetchRecordViewModel(date: Date())
    
    @StateObject var authViewModel = AuthViewModel()
    
    init(user: User, food: Food) {
        self.food = food
        self.user = user
    }

    
    var body: some View {
        
        VStack {
            HStack {
                Text(food.name).font(.system(size: 20, weight: .medium)).foregroundColor(Color(red: 120/255, green: 97/255, blue: 61/255))
                Text("\(String(format: "%g", qty)) 份\(food.name) =  \(String(format: "%g", food.size * qty)) \(food.unit) = \(String(format: "%g", food.gram * qty))g")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 87/255, green: 87/255, blue: 87/255)).opacity(0.62)
                    .padding(.leading, 20)
                Spacer()
            }
            HStack {
                HStack {
                    Button {
                        if (qty > 0) {
                            qty -= 0.5
                        }
                    } label: {
                        Text("-")
                            .font(.system(size: 35, weight: .heavy))
                            .padding()
                            .foregroundColor(Color(red: 179/255, green: 201/255, blue: 192/255))
                    }
                    Text(String(format: "%g", qty))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 59/255, green: 65/255, blue: 60/255)).opacity(0.69)
                    Button {
                            qty += 0.5
                    } label: {
                        Text("+")
                            .font(.system(size: 25, weight: .heavy))

                            .padding()
                            .foregroundColor(Color(red: 179/255, green: 201/255, blue: 192/255))
                    }
                }
                Spacer()
                Button {
                    viewModel.addRecord(name: food.name, color: food.color, calorie: food.calorie * qty, qty: qty, records: recordsViewModel.records) { error in
                        qty = 1
                        
                        if let error = error {
                            print("Error adding record: \(error.localizedDescription)")
                        }
                                 
                    }
                    
                } label: {
                    Text("確認")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255))
                        .frame(width: 85, height: 30)
                        .background(Color(red: 188/255, green: 209/255, blue: 208/255))
                        .cornerRadius(9)
                }
            }
        }.padding(.horizontal, 40)
            .padding(.vertical, 20)
        
//            .onReceive(currentColors.publisher) { newCurrentColors in
//                    // Call the function to handle updates
//                    handleCurrentColorsUpdate()
//                }
        
    }

}
    
    //struct AddFoodView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        AddFoodView( food: Food(
    //            color: "黃",
    //            name: "香蕉",
    //            image: "香蕉",
    //            size: 0.5,
    //            unit: "根",
    //            gram: 70,
    //            calorie: 60
    //        )
    //    )
    //    }
    //}
