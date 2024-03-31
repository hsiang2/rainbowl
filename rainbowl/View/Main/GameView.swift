//
//  GameView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/22.
//

import SwiftUI
import UIKit
import AVFoundation

//struct ImageSequenceView: View {
//    var imageNames: [String]
//    var duration: Double
//
//    @State private var currentImageIndex: Int = 0
//
//    var body: some View {
//        Image(imageNames[currentImageIndex])
//            .resizable()
//            .scaledToFit()
//            .onAppear {
//                let timer = Timer.scheduledTimer(withTimeInterval: duration / Double(imageNames.count), repeats: true) { _ in
//                    withAnimation {
//                        currentImageIndex = (currentImageIndex + 1) % imageNames.count
//                    }
//                }
//                RunLoop.current.add(timer, forMode: .common)
//            }
//    }
//}

import ImageIO



struct GifView: UIViewRepresentable {
    var imageName: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
//        imageView.frame = CGRect(
//          x: 0, y: 0, width: 10, height: 10)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        if let gifURL = Bundle.main.url(forResource: imageName, withExtension: "gif"),
           let imageData = try? Data(contentsOf: gifURL),
           let source = CGImageSourceCreateWithData(imageData as CFData, nil) {

            let images = (0..<CGImageSourceGetCount(source)).compactMap {
                CGImageSourceCreateImageAtIndex(source, $0, nil)
            }

            let uiImages = images.map { UIImage(cgImage: $0) }

            uiView.animationImages = uiImages
            uiView.animationDuration = TimeInterval(uiImages.count) * 0.1
            uiView.animationRepeatCount = 0 // 0 for infinite loop, adjust as needed

            // Set the frame with the given width, preserving the aspect ratio
//            uiView.frame.size.width = 0
//            uiView.sizeToFit()

            uiView.startAnimating()
        }
    }
}






class CreaturePositionManager: ObservableObject {
    @Published var positions: [CreatureInUse: CGPoint] = [:]
}

class CreatureDirectionManager: ObservableObject {
    @Published var directions: [CreatureInUse: Int] = [:]
}

//class CreatureOpacityManager: ObservableObject {
//    @Published var opacities: [CreatureInUse: Double] = [:]
//}

@available(iOS 17.0, *)
struct GameView: View {

    let user: User

    @State var currentScaleValue: CGFloat = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    
    @State var showDelete: Bool = false
    
    
    @StateObject private var positionManager = CreaturePositionManager()
    @StateObject private var directionManager = CreatureDirectionManager()
//    @StateObject private var opacityManager = CreatureOpacityManager()


    @StateObject var viewModel = AuthViewModel()
    
    @ObservedObject var backpackViewModel: BackpackViewModel
    
    
    @State var looper: AVPlayerLooper?
    
<<<<<<< HEAD

=======
>>>>>>> main
    var creatures: [CreatureInUse] {
        return viewModel.creatures
    }

    var red: Float
    var orange: Float
    var yellow: Float
    var green: Float
    var purple: Float
    var white: Float

