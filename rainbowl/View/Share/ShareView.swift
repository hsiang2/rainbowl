//
//  ShareView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/2/2.
//

import SwiftUI

@available(iOS 17.0, *)
struct ShareView: View {
    let user: User
    @Binding var show: Bool
    @ObservedObject var socialViewModel: SocialViewModel
    
    @State private var renderedImage = Image(systemName: "")
        @Environment(\.displayScale) var displayScale
    
    @State private var fetchedCreatures: [CreatureInUse] = []

    var body: some View {
        ZStack {
            Color(red: 236/255, green: 246/255, blue: 245/255)
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
                            .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                            .padding()
                        
                    }
                }
            VStack {
                renderedImage
                ShareLink(item: renderedImage, preview: SharePreview(Text("RAINBOWL"), image: renderedImage)) {
                    ZStack {
                      Image("按鈕_分享")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 126)
                        Text("分享")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.bottom, 6)
                    }
                        
                    .padding(.top, 68.8)
                }
            }
           

        }.onAppear {
            fetchAndRender()
        }
    }
    func fetchAndRender() {
            fetchCreatures { creatures in
                renderImage(with: creatures)
            }
        }
    func fetchCreatures(completion: @escaping ([CreatureInUse]) -> Void) {
           socialViewModel.fetchCreatures(uid: user.id ?? "") { result in
               completion(result)
           }
       }
    
    struct RenderedImageView: View {
        let user: User
        let creatures: [CreatureInUse]
        
        var body: some View {
            ZStack{
                Image("截圖背景").resizable().scaledToFit().frame(width: 332)
                GameScreenshotView(user: user, creatures: creatures) .scaleEffect(0.12)
                    .scaledToFit()
                    .foregroundStyle(
                        .shadow(
                            .inner(color: Color(red: 4/255, green: 4/255, blue: 4/255).opacity(0.16), radius: 5.3)
                        )
                    )
                    .padding(.bottom, 21)

            }.frame(width: 332, height: 305)
        }
    }

    func renderImage(with creatures: [CreatureInUse]) {
        let renderedImageView = RenderedImageView(user: user, creatures: creatures)
        
        let renderer = ImageRenderer(content: renderedImageView)
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            renderedImage = Image(uiImage: uiImage)
        }
    }
}

//#Preview {
//    ShareView(show: .constant(true))
//}
