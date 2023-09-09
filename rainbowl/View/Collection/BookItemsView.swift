//
//  BookItemsView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/9/3.
//

import SwiftUI

struct BookItemsView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    var selectedCategory: String
    
    @State private var allCreature = [CreatureProduct]()
    
    var creatures: [CreatureProduct] {
        return allCreature.filter({
            $0.category.contains(selectedCategory)
        })
    }

//    @ObservedObject var viewModel = BackpackViewModel()
//    var creatures: [Creature] {
//        return viewModel.creatures.filter({
//                        $0.category.contains(selectedCategory)
//                    })
//    }
    
    
    var body: some View {
        VStack {
            LazyVGrid(columns: items, spacing: 2, content: {
                ForEach(creatures, id: \.self) { creature in
                    ZStack {
                        Image("box_bg")
                        Image("\(creature.name)_黑白")
                           .resizable().scaledToFit().frame(width: 70, height: 70)
                           .brightness(-1)
//                        Image("circle_bg")
//                            .offset(x: 43, y: 43)
                            
//                        Text("\(creature.qty)")
//                            .font(.system(size: 18))
//                            .offset(x: 43, y: 43)
//                            .foregroundColor(Color(red: 83/255, green: 94/255, blue: 49/255))
                    }.frame(width: width, height: width)
                        .onTapGesture {
//                            AuthViewModel.shared.addToGame(category: creature.category, name: creature.name, colors: creature.colors, width: creature.width)
                        }
                   
                }
            }).padding()
                .padding(.top, 90)
            Spacer()
        }.onAppear {
            allCreature = JSONFileManager.load("creature.json")
        }
        
        
    }
}

//struct BookItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookItemsView()
//    }
//}
