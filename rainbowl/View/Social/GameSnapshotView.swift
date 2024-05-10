//
//  GameSnapshotView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

struct GameSnapshotView: View {
    @ObservedObject var socialViewModel: SocialViewModel
    
    let user: User
    

    @StateObject private var positionManager = CreaturePositionManager()

    @State private var creatures: [CreatureInUse] = []
    

    var red: Float
    var orange: Float
    var yellow: Float
    var green: Float
    var purple: Float
    var white: Float

    init(user: User, socialViewModel: SocialViewModel) {
        self.user = user
        self.socialViewModel = socialViewModel
        self.red = user.red?.reduce(0) { $0 + $1 } ?? 0
        self.orange = user.orange?.reduce(0) { $0 + $1 } ?? 0
        self.yellow = user.yellow?.reduce(0) { $0 + $1 } ?? 0
        self.green = user.green?.reduce(0) { $0 + $1 } ?? 0
        self.purple = user.purple?.reduce(0) { $0 + $1 } ?? 0
        self.white = user.white?.reduce(0) { $0 + $1 } ?? 0
    }

    var body: some View {
        ZStack {
            backgroundImage
            creatureViews
        }.onAppear {
            fetchCreatures()
        }
               
    }

    private var backgroundImage: some View {
        ZStack {
            ZStack {
                Image("背景_黑白")
                Image("背景_藍")
                    .opacity(Double(purple))
                Image("背景_黃")
                    .opacity(Double(yellow))
                Image("背景_綠")
                    .opacity(Double(green))
                Image("背景_白")
                    .opacity(Double(white))
            }
        }
        
    }

    @ViewBuilder private var creatureViews: some View {
        
        ForEach(creatures, id: \.self) { creature in
            creatureItem(for: creature)
        }
    }
    
    private func colorView(for creature: CreatureInUse, color: String) -> some View {
        let imageName: String
        let opacity: Double

        switch color {
        case "紅":
            imageName = "\(creature.name)_紅"
            opacity = Double(red)
            
        case "橙":
            imageName = "\(creature.name)_橙"
            opacity = Double(orange)

        case "黃":
            imageName = "\(creature.name)_黃"
            opacity = Double(yellow)
            
        case "綠":
            imageName = "\(creature.name)_綠"
            opacity = Double(green)

        case "紫":
            imageName = "\(creature.name)_紫"
            opacity = Double(purple)

        case "白":
            imageName = "\(creature.name)_白"
            opacity = Double(white)

        default:
            return AnyView(EmptyView())
        }

        return AnyView( Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: CGFloat(creature.width))
            .blendMode(.color)
            .opacity(opacity)

        )
    }
    
    private func creatureItem(for creature: CreatureInUse) -> some View {
        let initialPosition = CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0))
        
        return AnyView(
            ZStack {

                Image("\(creature.name)_彩色")
                    .resizable().scaledToFit().frame(width: CGFloat(creature.width)).saturation(0)
                ForEach(creature.colors, id: \.self) { color in
                    colorView(for: creature, color: color)
                }
            }
                .zIndex(Double(creature.locationY ?? 1))
                .position(initialPosition)
            
        )
    }
    func fetchCreatures() {
            socialViewModel.fetchCreatures(uid: user.id ?? "") { fetchedCreatures in
                self.creatures = fetchedCreatures
            }
        }
}