    init(user: User, backpackViewModel: BackpackViewModel) {
        self.backpackViewModel = backpackViewModel
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
//                ViewControllerWrapper()
            }
            .defaultScrollAnchor(.center)
            .ignoresSafeArea()
            .onAppear {
                UIScrollView.appearance().bounces = false
                
                let musicplayer = AVQueuePlayer()
                let fileUrl = Bundle.main.url(forResource: "bgmusic", withExtension: "mp3")!
                let item = AVPlayerItem(url: fileUrl)
                self.looper = AVPlayerLooper(player: musicplayer, templateItem: item)
                musicplayer.volume = 0.3
                musicplayer.play()
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
            
//            if (showDelete) {
//                Button(action: {
//                    showDelete = false
//                }) {
//                    
//                    Text("完成")
//                        .font(.headline)
//                        .foregroundColor(Color(red: 247/255, green: 244/255, blue: 237/255))
//                        .frame(width: 70, height: 48)
//                        .background(Color(red: 187/255, green: 129/255, blue: 111/255))
//                        .cornerRadius(25)
//                        .shadow(color: Color(red: 54/255, green: 64/255, blue: 89/255).opacity(0.5), radius: 2, x: 3, y: 3)
//                        .padding(.top, 70)
//                    
//                }.offset(x: 145, y: -300)
//            }
            
                Button(action: {
<<<<<<< HEAD
                    showDelete = !showDelete
=======
                    showDelete = false
                    SoundPlayer.shared.playClickSound()
>>>>>>> main
                }) {
                    if (!showDelete) {
                        Text("編輯")
                            .font(.headline)
                            .foregroundColor(Color(red: 247/255, green: 244/255, blue: 237/255))
                            .frame(width: 70, height: 48)
                            .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                            .cornerRadius(25)
                            .shadow(color: Color(red: 54/255, green: 64/255, blue: 89/255).opacity(0.5), radius: 2, x: 3, y: 3)
                            .padding(.top, 70)
                    }
                    else {
                        Text("完成")
                            .font(.headline)
                            .foregroundColor(Color(red: 247/255, green: 244/255, blue: 237/255))
                            .frame(width: 70, height: 48)
                            .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                            .cornerRadius(25)
                            .shadow(color: Color(red: 54/255, green: 64/255, blue: 89/255).opacity(0.5), radius: 2, x: 3, y: 3)
                            .padding(.top, 70)
                    }
                }.offset(x: 145, y: -300)
            
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
//                Image("背景_黑白")
                Image("背景_藍")
//                    .blendMode(.color)
                    .saturation(Double(purple))
                Image("背景_黃")
//                    .blendMode(.color)
                    .saturation(Double(yellow))
                Image("背景_綠")
//                    .blendMode(.color)
                    .saturation(Double(green))
                Image("背景_白")
//                    .blendMode(.color)
                    .saturation(Double(white))
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

        return AnyView( 
            
//            Image(imageName)
//            .resizable()
//            .scaledToFit()
//            .frame(width: CGFloat(creature.width))
//            .saturation(opacity)
            //下面不用
//            .blendMode(.color)
//            .opacity(opacity)
            
            GifView(imageName: "\(imageName)")
                .scaleEffect(x: CGFloat(directionManager.directions[creature] ?? 1), y: 1)
                .frame(width: CGFloat(creature.width), height: CGFloat(creature.width))
                .saturation(opacity)
                
//                .scaleEffect(x: directionManager.directions[creature] ?? true ? 1 : -1 , y: 1)
            
//                .scaleEffect(x: CGFloat(directionManager.directions[creature] ?? 1), y: 1)
        )
    }
    

//    private func creatureAnimationView(for creature: CreatureInUse) -> some View {
//            let imageNames = (0...2).map { "\(creature.name)\($0)" } // Adjust the range based on the number of frames
//
//            return ImageSequenceView(imageNames: imageNames, duration: 1.0)
//                .frame(width: CGFloat(creature.width))
//        }
    
