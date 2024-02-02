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
    
    @State private var renderedImage = Image(systemName: "photo")
        @Environment(\.displayScale) var displayScale

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
                            .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                            .padding()
                        
                    }
                }
        
            renderedImage
//                .frame(width: 2358, height: 1825)
//                .cornerRadius(350)
                .scaleEffect(0.12)

                       ShareLink("Export", item: renderedImage, preview: SharePreview(Text("Shared image"), image: renderedImage))

//            snapshot().resizable().aspectRatio(contentMode: .fit)
//                .frame(height: 100).border(.red)
        }.onAppear {
            render()
        }
    }
//    @MainActor func snapshot() -> Image {
//            let imagerenderer = ImageRenderer(
//                content: GameView(user: user).frame(maxWidth: 100, maxHeight: 100)
//            )
//            return Image(uiImage: imagerenderer.uiImage!)
//        }
    
    @MainActor func render() {
            let renderer = ImageRenderer(content:GameSnapshotView(user: user))
//        let renderer = ImageRenderer(content:Text("hi"))

            // make sure and use the correct display scale for this device
            renderer.scale = displayScale

        
            if let uiImage = renderer.uiImage {
                renderedImage = Image(uiImage: uiImage)
            }
        }
}

//#Preview {
//    ShareView(show: .constant(true))
//}
