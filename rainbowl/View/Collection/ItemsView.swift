//
//  ItemsView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import SwiftUI

struct ItemsView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    @State var deleteCreature:Creature?
    
    var selectedCategory: String

    @ObservedObject var backpackViewModel: BackpackViewModel
    var creatures: [Creature] {
        return backpackViewModel.creatures.filter({
                        $0.category.contains(selectedCategory)
                    })
    }
    var mode: String
    @Binding var targetCreature: Creature?
    @Binding var show: Bool?

    init(currentTab: Int = 0, selectedCategory: String = "", backpackViewModel: BackpackViewModel, mode: String, targetCreature: Binding<Creature?>?, show: Binding<Bool?>?) {
        self.selectedCategory = selectedCategory
        self.backpackViewModel = backpackViewModel
        self.mode = mode
        self._targetCreature = targetCreature ?? .constant(nil)
        self._show = show ?? .constant(nil)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: items, spacing: 2, content: {
                        ForEach(creatures, id: \.self) { creature in
                            ZStack {
                                Image("box_bg")
                                Image("\(creature.name)_彩色")
                                    .resizable().scaledToFit().frame(width: 70, height: 70).saturation(0)
                                Image("circle_bg")
                                    .offset(x: 43, y: 43)
                                
                                Text("\(creature.qty)")
                                    .font(.system(size: 18))
                                    .offset(x: 43, y: 43)
                                    .foregroundColor(Color(red: 83/255, green: 94/255, blue: 49/255))
                            }.frame(width: width, height: width)
                                .simultaneousGesture(
                                    LongPressGesture()
                                        .onEnded { _ in
                                            deleteCreature = creature
                                        }
                                )
                                .highPriorityGesture(
                                    TapGesture()
                                        .onEnded { _ in
                                        
                                        if (mode == "backpack") {
                                            backpackViewModel.addToGame(category: creature.category, name: creature.name, colors: creature.colors, width: creature.width, isMoving: creature.isMoving)
                                            show = false
                                        } else {
                                            targetCreature = creature
                                            show = false
                                            
                                        }
                                        
                                    }
                                )
                            
                        }
                    }).padding()
                        .padding(.top, 90)
                    Spacer()
                }
            }
            
            if ((deleteCreature) != nil) {
                VStack {
                    Text("是否永久刪除該動植物 ?")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 33/255, green: 15/255, blue: 17/255))
                        .padding(.bottom, 30)
                    HStack {
                        Button(action: {
                            deleteCreature = nil
                            SoundPlayer.shared.playClickSound()
                            
                        }) {
                            ZStack {
                                Image("按鈕_取消購買")
                                    .resizable()
                                    .scaledToFit()
                                Text("取消")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255))
                                    .padding(.bottom, 6)
                            }.frame(width: 126, height: 48)
                        }
                        Button(action: {
                            SoundPlayer.shared.playClickSound()
                            backpackViewModel.deleteBackpack(name: deleteCreature?.name ?? "")
                            deleteCreature = nil
                        }) {
                            ZStack {
                                Image("按鈕_確認購買")
                                    .resizable()
                                    .scaledToFill()
                                Text("移除")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255))
                                    .padding(.bottom, 6)
                            }.frame(width: 126, height: 48)
                        }
                    }
                }.frame(width: 343, height: 185)
                    .background(Color(red: 226/255, green: 218/255, blue: 219/255)).cornerRadius(34)
            }
        }
        
    }
}

//struct ItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemsView()
//    }
//}
