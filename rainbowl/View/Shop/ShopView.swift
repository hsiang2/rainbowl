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
    
    var creatures: [CreatureProduct] {
        return allcreatures.filter({
            $0.category.contains(selectedCategory)
        })
    }
    
    
    var body: some View {
        ZStack {
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
                        selectedCategory = "動物"
                        let randomCreature = creatures.randomElement()!
                        viewModel.addToBackpack(category: randomCreature.category, name: randomCreature.name, colors: randomCreature.colors, width: randomCreature.width)
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
