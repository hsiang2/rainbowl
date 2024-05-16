//
//  ShopView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/6.
//

import SwiftUI

struct ShopView: View {
    @Binding var show: Bool
    @State private var selectedCategory: String = ""
    @State private var allcreatures = [CreatureProduct]()
    @ObservedObject var backpackViewModel: BackpackViewModel
    @ObservedObject var bookViewModel = BookViewModel()
    
    @State var animalShown = false
    @State var plantShown = false
    
    @State var buyAnimalSucceed = false
    @State var buyPlantSucceed = false
    
    @State var showCongratulatoryMessage = false
    @State var showImage = false
    
    @State var name = ""
    
    @State var moneyWarnShown = false
    
    var creatures: [CreatureProduct] {
        return allcreatures.filter({
            $0.category.contains(selectedCategory)
        })
    }
    
    
    var body: some View {
        ZStack {
            ZStack{
                Color(red: 223/255, green: 202/255, blue: 197/255)
                    .ignoresSafeArea()
                    .overlay(alignment: .topTrailing) {
                        Button {
                            show = false
                            SoundPlayer.shared.playCloseSound()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding()
                                .foregroundColor(Color(red: 239/255, green: 239/255, blue: 239/255)).padding()
                                
                        }
                    }
                VStack {
                    
                    Image("對話框")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 175)
                        .padding(.trailing, 150)
                        
                    Image("送子鳥")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    HStack(spacing: 20) {
                        Button(action: {
                            animalShown = true
                            SoundPlayer.shared.playClickSound()
                        }, label: {
                            ZStack{
                                Image("動物框")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 48)
                                Text("200").font(.system(size: 16, weight: .medium)).foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255)).padding(.leading, 8).padding(.bottom, 6)
                            }
                        })
                        Button(action: {
                            plantShown = true
                            SoundPlayer.shared.playClickSound()
                        }, label: {
                            ZStack{
                                Image("植物框")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 48)
                                Text("200").font(.system(size: 16, weight: .medium)).foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255)).padding(.leading, 8).padding(.bottom, 6)
                            }
                        })
                        
                    }.padding(.top, 60)
                }.padding(.top, 70)
            }.brightness(animalShown || plantShown ? -0.3 : 0)
            if (animalShown) {
                VStack {
                    Text("兌換一隻隨機動物 ?")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 33/255, green: 15/255, blue: 17/255))
                        .padding(.bottom, 30)
                    
                    if (moneyWarnShown) {
                        Text("！餘額不足")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 180/255, green: 84/255, blue: 93/255))
                            .padding(.top, -30)
                    }
                    
                    HStack {
                        Button(action: {
                            animalShown = false
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
                            if (AuthViewModel.shared.currentUser?.money ?? 0 >= 200) {
                                
                                selectedCategory = "動物"
                                let randomCreature = creatures.randomElement()!
//                                let randomCreature = creatures[13]
                                bookViewModel.addToBook(name: randomCreature.name)
                                backpackViewModel.addToBackpack(category: randomCreature.category, name: randomCreature.name, colors: randomCreature.colors, width: randomCreature.width, isMoving: randomCreature.isMoving, friend: nil)
                                animalShown = false
                                
                                name = randomCreature.name
                                buyAnimalSucceed = true
                                
                                AuthViewModel.shared.changeMoney(money: -200)
                            } else {
                                moneyWarnShown = true
                            }
                            
                        }) {
                            ZStack {
                                Image("按鈕_確認購買")
                                    .resizable()
                                    .scaledToFit()
                                HStack {
                                    Text("200")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255))
                                    Image("彩虹幣")
                                }.padding(.leading, 14)
                               
                                    .padding(.bottom, 5)
                            }.frame(width: 126, height: 48)
                        }
                    }
                }.frame(width: 343, height: 185)
                    .background(Color(red: 226/255, green: 218/255, blue: 219/255)).cornerRadius(34)
            }
            if (plantShown) {
                VStack {
                    Text("兌換一個隨機植物 ?")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 33/255, green: 15/255, blue: 17/255))
                        .padding(.bottom, 30)
                    if (moneyWarnShown) {
                        Text("！餘額不足")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 180/255, green: 84/255, blue: 93/255))
                            .padding(.top, -30)
                    }
                    HStack {
                        Button(action: {
                            plantShown = false
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
                            if (AuthViewModel.shared.currentUser?.money ?? 0 >= 200) {
                                selectedCategory = "植物"
                                let randomCreature = creatures.randomElement()!
//                                                            let randomCreature = creatures[12]
                                bookViewModel.addToBook(name: randomCreature.name)
                                backpackViewModel.addToBackpack(category: randomCreature.category, name: randomCreature.name, colors: randomCreature.colors, width: randomCreature.width, isMoving: randomCreature.isMoving, friend: nil)
                                plantShown = false
                                
                                name = randomCreature.name
                                buyPlantSucceed = true
                                
                                AuthViewModel.shared.changeMoney(money: -200)
                            } else {
                                moneyWarnShown = true
                            }
                        }) {
                            ZStack {
                                Image("按鈕_確認購買")
                                    .resizable()
                                    .scaledToFit()
                                HStack {
                                    Text("200")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255))
                                    Image("彩虹幣")
                                }.padding(.leading, 14)
                               
                                    .padding(.bottom, 5)
                            }.frame(width: 126, height: 48)
                        }
                    }
                }.frame(width: 343, height: 185)
                    .background(Color(red: 226/255, green: 218/255, blue: 219/255)).cornerRadius(34)
            }
            
            if(buyAnimalSucceed || buyPlantSucceed) {
                ZStack{
                    Color(red: 0/255, green: 0/255, blue: 0/255)
                        .opacity(0.6)
                        .ignoresSafeArea()
                        .overlay(alignment: .topTrailing) {
                            Button {
                                buyAnimalSucceed = false
                                buyPlantSucceed = false
                                name = ""
                                showCongratulatoryMessage = false
                                SoundPlayer.shared.playCloseSound()
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding()
                                    .foregroundColor(Color(red: 239/255, green: 239/255, blue: 239/255)).padding()
                            }
                        }.onAppear {
                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                                withAnimation(.easeIn(duration: 0.5)) { // Apply the animation with `withAnimation`
                                    showImage = true
                                }
                            }
                        }.onTapGesture {
                            buyAnimalSucceed = false
                            buyPlantSucceed = false
                            name = ""
                            showCongratulatoryMessage = false
                            SoundPlayer.shared.playCloseSound()
                        }
                    ZStack{
                        
                        if (showImage) {
                            
                            Image(buyPlantSucceed ? "送子鳥_植物": "送子鳥_動物")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .transition(.move(edge: .bottom))
                                .offset(y: showImage ? 0 : UIScreen.main.bounds.height)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                                        withAnimation(.easeIn(duration: 0.5)) { // Apply the animation with `withAnimation`
                                            showImage = false
                                            showCongratulatoryMessage = true
                                        }
                                    }
                                }
                        }
                        
                        if (showCongratulatoryMessage) {
                            
                            VStack {
                                Image(buyPlantSucceed ? "恭喜獲得植物" : "恭喜獲得動物")
                                    .resizable().scaledToFit().frame(width: 230)
                                ZStack {
                                    Image("selected")
                                    Image("\(name)_彩色")
                                        .resizable().scaledToFit().frame(width: 170, height: 170).saturation(0)
                                    
                                }
                                .onAppear {
                                    SoundPlayer.shared.playSucceedSound()
                                }
                            }
                        }
                        
                    }
                }
            }
            
        }.onAppear {
            allcreatures = JSONFileManager.load("creature.json")
        }
    }
}

//struct ShopView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopView(show: .constant(true))
//    }
//}
