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
    
    var selectedCategory: String

    @ObservedObject var viewModel = BackpackViewModel()
    var creatures: [Creature] {
        return viewModel.creatures.filter({
                        $0.category.contains(selectedCategory)
                    })
    }
    
//    let tests = ["黑白鹿", "彩色鹿", "虎鯨_黑白", "樹_黑白"]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: items, spacing: 2, content: {
                ForEach(creatures, id: \.self) { creature in
                    ZStack {
                        Image("box_bg")
                        Image("\(creature.name)_黑白")
                           .resizable().scaledToFit().frame(width: 70, height: 70)
                        Image("circle_bg")
                            .offset(x: 43, y: 43)
                            
                        Text("\(creature.qty)")
                            .font(.system(size: 18))
                            .offset(x: 43, y: 43)
                            .foregroundColor(Color(red: 83/255, green: 94/255, blue: 49/255))
                    }.frame(width: width, height: width)
                        .onTapGesture {
                            AuthViewModel.shared.addToGame(category: creature.category, name: creature.name, colors: creature.colors, width: creature.width)
                        }
                   
                }
            }).padding()
                .padding(.top, 90)
            Spacer()
        }
        
        
    }
}

//struct ItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemsView()
//    }
//}
