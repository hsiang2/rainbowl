//
//  GameView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/22.
//


import SwiftUI

struct GameView: View {
    @State var currentScaleValue: CGFloat = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    
//    @GestureState var locationState = CGPoint(x: 100, y: 100)
    @State var location = CGPoint(x: 1050, y: 650)
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false)
        {
            ZStack {
                ZStack {
                    Image("背景_黑白")
                    Image("背景_藍")
                        .blendMode(.color)
                    Image("背景_黃")
                        .blendMode(.color)
                    Image("背景_綠")
                        .blendMode(.color)
                }
                 
                
                ZStack {
                    Image("黑白鹿")
                        .resizable().scaledToFit().frame(width: 150)
                    Image("彩色鹿")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 150)
                       .blendMode(.color)

//                    Image("測試橘")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 150)
//                        .blendMode(.color)
//                    Image("測試藍")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 150)
//                        .blendMode(.color)
        //
        //            Color.red.blendMode(.color)
        //            Color.yellow.blendMode(.screen)
                }
                .position(location)
//                    .gesture(
//                        DragGesture(
//                            minimumDistance: 200,
//                            coordinateSpace: .local
//                        )
//                            .onChanged { value in
//                                self.location = value.location
//                            }
//                            .onEnded { value in
//                                withAnimation {
//                                    self.location = CGPoint(x: 100, y: 100)
//
//                                }
//                            }
//                            .updating(
//                                self.$locationState
//                            ) { currentState, pastLocation, transaction  in
//                                pastLocation = currentState.location
//                                transaction.animation = .easeInOut
//                            }
//
//                    )
           
            }.scaleEffect(lastScaleValue + currentScaleValue >= 1 ? lastScaleValue + currentScaleValue : 1)
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
        }.ignoresSafeArea()
            
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
            
        
        
    }
}
//import SwiftUI
//
//struct GameView: View {
//    @State private var adjustedImage: Image?
//
//    var body: some View {
//        VStack {
//            if let image = adjustedImage {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else {
//                Text("No image")
//            }
//        }
//        .onAppear {
//            adjustImageColors()
//        }
//    }
//
//    private func adjustImageColors() {
//        guard let originalImage = UIImage(named: "商店") else {
//            return
//        }
//
//        guard let cgImage = originalImage.cgImage else {
//            return
//        }
//
//        let width = cgImage.width
//        let height = cgImage.height
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let bytesPerPixel = 4
//        let bytesPerRow = bytesPerPixel * width
//        let bitsPerComponent = 8
//
//        var pixelData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
//
//        let context = CGContext(
//            data: &pixelData,
//            width: width,
//            height: height,
//            bitsPerComponent: bitsPerComponent,
//            bytesPerRow: bytesPerRow,
//            space: colorSpace,
//            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
//        )
//
//        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//
//        for y in 0..<height {
//            for x in 0..<width {
//                let pixelIndex = y * width + x
//                let offset = pixelIndex * bytesPerPixel
//
//                let red = pixelData[offset]
//                let green = pixelData[offset + 1]
//                let blue = pixelData[offset + 2]
//
//                // Adjust the percentage of each color component separately
//                let adjustedRed = UInt8(Double(red) * 0.25) // 25% of the original red
//                let adjustedGreen = green // 100% of the original green
//                let adjustedBlue = blue // 100% of the original blue
//
//                pixelData[offset] = adjustedRed
//                pixelData[offset + 1] = adjustedGreen
//                pixelData[offset + 2] = adjustedBlue
//            }
//        }
//
//        guard let newCGImage = context?.makeImage() else {
//            return
//        }
//
//        let adjustedUIImage = UIImage(cgImage: newCGImage)
//        adjustedImage = Image(uiImage: adjustedUIImage)
//    }
//}
//


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
