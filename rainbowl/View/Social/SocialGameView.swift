//
//  SocialGameView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

@available(iOS 17.0, *)
struct SocialGameView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = SearchUserViewModel()
    
    let user: User

    @State var currentScaleValue: CGFloat = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    

    @StateObject private var positionManager = CreaturePositionManager()


//    @StateObject var viewModel = AuthViewModel()


    var creatures: [CreatureInUse] {
        viewModel.fetchCreatures(uid: user.id ?? "")
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
//        ZStack {
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
                
            }
            .defaultScrollAnchor(.center)
//            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        HStack {
                            Image("\(user.avatar)_彩色")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 19, height: 19)
                                .frame(width: 35, height: 35)
                                .background(Color(red: COLORS[user.avatarColor][0]/255, green: COLORS[user.avatarColor][1]/255, blue: COLORS[user.avatarColor][2]/255))
                                .clipShape(Circle())
                            Text(user.username)
                                .font(.headline)
                                .foregroundColor(Color(red: 129/255, green: 117/255, blue: 87/255))
                                .padding(.leading, 15)
                            Spacer()
                        }.frame(width: 150)
                            .background(Color(red: 241/255, green: 239/255, blue: 234/255))
                            .cornerRadius(50)
        
                            .shadow(color: Color(red: 54/255, green: 64/255, blue: 89/255).opacity(0.5), radius: 2, x: 3, y: 3)
                        
                        Spacer()
                        Button(action: {
                            dismiss()
                            SoundPlayer.shared.playClickSound()
                        }) {
                            Text("返回")
                                .font(.headline)
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 80, height: 35)
                                .background(Color(red: 184/255, green: 175/255, blue: 153/255))
                                .cornerRadius(50)
                                .shadow(color: Color(red: 54/255, green: 64/255, blue: 89/255).opacity(0.5), radius: 2, x: 3, y: 3)
//                            Image(systemName: "xmark")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 20)
//                                .padding()
//                                .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255)).padding()
                        }
                    }
//                    .padding(.top, 30)
                }
            }.toolbarBackground(.hidden, for: .navigationBar)
//            Button {
//                show = false
//            } label: {
//                Image(systemName: "arrowshape.backward.circle.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20)
//                    .padding()
//                    .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255)).padding()
//
//            }
//        }
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
//        let position = positionManager.positions[creature] ?? initialPosition
        
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
}




//struct SocialGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        SocialGameView()
//    }
//}
