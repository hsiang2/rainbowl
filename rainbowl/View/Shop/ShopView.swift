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
    @ObservedObject var viewModel = BackpackViewModel()
    @ObservedObject var bookViewModel = BookViewModel()
    
    @State var animalShown = false
    @State var plantShown = false
    
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
                        }, label: {
                            ZStack{
                                Image("動物框")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 48)
                                Text("200").font(.system(size: 16)).foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255)).padding(.bottom, 6)
                            }
                        })
                        Button(action: {
                            plantShown = true
                        }, label: {
                            ZStack{
                                Image("植物框")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 48)
                                Text("200").font(.system(size: 16)).foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255)).padding(.bottom, 6)
                            }
                        })
                        
                    }.padding(.top, 60)
                }.padding(.top, 70)
            }.brightness(animalShown||plantShown ? -0.3 : 0)
            if (animalShown) {
                VStack {
                    Text("兌換一隻隨機動物 ?")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 33/255, green: 15/255, blue: 17/255))
                        .padding(.bottom, 30)
                    HStack {
                        Button(action: {
                            animalShown = false
                        }) {
                            Image("btn_cancel")
                                .resizable().scaledToFit().frame(width: 126)
                        }
                        Button(action: {
                            selectedCategory = "動物"
                            let randomCreature = creatures.randomElement()!
                            bookViewModel.addToBook(name: randomCreature.name)
                            viewModel.addToBackpack(category: randomCreature.category, name: randomCreature.name, colors: randomCreature.colors, width: randomCreature.width)
                            animalShown = false
                            
                        }) {
                            Image("btn_confirm")
                                .resizable().scaledToFit().frame(width: 126)
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
                    HStack {
                        Button(action: {
                            plantShown = false
                        }) {
                            Image("btn_cancel")
                                .resizable().scaledToFit().frame(width: 126)
                        }
                        Button(action: {
                            selectedCategory = "植物"
                            let randomCreature = creatures.randomElement()!
                            bookViewModel.addToBook(name: randomCreature.name)
                            viewModel.addToBackpack(category: randomCreature.category, name: randomCreature.name, colors: randomCreature.colors, width: randomCreature.width)
                            plantShown = false
                        }) {
                            Image("btn_confirm")
                                .resizable().scaledToFit().frame(width: 126)
                        }
                    }
                }.frame(width: 343, height: 185)
                    .background(Color(red: 226/255, green: 218/255, blue: 219/255)).cornerRadius(34)
            }
            
        }.onAppear {
            allcreatures = JSONFileManager.load("creature.json")
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(show: .constant(true))
    }
}
