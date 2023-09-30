//
//  GameView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/22.
//

import SwiftUI

class CreaturePositionManager: ObservableObject {
    @Published var positions: [CreatureInUse: CGPoint] = [:]
}

//class CreatureOpacityManager: ObservableObject {
//    @Published var opacities: [CreatureInUse: Double] = [:]
//}

struct GameView: View {

    let user: User

    @State var currentScaleValue: CGFloat = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    
//    @State var showBin: Bool = false
    @State var showDelete: Bool = false
    
//    @State private var position = CGPoint(x: 0, y: 0)
    @StateObject private var positionManager = CreaturePositionManager()
//    @StateObject private var opacityManager = CreatureOpacityManager()


    @StateObject var viewModel = AuthViewModel()
    
//    @StateObject var bookViewModel = BookViewModel()


    var creatures: [CreatureInUse] {
        return viewModel.creatures
    }
    
//    var bookCreatures: [CreatureInBook] {
//        return bookViewModel.creatures.filter({
//            $0.status == "initial"
//        })
//    }

    var red: Float
    var orange: Float
    var yellow: Float
    var green: Float
    var purple: Float
    var white: Float

    init(user: User) {
        self.user = user
        self.red = user.red?.reduce(0) { $0 + $1 } ?? 0
        self.orange = user.orange?.reduce(0) { $0 + $1 } ?? 0
        self.yellow = user.yellow?.reduce(0) { $0 + $1 } ?? 0
        self.green = user.green?.reduce(0) { $0 + $1 } ?? 0
        self.purple = user.purple?.reduce(0) { $0 + $1 } ?? 0
        self.white = user.white?.reduce(0) { $0 + $1 } ?? 0
    }

    var body: some View {
        ZStack {
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                content
            }
            .ignoresSafeArea()
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
            if (showDelete) {
                Button(action: {
                    showDelete = false
                }) {
                    Text("完成")
                        .font(.headline)
                        .foregroundColor(Color(red: 247/255, green: 244/255, blue: 237/255))
                        .frame(width: 70, height: 48)
                        .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                        .cornerRadius(25)
                        .padding(.top, 70)
                }.offset(x: 145, y: -300)
            }
//            if(showBin) {
//
//                Image(systemName: "archivebox.circle.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50)
//                    .position(CGPoint(x: 200, y: 650))
//            }
            
        }
        
    }

    private var content: some View {
        ZStack {
            backgroundImage
            creatureViews
        }
        .scaleEffect(lastScaleValue + currentScaleValue >= 1 ? lastScaleValue + currentScaleValue : 1)
                .gesture(
                    MagnificationGesture()
                        .onChanged { newScale in
                            currentScaleValue = newScale
                        }
                        .onEnded { scale in
                            lastScaleValue = scale
                            currentScaleValue = 0
                        }
                )
            
        

    }

    private var backgroundImage: some View {
        ZStack {
            ZStack {
                Image("背景_黑白")
                Image("背景_藍")
                    .blendMode(.color)
                    .opacity(Double(purple))
                Image("背景_黃")
                    .blendMode(.color)
                    .opacity(Double(yellow))
                Image("背景_綠")
                    .blendMode(.color)
                    .opacity(Double(green))
            }
           
            ZStack {
                Image("樹_黑白")
                    .resizable().scaledToFit().frame(width: 180)
                Image("樹_橙")
                    .resizable().scaledToFit().frame(width: 180)
                    .blendMode(.color)
                    .opacity(Double(orange))
                Image("樹_綠")
                    .resizable().scaledToFit().frame(width: 180)
                    .blendMode(.color)
                    .opacity(Double(green))
            }.position(x: 1110, y: 550)
            ZStack {
                Image("鹿_黑白")
                    .resizable().scaledToFit().frame(width: 150)
                Image("鹿_橙")
                    .resizable().scaledToFit().frame(width: 150)
                    .blendMode(.color)
                    .opacity(Double(orange))
            }.position(x: 990, y: 650)
        }
        
    }

    @ViewBuilder private var creatureViews: some View {
//        ForEach(creatures.indices, id: \.self) { index in
//            let creature = creatures[index]
        
        ForEach(creatures, id: \.self) { creature in
            creatureItem(for: creature)
//            @State var position = CGPoint(x: 500, y: 500)
//
////            creatureView(for: creature)
//            ZStack {
//
//                Image("\(creature.name)_黑白")
//                    .resizable().scaledToFit().frame(width: CGFloat(creature.width))
//                ForEach(creature.colors, id: \.self) { color in
//                    colorView(for: creature, color: color)
//                }
//
//            }
//            //            .offset(x: position.x, y: position.y)
////            .position(position)
//            .position(position)
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        position = gesture.location
////                        viewModel.updateCreaturePosition(id: creature.id ?? "", x: Float(gesture.location.x), y: Float(gesture.location.y))
//
//                    }
//            )
            
//                .position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))

        }
    }
    
