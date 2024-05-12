//
//  KnowledgeView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/5/11.
//

import SwiftUI

@available(iOS 17.0, *)
struct KnowledgeView: View {
    @State private var allKnowledge = [Knowledge]()
    @Binding var show: Bool
    var body: some View {
        ZStack {
            Color(red: 253/255, green: 252/255, blue: 248/255)
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
            ScrollView(showsIndicators: false) {
                Text("蔬果知識")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color(red: 66/255, green: 59/255, blue: 58/255))
                    .padding(.bottom, 22)
                Text("攝取各種如彩虹一樣繽紛的天然蔬果，為身體補充不同的營養素，維持健康")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(red: 89/255, green: 89/255, blue: 89/255))
                    .padding(.bottom, 34)
                    .padding(.horizontal, 24)
                
                ForEach(allKnowledge, id: \.self) { knowledgeItem in
                    KnowledgeItemView(knowledgeData: knowledgeItem)
                        .scrollTransition { content, phase in
                                       content
                                           .opacity(phase.isIdentity ? 1 : 0)
                                           .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                   }
                        .padding(.bottom, 32)
                }
            }.padding(.top, 70)
                
        }.onAppear {
            allKnowledge = JSONFileManager.load("knowledge.json")
        }
        
    }
}

//#Preview {
//    KnowledgeView()
//}
