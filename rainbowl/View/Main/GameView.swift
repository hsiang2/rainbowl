//
//  GameView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/22.
//

import SwiftUI
//
//struct GameView: View {
//
//    let user: User
//
//    @State var currentScaleValue: CGFloat = 0.0
//    @State var lastScaleValue: CGFloat = 1.0
//
//    @ObservedObject var viewModel = AuthViewModel()
//
//    @State var viewState = CGSize.zero
//
//
//
//    var creatures: [CreatureInUse] {
//        return viewModel.creatures
//    }
//
//    var red: Float
//    var orange: Float
//    var yellow: Float
//    var green: Float
//    var purple: Float
//    var white: Float
//
//    init(user: User) {
//        self.user = user
//        self.red = user.red?.reduce(0) { $0 + $1 } ?? 0
//        self.orange = user.orange?.reduce(0) { $0 + $1 } ?? 0
//        self.yellow = user.yellow?.reduce(0) { $0 + $1 } ?? 0
//        self.green = user.green?.reduce(0) { $0 + $1 } ?? 0
//        self.purple = user.purple?.reduce(0) { $0 + $1 } ?? 0
//        self.white = user.white?.reduce(0) { $0 + $1 } ?? 0
//    }
//
//    var body: some View {
//        ScrollView([.horizontal, .vertical], showsIndicators: false) {
//            content
//        }
//        .ignoresSafeArea()
//        .onAppear {
//            UIScrollView.appearance().bounces = false
//        }
//        .onDisappear {
//            UIScrollView.appearance().bounces = true
//        }
//    }
//
//    private var content: some View {
//        ZStack {
//            backgroundImage
//            creatureViews
//        }
//        .scaleEffect(lastScaleValue + currentScaleValue >= 1 ? lastScaleValue + currentScaleValue : 1)
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
//
//    }
//
//    private var backgroundImage: some View {
//        ZStack {
//            Image("背景_黑白")
//            Image("背景_藍")
//                .blendMode(.color)
//                .opacity(Double(purple))
//            Image("背景_黃")
//                .blendMode(.color)
//                .opacity(Double(yellow))
//            Image("背景_綠")
//                .blendMode(.color)
//                .opacity(Double(green))
//        }
//    }
//
//    @ViewBuilder private var creatureViews: some View {
//        ForEach(creatures.indices, id: \.self) { index in
//            let creature = creatures[index]
//
//
////            creatureView(for: creature)
//            ZStack {
//                Image("\(creature.name)_黑白")
//                    .resizable().scaledToFit().frame(width: CGFloat(creature.width))
//                ForEach(creature.colors, id: \.self) { color in
//                    colorView(for: creature, color: color)
//                }
//            }
////                .position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))
//            .offset(x: viewState.width, y: viewState.height)
//                        .gesture(
//////                            LongPressGesture().onEnded.sequenced(before: DragGesture(coordinateSpace: .global).onChanged { value in
//////                                viewState = value.translation
//////                            })
////                            DragGesture(coordinateSpace: .global).onChanged { value in
////                               viewState = value.translation
////                           }
////                            .onEnded { value in
////                                withAnimation(.spring()) {
////                                    viewState = .zero
////                                }
////                            }
//                            LongPressGesture(minimumDuration: 0.1).onEnded {_ in
//                            }.sequenced(before: DragGesture(coordinateSpace: .global).onChanged { value in
//                                viewState = value.translation }.onEnded { value in
//                                    withAnimation(.spring()) {
//                                        viewState = .zero
//                                    }
//                                }
//                        ))
//
//        }
//    }
//
////    private func creatureView(for creature: CreatureInUse) -> some View {
////        ZStack {
////            Image("\(creature.name)_黑白")
////                .resizable().scaledToFit().frame(width: CGFloat(creature.width))
////            ForEach(creature.colors, id: \.self) { color in
////                colorView(for: creature, color: color)
////            }
////        }
////    }
//
//    private func colorView(for creature: CreatureInUse, color: String) -> some View {
//        let imageName: String
//        let opacity: Double
//
//        switch color {
//        case "紅":
//            imageName = "\(creature.name)_紅"
//            opacity = Double(red)
//        case "橙":
//            imageName = "\(creature.name)_橙"
//            opacity = Double(orange)
//        case "黃":
//            imageName = "\(creature.name)_黃"
//            opacity = Double(yellow)
//        case "綠":
//            imageName = "\(creature.name)_綠"
//            opacity = Double(green)
//        case "紫":
//            imageName = "\(creature.name)_紫"
//            opacity = Double(purple)
//        case "白":
//            imageName = "\(creature.name)_白"
//            opacity = Double(white)
//        default:
//            return AnyView(EmptyView())
//        }
//
//        return AnyView( Image(imageName)
//            .resizable()
//            .scaledToFit()
//            .frame(width: CGFloat(creature.width))
//            .blendMode(.color)
//            .opacity(opacity)
//
//        )
//    }
//}

