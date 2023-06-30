//
//  GameView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/22.
//


import SwiftUI

struct GameView: View {
    
    let user: User
    
    @State var currentScaleValue: CGFloat = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    
    @ObservedObject var viewModel = AuthViewModel()
    //    @GestureState var locationState = CGPoint(x: 100, y: 100)
    @State var location = CGPoint(x: 1050, y: 650)
    var creatures: [CreatureInUse] {
        return viewModel.creatures
    }
    
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
    }
    
    private var creatureViews: some View {
        ForEach(creatures, id: \.self) { creature in
            ZStack {
                Image("\(creature.name)_黑白")
                    .resizable().scaledToFit().frame(width: CGFloat(creature.width))
                ForEach(creature.colors, id: \.self) { color in
                    self.creatureView(for: creature, color: color)
                }
            }.position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))
        }
    }

    private func creatureView(for creature: CreatureInUse, color: String) -> some View {
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
}

    
//    var body: some View {
//        ScrollView([.horizontal, .vertical], showsIndicators: false)
//        {
//            ZStack {
//                ZStack {
//                    Image("背景_黑白")
//                    Image("背景_藍")
//                        .blendMode(.color)
//                        .opacity(Double(purple))
//                    Image("背景_黃")
//                        .blendMode(.color)
//                        .opacity(Double(yellow))
//                    Image("背景_綠")
//                        .blendMode(.color)
//                        .opacity(Double(green))
//                }
//                ForEach(creatures, id: \.self) { creature in
//
//                    ZStack {
//                        Image("\(creature.name)_黑白")
//                            .resizable().scaledToFit().frame(width: CGFloat(creature.width))
//                        ForEach(creature.colors, id: \.self) { color in
//                            switch color {
//
//                            case "紅":
//                                Image("\(creature.name)_紅")
//                                   .resizable()
//                                   .scaledToFit()
//                                   .frame(width: CGFloat(creature.width))
//                                   .blendMode(.color)
//                                   .opacity(Double(red))
//                            case "橙":
//                                Image("\(creature.name)_橙")
//                                   .resizable()
//                                   .scaledToFit()
//                                   .frame(width: CGFloat(creature.width))
//                                   .blendMode(.color)
//                                   .opacity(Double(orange))
//                            case "黃":
//                                Image("\(creature.name)_黃")
//                                   .resizable()
//                                   .scaledToFit()
//                                   .frame(width: CGFloat(creature.width))
//                                   .blendMode(.color)
//                                   .opacity(Double(yellow))
//                            case "綠":
//                                Image("\(creature.name)_綠")
//                                   .resizable()
//                                   .scaledToFit()
//                                   .frame(width: CGFloat(creature.width))
//                                   .blendMode(.color)
//                                   .opacity(Double(orange))
//                            case "紫":
//                                Image("\(creature.name)_紫")
//                                   .resizable()
//                                   .scaledToFit()
//                                   .frame(width: CGFloat(creature.width))
//                                   .blendMode(.color)
//                                   .opacity(Double(purple))
//                            case "白":
//                                Image("\(creature.name)_白")
//                                   .resizable()
//                                   .scaledToFit()
//                                   .frame(width: CGFloat(creature.width))
//                                   .blendMode(.color)
//                                   .opacity(Double(white))                            default:
//                                break
//                            }
////                            Image("\(creature.name)_\(color)")
////                               .resizable()
////                               .scaledToFit()
////                               .frame(width: CGFloat(creature.width))
////                               .blendMode(.color)
////                               .opacity(Double(orange))
//                        }
//                    }.position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))
//                }
//
//
//
////                ZStack {
////                    Image("鹿_黑白")
////                        .resizable().scaledToFit().frame(width: 150)
////                    Image("鹿_橙")
////                       .resizable()
////                       .scaledToFit()
////                       .frame(width: 150)
////                       .blendMode(.color)
////                       .opacity(Double(orange))
////                }
////                .position(location)
////                    .gesture(
////                        DragGesture(
////                            minimumDistance: 200,
////                            coordinateSpace: .local
////                        )
////                            .onChanged { value in
////                                self.location = value.location
////                            }
////                            .onEnded { value in
////                                withAnimation {
////                                    self.location = CGPoint(x: 100, y: 100)
////
////                                }
////                            }
////                            .updating(
////                                self.$locationState
////                            ) { currentState, pastLocation, transaction  in
////                                pastLocation = currentState.location
////                                transaction.animation = .easeInOut
////                            }
////
////                    )
//
//            }.scaleEffect(lastScaleValue + currentScaleValue >= 1 ? lastScaleValue + currentScaleValue : 1)
//                .gesture(
//                    MagnificationGesture()
//                        .onChanged { newScale in
//                            currentScaleValue = newScale
//                        }
//                        .onEnded { scale in
//                            lastScaleValue = scale
//                            currentScaleValue = 0
//                        }
//                )
//        }.ignoresSafeArea()
//
//            .onAppear {
//                UIScrollView.appearance().bounces = false
//
//            }
//            .onDisappear {
//                UIScrollView.appearance().bounces = true
//            }
//
//
//
//
//    }


//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(user: user)
//    }
//}