//    private func colorView(for creature: CreatureInUse, color: String, isColored: inout Bool)
    
    private func colorView(for creature: CreatureInUse, color: String) -> some View {
        let imageName: String
        let opacity: Double

        switch color {
        case "紅":
            imageName = "\(creature.name)_紅"
            opacity = Double(red)
//            if (isColored) {
//                isColored = red >= 1 ? true : false
//            }
            
        case "橙":
            imageName = "\(creature.name)_橙"
            opacity = Double(orange)
//            if (isColored) {
//                isColored = orange >= 1 ? true : false
//            }
        case "黃":
            imageName = "\(creature.name)_黃"
            opacity = Double(yellow)
//            if (isColored) {
//                isColored = yellow >= 1 ? true : false
//            }
        case "綠":
            imageName = "\(creature.name)_綠"
            opacity = Double(green)
//            if (isColored) {
//                isColored = green >= 1 ? true : false
//            }
        case "紫":
            imageName = "\(creature.name)_紫"
            opacity = Double(purple)
//            if (isColored) {
//                isColored = purple >= 1 ? true : false
//            }
        case "白":
            imageName = "\(creature.name)_白"
            opacity = Double(white)
//            if (isColored) {
//                isColored = white >= 1 ? true : false
//            }
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
//        @State var position = CGPoint(x: 500, y: 500)
        let initialPosition = CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0))
        let position = positionManager.positions[creature] ?? initialPosition
        
//        let opacity = opacityManager.opacities[creature] ?? 1
//        var isColored = true
        
        return AnyView(
            ZStack {

                Image("\(creature.name)_黑白")
                    .resizable().scaledToFit().frame(width: CGFloat(creature.width))
                ForEach(creature.colors, id: \.self) { color in
//                    colorView(for: creature, color: color, isColored: &isColored)
                    colorView(for: creature, color: color)
                }
                if (showDelete) {
                    Button(action: {
                        viewModel.deleteGame(id: creature.id ?? "", category: creature.category, name: creature.name, colors: creature.colors, width: creature.width)
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .resizable().scaledToFit().frame(width: 30)
                            .foregroundColor(Color(red: 168/255, green: 76/255, blue: 59/255))
                    }.offset(x: -50, y: -50)
                    
                }
                

            }
//                .opacity(opacity)
                .position(position)
                .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        showDelete = true
//                        showBin = true
//                        opacityManager.opacities[creature] = 0.5
                    }.sequenced(before: DragGesture()
                        .onChanged { gesture in
//                            position = gesture.location
                            
                                positionManager.positions[creature] = gesture.location
              
    //                        viewModel.updateCreaturePosition(id: creature.id ?? "", x: Float(gesture.location.x), y: Float(gesture.location.y))
    
                        }
                        .onEnded { _ in
                            
//                            showBin = false
                            
//                            opacityManager.opacities[creature] = 1
                            viewModel.updateCreaturePosition(id: creature.id ?? "", x: Float(positionManager.positions[creature]?.x ?? 0), y: Float(positionManager.positions[creature]?.y ?? 0))
                        }
                    )
                )
//                .onAppear {
//
//                    if (bookCreatures.contains {(bookCreature) -> Bool in
//                        bookCreature.name == creature.name}) {
//                        if (isColored) {
//
//                            bookViewModel.updateBook(name: creature.name)
//                        }
//                    }
//                }
                
            
        )
    
    }
    

//    private func creatureView(for creature: CreatureInUse) -> some View {
//        ZStack {
//            Image("\(creature.name)_黑白")
//                .resizable().scaledToFit().frame(width: CGFloat(creature.width))
//            ForEach(creature.colors, id: \.self) { color in
//                colorView(for: creature, color: color)
//            }
//        }
//    }

    
}


//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(user: user)
//    }
//}
