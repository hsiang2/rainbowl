//
//  BookItemsView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/9/3.
//

import SwiftUI

class StatusManager: ObservableObject {
    @Published var status: [CreatureProduct: String] = [:]
}

struct BookItemsView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    var selectedCategory: String
    
    @State private var allCreature = [CreatureProduct]()
    
    @ObservedObject var viewModel = BookViewModel()
    
    @StateObject private var statusManager = StatusManager()
    
    var creatures: [CreatureProduct] {
        return allCreature.filter({
            $0.category.contains(selectedCategory)
        })
    }
    
    var bookCreatures: [CreatureInBook] {
        return viewModel.creatures
    }
    
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: items, spacing: 2, content: {
                    ForEach(creatures, id: \.self) { creature in
                        creatureItem(for: creature)
                    }
                }).padding()
                    .padding(.top, 90)
                Spacer()
            }
        }
        .onAppear {
            allCreature = JSONFileManager.load("creature.json")
        }
    }
    
    private func creatureItem(for creature: CreatureProduct) -> some View {
        var status = "locked"
        if let i = bookCreatures.firstIndex(where: {$0.name == creature.name}) {
            status = bookCreatures[i].status
        } else {
            status = "locked"
        }
        
        return AnyView(
            ZStack {
                Image("box_bg")
                Image("\(creature.name)_彩色")
                   .resizable().scaledToFit().frame(width: 70, height: 70)
                   .saturation(status == "completed" ? 1 : 0)
                   .brightness(status == "locked" ? -1 : 0)
                   .opacity(status == "locked" ? 0.8 : 1)
            }.frame(width: width, height: width)
                .onTapGesture {
                }
        )
    }
}

//struct BookItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookItemsView()
//    }
//}
