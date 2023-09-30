//
//  RecordIView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/4/29.
//

import SwiftUI

struct RecordView: View {
    let user: User
    @Binding var show: Bool
    @State private var selectedBtn: String = ""
    
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255)
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    HStack {
                        if (selectedBtn != "") {
                            Button {
                                selectedBtn = ""
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 13)
                                    .padding()
                                    .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                            }
                        }
                        Spacer()
                        Button {
                            show = false
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding()
                                .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                        }
                    }.padding()
                    
                }
//            ScrollView(.vertical) {
            VStack {

                ColorListView(user: user, selectedIndex: $selectedBtn)
                FoodListView(user: user, selectedIndex: $selectedBtn)
                RecordItemView(selectedIndex: $selectedBtn)
               
            }.padding(.top, 60)
        }.presentationDetents([.fraction(0.8)])
        
    }
}

//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView(show: .constant(true))
//    }
//}