class CreaturePositionManager: ObservableObject {
    @Published var positions: [CreatureInUse: CGPoint] = [:]
}

class CreatureOpacityManager: ObservableObject {
    @Published var opacities: [CreatureInUse: Double] = [:]
}

struct GameView: View {

    let user: User

    @State var currentScaleValue: CGFloat = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    
//    @State private var position = CGPoint(x: 0, y: 0)
    @StateObject private var positionManager = CreaturePositionManager()
    @StateObject private var opacityManager = CreatureOpacityManager()


    @StateObject var viewModel = AuthViewModel()


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
//        @State var position = CGPoint(x: 500, y: 500)
        let initialPosition = CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0))
        let position = positionManager.positions[creature] ?? initialPosition
        
        let opacity = opacityManager.opacities[creature] ?? 1
        
        
//        init(_ creature: CreatureInUse) {
//            self.position = position
//            self.creature = creature
//        }
        
        return AnyView(
            ZStack {

                Image("\(creature.name)_黑白")
                    .resizable().scaledToFit().frame(width: CGFloat(creature.width))
                ForEach(creature.colors, id: \.self) { color in
                    colorView(for: creature, color: color)
                }

            }.opacity(opacity)
                .position(position)
                .gesture(
                LongPressGesture(minimumDuration: 0.5) // Adjust the duration as needed
                    .onEnded { _ in
                        opacityManager.opacities[creature] = 0.5
                        // Set isLongPressing to true to enable dragging
                    }.sequenced(before: DragGesture()
                        .onChanged { gesture in
//                            position = gesture.location
          
                                positionManager.positions[creature] = gesture.location
              
                           
    //                        viewModel.updateCreaturePosition(id: creature.id ?? "", x: Float(gesture.location.x), y: Float(gesture.location.y))
    
                        }
                        .onEnded { _ in
                            opacityManager.opacities[creature] = 1
                            viewModel.updateCreaturePosition(id: creature.id ?? "", x: Float(positionManager.positions[creature]?.x ?? 0), y: Float(positionManager.positions[creature]?.y ?? 0))
                        }
                    )
            )
            
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

//struct GameView: View {
//
//    let user: User
//
//    @State var currentScaleValue: CGFloat = 0.0
//    @State var lastScaleValue: CGFloat = 1.0
//
//    @ObservedObject var viewModel = AuthViewModel()
//
////    @GestureState var longPressTap = false
////    @State var isPressed = false
//    @State private var isLongPressing: [CreatureInUse: Bool] = [:] // Track long-press state for each creature
//
//    @State private var dragOffsets: [CreatureInUse: CGSize] = [:]
//    @State private var isDragging: [CreatureInUse: Bool] = [:]
//
//    var creatures: [CreatureInUse] {
//        return viewModel.creatures
//    }
//
//    var red: Float
//    var orange: Float
//    var yellow: Float
//    var green: Float
//    var purple: Float
//    var white: Float
//
//    init(user: User) {
//        self.user = user
//        self.red = user.red?.reduce(0) { $0 + $1 } ?? 0
//        self.orange = user.orange?.reduce(0) { $0 + $1 } ?? 0
//        self.yellow = user.yellow?.reduce(0) { $0 + $1 } ?? 0
//        self.green = user.green?.reduce(0) { $0 + $1 } ?? 0
//        self.purple = user.purple?.reduce(0) { $0 + $1 } ?? 0
//        self.white = user.white?.reduce(0) { $0 + $1 } ?? 0
//    }
//
//    var body: some View {
//        ScrollView([.horizontal, .vertical], showsIndicators: false) {
//            content
//        }
//        .ignoresSafeArea()
//        .onAppear {
//            UIScrollView.appearance().bounces = false
//        }
//        .onDisappear {
//            UIScrollView.appearance().bounces = true
//        }
//    }
//
//    private var content: some View {
//        ZStack {
//            backgroundImage
//            creatureViews
//        }
//        .scaleEffect(lastScaleValue + currentScaleValue >= 1 ? lastScaleValue + currentScaleValue : 1)
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
//
//    }
//
//    private var backgroundImage: some View {
//        ZStack {
//            Image("背景_黑白")
//            Image("背景_藍")
//                .blendMode(.color)
//                .opacity(Double(purple))
//            Image("背景_黃")
//                .blendMode(.color)
//                .opacity(Double(yellow))
//            Image("背景_綠")
//                .blendMode(.color)
//                .opacity(Double(green))
//        }
//    }
//
//    @ViewBuilder private var creatureViews: some View {
//        ForEach(creatures.indices, id: \.self) { index in
//            let creature = creatures[index]
//            VStack{
//                creatureView(for: creature)
//            }
////            ZStack {
////                Image("\(creature.name)_黑白")
////                    .resizable().scaledToFit().frame(width: CGFloat(creature.width))
////                ForEach(creature.colors, id: \.self) { color in
////                    colorView(for: creature, color: color)
////                }
////
////            }
////                .position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))
////                .onLongPressGesture {
////                    // Handle the long press action here
////                    handleLongPress(for: creature)
////                }
//
////            if(isPressed) {
////                Button(action: {
////
////                }) {
////                    Text("Delete")
////                }
////            }
//
//        }
//    }
//    private func creatureView(for creature: CreatureInUse) -> some View {
//        let longPress = LongPressGesture(minimumDuration: 0.5)
//            .onChanged { _ in
//                isLongPressing[creature] = true
//            }
//
//           return ZStack {
//
//                   Image("\(creature.name)_黑白")
//                       .resizable()
//                       .scaledToFit()
//                       .frame(width: CGFloat(creature.width))
//
//                   ForEach(creature.colors, id: \.self) { color in
//                       colorView(for: creature, color: color)
//                   }
//
//               if isLongPressing[creature] == true {
//                          Button(action: {
//                              // Button action
//                          }) {
//                              Image(systemName: "trash")
//                          }
//                          .foregroundColor(.red)
//                          .position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))
//                      }
//           }.position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))
//            .gesture(longPress) // Add the long-press gesture to the creature view
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        if isDragging[creature] == true {
//                            dragOffsets[creature] = value.translation
//                        }
//                    }
//                    .onEnded { value in
//                        if isDragging[creature] == true {
//                            dragOffsets[creature] = .zero
//                        }
//                    }
//            )
//            .offset(dragOffsets[creature] ?? .zero)
//       }
////
////    private func creatureView(for creature: CreatureInUse) -> some View {
////        ZStack {
////            Image("\(creature.name)_黑白")
////                .resizable().scaledToFit().frame(width: CGFloat(creature.width))
////            ForEach(creature.colors, id: \.self) { color in
////                colorView(for: creature, color: color)
////            }
////        }
////    }
//
//    private func colorView(for creature: CreatureInUse, color: String) -> some View {
//        let imageName: String
//        let opacity: Double
//
//        switch color {
//        case "紅":
//            imageName = "\(creature.name)_紅"
//            opacity = Double(red)
//        case "橙":
//            imageName = "\(creature.name)_橙"
//            opacity = Double(orange)
//        case "黃":
//            imageName = "\(creature.name)_黃"
//            opacity = Double(yellow)
//        case "綠":
//            imageName = "\(creature.name)_綠"
//            opacity = Double(green)
//        case "紫":
//            imageName = "\(creature.name)_紫"
//            opacity = Double(purple)
//        case "白":
//            imageName = "\(creature.name)_白"
//            opacity = Double(white)
//        default:
//            return AnyView(EmptyView())
//        }
//
//        return AnyView( Image(imageName)
//            .resizable()
//            .scaledToFit()
//            .frame(width: CGFloat(creature.width))
//            .blendMode(.color)
//            .opacity(opacity)
//
//        )
//    }
//}


//import SwiftUI
//
//struct GameView: View {
//    @State private var isEditMode = false
//
//    let user: User
//
//    @State var currentScaleValue: CGFloat = 0.0
//    @State var lastScaleValue: CGFloat = 1.0
//
//    @ObservedObject var viewModel = AuthViewModel()
//
//    @State private var location: CGPoint = .zero
////        @GestureState var locationState = CGPoint(x: 100, y: 100)
////    @State var location = CGPoint(x: 1050, y: 650)
//    var creatures: [CreatureInUse] {
//        return viewModel.creatures
//    }
//
//    @State private var draggedCreatureIndex: Int?
//
//
//    var red: Float
//    var orange: Float
//    var yellow: Float
//    var green: Float
//    var purple: Float
//    var white: Float
//
//    init(user: User) {
//        self.user = user
//        self.red = user.red?.reduce(0) { $0 + $1 } ?? 0
//        self.orange = user.orange?.reduce(0) { $0 + $1 } ?? 0
//        self.yellow = user.yellow?.reduce(0) { $0 + $1 } ?? 0
//        self.green = user.green?.reduce(0) { $0 + $1 } ?? 0
//        self.purple = user.purple?.reduce(0) { $0 + $1 } ?? 0
//        self.white = user.white?.reduce(0) { $0 + $1 } ?? 0
//    }
//
//    var body: some View {
//        ScrollView([.horizontal, .vertical], showsIndicators: false) {
//            content
//        }
//        .ignoresSafeArea()
//        .onAppear {
//            UIScrollView.appearance().bounces = false
//        }
//        .onDisappear {
//            UIScrollView.appearance().bounces = true
//        }
//    }
//
//    private var doneButton: some View {
//        Button(action: {
//            isEditMode = false
//        }) {
//            Text("Done")
//                .font(.headline)
//                .foregroundColor(.blue)
//                .padding()
//        }
//    }
//
//    private var content: some View {
//        ZStack {
//            backgroundImage
//            creatureViews
//            if isEditMode {
//                doneButton
//                    .offset(x: 0, y: 50) // Adjust the position of the "Done" button as needed
//            }
//        }
//        .scaleEffect(lastScaleValue + currentScaleValue >= 1 ? lastScaleValue + currentScaleValue : 1)
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
////        .scaleEffect(scale, anchor: .center)
////        .gesture(
////            MagnificationGesture()
////                .onChanged { scale in
////                        self.scale = min(max(scale.magnitude, 0.5), 2.0)
////                    }
//////                .onEnded { scale in
//////                    lastScaleValue = scale
//////                    currentScaleValue = 0
//////                }
////        )
//    }
//
//    private var backgroundImage: some View {
//        ZStack {
//            Image("背景_黑白")
//            Image("背景_藍")
//                .blendMode(.color)
//                .opacity(Double(purple))
//            Image("背景_黃")
//                .blendMode(.color)
//                .opacity(Double(yellow))
//            Image("背景_綠")
//                .blendMode(.color)
//                .opacity(Double(green))
//        }
//    }
//
//    private func makeLongPressGesture() -> some Gesture {
//        LongPressGesture(minimumDuration: 0.5)
//            .onEnded { _ in
//                isEditMode.toggle()
//            }
//    }
//    private var creatureViews: some View {
//        ForEach(creatures.indices, id: \.self) { index in
//            let creature = creatures[index]
//            let isDragging = index == draggedCreatureIndex
//
//            creatureView(for: creature)
//                .position(CGPoint(x: CGFloat(creature.locationX ?? 0), y: CGFloat(creature.locationY ?? 0)))
//
//        }
//    }
//
//
////    @ViewBuilder private var creatureViews: some View {
////        ForEach(creatures.indices, id: \.self) { index in
////            let creature = creatures[index]
////            let isDragging = index == draggedCreatureIndex
////
////            creatureView(for: creature)
////                .position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))
//
////            creatureView(for: creature)
////            ZStack {
////                Image("\(creature.name)_黑白")
////                    .resizable().scaledToFit().frame(width: CGFloat(creature.width))
////                ForEach(creature.colors, id: \.self) { color in
////                    self.colorView(for: creature, color: color)
////                }
////            }
////            .position(CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0)))
////                .position(location)
////                .gesture(
////                    DragGesture(
////                          minimumDistance: 200,
////                          coordinateSpace: .global
////                      )
////                          .onChanged { value in
////                              self.location = value.location
////                          }
////                          .onEnded { value in
////                              withAnimation {
////                                  self.location = CGPoint(x: 100, y: 100)
////
////                              }
////                          }
////                          .updating(
////                              self.$locationState
////                          ) { currentState, pastLocation, transaction  in
////                              pastLocation = currentState.location
////                              transaction.animation = .easeInOut
////                          }
////                )
////
////        }
////    }
//
//    private func creatureView(for creature: CreatureInUse) -> some View {
//        ZStack {
//            Image("\(creature.name)_黑白")
//                .resizable()
//                .scaledToFit()
//                .frame(width: CGFloat(creature.width))
//            ForEach(creature.colors, id: \.self) { color in
//                colorView(for: creature, color: color)
//            }
//            if isEditMode {
//                Button(action: {
//                    // Handle delete button action
//                    viewModel.deleteGame(id: creature.id ?? "", category: creature.category, name: creature.name, colors: creature.colors, width: creature.width)
//                }) {
//                    Image(systemName: "xmark.circle.fill")
//                        .font(.title)
//                        .foregroundColor(.red)
//                }
//                .buttonStyle(PlainButtonStyle())
//                .frame(width: 32, height: 32)
//                .offset(x: CGFloat(creature.locationX ?? 0), y: CGFloat(creature.locationY ?? 0))
//            }
//        }
//        .opacity(draggedCreatureIndex != nil ? 0.5 : 1.0) // Reduce opacity when dragging
//        .simultaneousGesture(
//            DragGesture(coordinateSpace: .global)
//                    .onChanged { gesture in
//                        // Update the draggedCreatureIndex to the current creature's index
//                        draggedCreatureIndex = creatures.firstIndex(where: { $0.id == creature.id })
//
//                        // Update the location of the dragged creature based on the drag gesture
//                        location = gesture.location
//                    }
//                    .onEnded { gesture in
//                        draggedCreatureIndex = nil
//
//                        // Calculate the new position of the creature based on the drag gesture
//                        let newPosition = CGPoint(x: CGFloat(creature.locationX ?? 0) + gesture.translation.width, y: CGFloat( creature.locationY ?? 0) + gesture.translation.height)
//
//                        // Update the creature's position using the view model
//                        viewModel.updateCreaturePosition(id: creature.id ?? "", x: Float(newPosition.x), y: Float(newPosition.y))
//                    }
//            ).simultaneousGesture(makeLongPressGesture())
//
//    }
//
//
//
////    private func creatureView(for creature: CreatureInUse) -> some View {
////
////
////        return AnyView( ZStack {
////            Image("\(creature.name)_黑白")
////                .resizable().scaledToFit().frame(width: CGFloat(creature.width))
////            ForEach(creature.colors, id: \.self) { color in
////                self.colorView(for: creature, color: color)
////            }
////        }
////
////        )
////    }
//
//    private func colorView(for creature: CreatureInUse, color: String) -> some View {
//        let imageName: String
//        let opacity: Double
//
//        switch color {
//        case "紅":
//            imageName = "\(creature.name)_紅"
//            opacity = Double(red)
//        case "橙":
//            imageName = "\(creature.name)_橙"
//            opacity = Double(orange)
//        case "黃":
//            imageName = "\(creature.name)_黃"
//            opacity = Double(yellow)
//        case "綠":
//            imageName = "\(creature.name)_綠"
//            opacity = Double(green)
//        case "紫":
//            imageName = "\(creature.name)_紫"
//            opacity = Double(purple)
//        case "白":
//            imageName = "\(creature.name)_白"
//            opacity = Double(white)
//        default:
//            return AnyView(EmptyView())
//        }
//
//        return AnyView( Image(imageName)
//            .resizable()
//            .scaledToFit()
//            .frame(width: CGFloat(creature.width))
//            .blendMode(.color)
//            .opacity(opacity)
//
//        )
//    }
//}

    
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
