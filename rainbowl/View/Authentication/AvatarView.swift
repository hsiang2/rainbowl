//
//  AvatarView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/2.
//

import SwiftUI

struct AvatarView: View {
    @Binding var show: Bool
    
    @Binding var avatar: String
    @Binding var avatarColor: Int
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    @ObservedObject var viewModel = BookViewModel()
    
    
    var bookCreatures: [String] {
        let creatures = viewModel.creatures
            .filter({$0.status.contains("completed")})
        return ["蛋", "草苗"] + creatures.map { $0.name }
        
    }
    
    var body: some View {
        ZStack {
            Color(red: 225/255, green: 232/255, blue: 234/255)
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    Button {
                        show = false
                        SoundPlayer.shared.playCloseSound()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding()
                            .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255)).padding()
                    }
                }
            ScrollView {
                HStack {
                    Text("選擇頭像底色")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 59/255, green: 65/255, blue: 60/255))
                        .padding(.leading, 40)
                        .padding(.top, 10)
                    Spacer()
                }
                
                HStack {
                    Circle().frame(width: 50)
                        .foregroundColor(Color(red: COLORS[0][0]/255, green: COLORS[0][1]/255, blue: COLORS[0][2]/255))
                        .overlay(Circle().stroke(Color(red: 89/255, green: 89/255, blue: 89/255), lineWidth: 5).opacity(avatarColor == 0 ? 0.6 : 0)
                        )
                        .onTapGesture {
                            avatarColor = 0
                        }
                    Circle().frame(width: 50)
                        .foregroundColor(Color(red: COLORS[1][0]/255, green: COLORS[1][1]/255, blue: COLORS[1][2]/255))
                        .overlay(Circle().stroke(Color(red: 89/255, green: 89/255, blue: 89/255), lineWidth: 5).opacity(avatarColor == 1 ? 0.6 : 0)
                        )
                        .onTapGesture {
                            avatarColor = 1
                        }
                    Circle().frame(width: 50)
                        .foregroundColor(Color(red: COLORS[2][0]/255, green: COLORS[2][1]/255, blue: COLORS[2][2]/255))
                        .overlay(Circle().stroke(Color(red: 89/255, green: 89/255, blue: 89/255), lineWidth: 5).opacity(avatarColor == 2 ? 0.6 : 0)
                        )
                        .onTapGesture {
                            avatarColor = 2
                        }
                    Circle().frame(width: 50)
                        .foregroundColor(Color(red: COLORS[3][0]/255, green: COLORS[3][1]/255, blue: COLORS[3][2]/255))
                        .overlay(Circle().stroke(Color(red: 89/255, green: 89/255, blue: 89/255), lineWidth: 5).opacity(avatarColor == 3 ? 0.6 : 0)
                        )
                        .onTapGesture {
                            avatarColor = 3
                        }
                    Circle().frame(width: 50)
                        .foregroundColor(Color(red: COLORS[4][0]/255, green: COLORS[4][1]/255, blue: COLORS[4][2]/255))
                        .overlay(Circle().stroke(Color(red: 89/255, green: 89/255, blue: 89/255), lineWidth: 5).opacity(avatarColor == 4 ? 0.6 : 0)
                        )
                        .onTapGesture {
                            avatarColor = 4
                        }
                    Circle().frame(width: 50)
                        .foregroundColor(Color(red: COLORS[5][0]/255, green: COLORS[5][1]/255, blue: COLORS[5][2]/255))
                        .overlay(Circle().stroke(Color(red: 89/255, green: 89/255, blue: 89/255), lineWidth: 5).opacity(avatarColor == 5 ? 1 : 0)
                        )
                        .onTapGesture {
                            avatarColor = 5
                        }
                }.padding(.top, 30)
                .padding(.bottom, 30)
                HStack {
                    Text("選擇頭像圖案")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 59/255, green: 65/255, blue: 60/255))
                        .padding(.leading, 40)
                        .padding(.top, 10)
                    Spacer()
                }
                ScrollView {
                    VStack {
                        LazyVGrid(columns: items, spacing: 2, content: {
                            ForEach(bookCreatures, id: \.self) { creature in
                                Image("\(creature)_彩色")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .frame(width: 110, height: 110)
                                    .background(Color(red: COLORS[avatarColor][0]/255, green: COLORS[avatarColor][1]/255, blue: COLORS[avatarColor][2]/255))
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color(red: 89/255, green: 89/255, blue: 89/255), lineWidth: 5).opacity(avatar == creature ? 0.6 : 0)
                                    )
                                    .frame(width: width, height: width)
                                    .onTapGesture {
                                        avatar = creature
                                    }
                            }
                        }).padding()
                        Spacer()
                    }
                }
            }.padding(.top, 60)
        }.presentationDetents([.fraction(0.8)])
        
    }
    
}


//struct AvatarView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvatarView(show: .constant(true))
//    }
//}