    private func creatureItem(for creature: CreatureInUse) -> some View {
        let initialPosition = CGPoint(x: Double(creature.locationX ?? 0), y: Double(creature.locationY ?? 0))
        let position = positionManager.positions[creature] ?? initialPosition
        
        
        
//        let opacity = opacityManager.opacities[creature] ?? 1
        
        return AnyView(
            ZStack {
//                creatureAnimationView(for: creature)
//                GifView(imageName: "\(creature.name)")
//                    .frame(width: CGFloat(creature.width), height: CGFloat(creature.width))
//                    .saturation(0)
//                ForEach(creature.colors, id: \.self) { color in
//                                   colorView(for: creature, color: color)
//                               }

//
//                Image("\(creature.name)_彩色")
//                    .resizable().scaledToFit().frame(width: CGFloat(creature.width)).saturation(0)
                ForEach(creature.colors, id: \.self) { color in
                    colorView(for: creature, color: color)
                }
                if (showDelete) {
                    Button(action: {
                        backpackViewModel.deleteGame(id: creature.id ?? "", category: creature.category, name: creature.name, colors: creature.colors, width: creature.width)
                        SoundPlayer.shared.playClickSound()
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .resizable().scaledToFit().frame(width: 30)
                            .foregroundColor(Color(red: 168/255, green: 76/255, blue: 59/255))
                    }.offset(x: -50, y: -50)
                    
                }
                

            }
//                .opacity(opacity)
                .position(position)
<<<<<<< HEAD
//                .scaleEffect(x: directionManager.directions[creature] ?? true ? 1 : -1, y: 1)
=======
>>>>>>> main
                .zIndex(Double(creature.locationY ?? 1))
                .gesture(
                   
                        LongPressGesture(minimumDuration: 0.5)
        //                    .onEnded { _ in
        //                        if (!showDelete) {
        //                            showDelete = true
        //
        //                        }
        //
        ////                        opacityManager.opacities[creature] = 0.5
        //                    }
                            .sequenced(before: DragGesture()
                                .onChanged { gesture in
                                    positionManager.positions[creature] = gesture.location
                                }
                                .onEnded { _ in
        //                            opacityManager.opacities[creature] = 1
                                    viewModel.updateCreaturePosition(id: creature.id ?? "", x: Float(positionManager.positions[creature]?.x ?? 0), y: Float(positionManager.positions[creature]?.y ?? 0))
                                }
                            )
                        
                
                )
                .allowsHitTesting(showDelete)
            //下面這段正常
//                .onAppear {
////                           updateAnimation(for: creature, at: position)
//                    if creature.category == "動物" {
//                            withAnimation(
//                                Animation.linear(duration: 2) // Adjust duration as needed
//                                    .repeatForever(autoreverses: true)
//                            ) {
//                                positionManager.positions[creature] = CGPoint(x: position.x + 50, y: position.y)
//                            }
//                    }
//                }
            //目前
                .onChange(of: showDelete, initial: true) { oldValue, newValue in
//                           updateAnimation(for: creature, at: position)
              
                    if creature.category == "動物" {
//                        if !newValue {
                        startAnimation(for: creature, at: position, initialPosition: initialPosition)
                            
//                        } 
                       
//                            withAnimation(
//                                Animation.linear(duration: 5) // Adjust duration as needed
//                                    .repeatForever(autoreverses: true)
//                            ) {
//                                
//                               
//                                positionManager.positions[creature] = CGPoint(x: position.x + CGFloat(creature.width), y: position.y)
////                                withAnimation(
////                                    Animation.linear(duration: 0.1) // Adjust duration as needed
////                                        .repeatForever()
////                                ) {
////                                    directionManager.directions[creature] =  directionManager.directions[creature] ?? true ? false:true
////                                }
//                            }
                           

//                        }  
//                        else {
//                            withAnimation(
//                                Animation.linear(duration: 0) // Adjust duration as needed
//                            ) {
//                               
//                                    positionManager.positions[creature] = CGPoint(x: position.x + CGFloat(creature.width), y: position.y)
//                                positionManager.positions[creature] = initialPosition
//
//                               
//                               
//                            }
                        }
                   
            }
        )
    }
    
    func startAnimation(for creature: CreatureInUse, at position: CGPoint, initialPosition: CGPoint) {
        
        if !showDelete {
            withAnimation(
             Animation.linear(duration: 5)
 //            .repeatForever(autoreverses: true)
            ) {
 //               isAnimating = true
                positionManager.positions[creature] = CGPoint(x: position.x + CGFloat(creature.width) * CGFloat(directionManager.directions[creature] ?? 1), y: position.y)
                
            } completion: {
                // After 5 seconds, change state without animation
                directionManager.directions[creature] =  (directionManager.directions[creature] ?? 1) * -1
                
                startAnimation(for: creature, at: position, initialPosition: initialPosition)
                // Pause animation if needed
 //               isPaused = true
 //               // Resume animation after 1 second (adjust as needed)
 //               DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
 //                   isPaused = false
 //                   // Repeat the process
 //                   startAnimation()
 //               }
            }
        } else {
            withAnimation(
                 Animation.linear(duration: 0) // Adjust duration as needed
             ) {

                 positionManager.positions[creature] = CGPoint(x: position.x + CGFloat(creature.width) * CGFloat(directionManager.directions[creature] ?? 1), y: position.y)
                 positionManager.positions[creature] = initialPosition



             }
        }
         
        
       }
    
    

//    private func updateAnimation(for creature: CreatureInUse, at position: CGPoint) {
//        if creature.category == "動物" {
//            if showDelete {
//                // If showDelete is true, set the initial position without animation
//                positionManager.positions[creature] = position
//            } else {
//                // If showDelete is false, animate the right-left motion
//                withAnimation(
//                    Animation.linear(duration: 2) // Adjust duration as needed
//                        .repeatForever(autoreverses: true)
////                        .delay(2) // Delay before starting the animation
//                ) {
//                    // Update the creature's position for right-left motion
//                    positionManager.positions[creature] = CGPoint(x: position.x + 50, y: position.y)
//                }
//            }
//        }
//    }





//    private func newPositionX(for creature: CreatureInUse) -> Double {
//        let currentX = positionManager.positions[creature]?.x ?? 0
//        let distance: Double = 50 // Adjust the distance as needed
//        return currentX + distance
//    }
    
}


//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(user: user)
//    }
//}
