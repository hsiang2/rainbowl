//
//  RecordIView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/4/29.
//

import SwiftUI

struct FoodPlate {
    var color: String
    var name: String
}

@available(iOS 17.0, *)
struct RecordView: View {
    @Binding var isEarnedMoney: Bool
    let user: User
    @Binding var show: Bool
    @State private var selectedBtn: String = ""
    
    @State var addFoodType: Bool = false
    @State var editFoodType: FoodCustom?
    
     @StateObject var viewModel = FetchRecordViewModel(date: Date())
     
     let colors = ["紅", "橙", "黃", "綠", "紫", "白"]
     
     var records: [Record] {
         return selectedBtn == "" ? viewModel.records : viewModel.records.filter({
             $0.color.contains(selectedBtn)
         })
     }
    
    var plate: [FoodPlate] {
        var arr: [FoodPlate] = Array(repeating: FoodPlate(color: "", name: ""), count: 7)
        var fruitCount = 0
        var veggieCount = 0

        for record in records {
            if (record.category == "水果"  && fruitCount < 3) {
                let quantity = Int(min(record.qty, Float(3 - fruitCount)))
                for _ in 0..<quantity {
                    arr[fruitCount] = FoodPlate(color: record.color, name: record.name)
                    fruitCount += 1
                }
            } else if record.category == "蔬菜" && veggieCount < 4 {
                let quantity = Int(min(record.qty, Float(4 - veggieCount)))
                for _ in 0..<quantity {
                    arr[3 + veggieCount] = FoodPlate(color: record.color, name: record.name)
                    veggieCount += 1
                }
            }
            
            if fruitCount >= 3 && veggieCount >= 4 {
                break // Stop processing records if both fruit and veggie counts reach their limits
            }
        }
        return arr
    }
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255)
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    HStack {
                        if (selectedBtn != "" || addFoodType || (editFoodType != nil)) {
                            Button {
                                selectedBtn = ""
                                addFoodType = false
                                editFoodType = nil
                                SoundPlayer.shared.playClickSound()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 13)
                                    .padding()
                                    .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                            }
                        }
                        Spacer()
                        Button {
                            show = false
                            SoundPlayer.shared.playCloseSound()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding()
                                .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                        }
                    }.padding()
                    
                }
            if (addFoodType) {
                AddFoodTypeView(selectedIndex: $selectedBtn, addFoodType: $addFoodType)
                    .padding(.top, 60)
            } else if (editFoodType != nil) {
                EditFoodTypeView(food: editFoodType ?? nil, editFoodType: $editFoodType)
                
            } else {
                VStack {

                    ColorListView(user: user, selectedIndex: $selectedBtn)
                    if (selectedBtn == "") {
                        ZStack {
                            Image("餐盤底")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 332, height: 210)
                            Image("餐盤格_1")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 67)
                                .position(x: 65, y: 55)
                            Image("餐盤格_2")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 67)
                                .position(x: 165, y: 55)
                            Image("餐盤格_3")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 67)
                                .position(x: 250, y: 55)
                            Image("餐盤格_4")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .position(x: 52, y: 135)
                            Image("餐盤格_5")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .position(x: 130, y: 135)
                            Image("餐盤格_6")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .position(x: 200, y: 135)
                            Image("餐盤格_7")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .position(x: 270, y: 135)
                            
                            plateItemImage(food: plate[0])
                                .position(x: 65, y: 55)
                            
                            plateItemImage(food: plate[1])
                                .position(x: 160, y: 55)
                            
                            plateItemImage(food: plate[2])
                                .position(x: 255, y: 55)
                            
                            plateItemImage(food: plate[3])
                                .position(x: 52, y: 135)
                            
                            plateItemImage(food: plate[4])
                                .position(x: 125, y: 135)
                            
                            plateItemImage(food: plate[5])
                                .position(x: 202, y: 135)
                            
                            plateItemImage(food: plate[6])
                                .position(x: 272, y: 135)
                            

                        } .frame(width: 332, height: 210)
                        
                    }
                    
                    FoodListView(user: user, editFoodType: $editFoodType, selectedIndex: $selectedBtn, addFoodType: $addFoodType)
                    RecordItemView(records: records)
                   
                }.padding(.top, 60)
            }
           
        }.presentationDetents([.fraction(0.8)])
            .presentationCornerRadius(45)
            .onChange(of: records) {
                print(isPlateFull(), isEarnedMoney)
                if(isPlateFull() && !isEarnedMoney) {
                    AuthViewModel.shared.changeMoney(money: 50)
                    isEarnedMoney = true
                }
            }
        
    }
    
    private func isPlateFull() -> Bool {
             for food in plate {
                 if food.name.isEmpty {
                     return false
                 }
             }
             return true
         }
}

private func plateItemImage(food: FoodPlate) -> some View {
    let colors = ["紅", "橙", "黃", "綠", "紫", "白"]
    
    if (food.name == "") {
        return AnyView(
            EmptyView()
        )
    } else if (UIImage(named: food.name) != nil) {
        return AnyView(
            Image(food.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
        )
        
        } else {
            return AnyView(
                Text(food.name.prefix(1))
                    .foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255).opacity(0.6))
                    .frame(width: 40, height: 40)
                    .background(Color(red: COLORS[colors.firstIndex(of: food.color) ?? 0][0]/255, green: COLORS[colors.firstIndex(of: food.color) ?? 0][1]/255, blue: COLORS[colors.firstIndex(of: food.color) ?? 0][2]/255))
                    .cornerRadius(50)
            )
            
        }
}


//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView(show: .constant(true))
//    }
//}
