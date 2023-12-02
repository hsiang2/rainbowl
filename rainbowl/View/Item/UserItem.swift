//
//  UserItem.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

struct UserItem: View {
    let user: User
        
        var body: some View {
            VStack {
//                KFImage(URL(string: user.profileImageUrl))
//                Image("刺蝟_彩色")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 48, height: 48)
//                    .clipShape(Circle())
                GameSnapshotView(user: user)
                    .frame(width: 2358, height: 1825)
                    .cornerRadius(350)
                    .scaleEffect(0.12)
                    .frame(height: 250)
//                    .padding(0)
//                    .scaledToFit()
//                    .padding(.bottom, -100)
//
                HStack {
                    Image("蛋")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(user.username)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 87/255, green: 87/255, blue: 87/255))
    //                    Text(user.fullname)
    //                        .font(.system(size: 14))
                    }.padding(.leading, 10)
//                    .padding(.bottom, 50)
                    Spacer()
                }.padding(.leading, 50)
                

            
            }.padding(.bottom, 30)
        }
//            HStack {
////                KFImage(URL(string: user.profileImageUrl))
//                Image("刺蝟_彩色")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 48, height: 48)
//                    .clipShape(Circle())
//
//                VStack(alignment: .leading) {
//                    Text(user.username)
//                        .font(.system(size: 14, weight: .semibold))
////                    Text(user.fullname)
////                        .font(.system(size: 14))
//                }
//                Spacer()
//            }
        }


//struct UserItem_Previews: PreviewProvider {
//    static var previews: some View {
//        UserItem()
//    }
//}
