//
//  MyViewController.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/2.
//

import UIKit
import AVFoundation

class MyViewController: UIViewController {
    
    var imageView: UIImageView!
    var backgroundImageView: UIImageView!  // 新增一個變數來顯示背景圖片
    var moveDirection: CGFloat = 1.0  // 初始移動方向
    var isGoingUp = false
    var backgroundMusicPlayer: AVAudioPlayer?
    
    enum AnimalType: String {
            case deer = "鹿"
            case koala = "koala"
            // Add more animals as needed
        }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 設定背景音樂
        setupBackgroundMusic()
        
        // 添加背景圖片
        backgroundImageView = UIImageView(image: UIImage(named: "島"))
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.zPosition = -1
        view.addSubview(backgroundImageView)
        
        // Add initial animal (e.g., deer)
        //addAnimal(type: .deer)
        addAnimal(type: .koala)
        
        // Add a button to add a deer
        let addButton = UIButton(type: .system)
        addButton.setTitle("Add Deer", for: .normal)
        addButton.frame = CGRect(x: 20, y: view.frame.height - 60, width: 100, height: 40)
        addButton.addTarget(self, action: #selector(addDeer), for: .touchUpInside)
        view.addSubview(addButton)
        // 在這裡添加你的代碼
        //imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 201, height: 131))
        //imageView.contentMode = .scaleAspectFit // 設置 contentMode
        
        // 計算視圖中心點
        //let centerX = view.frame.width / 2
        //let centerY = view.frame.height / 2
        
        // 設置 imageView 的中心點
        //imageView.center = CGPoint(x: centerX, y: centerY)
        
        //view.addSubview(imageView)
        
        // 調用 animatedImages 方法並將名稱設置為 "鹿"
        //let images = animatedImages(for: "鹿")
        
        // 使用動畫創建 UIImage
        //let animatedImage = UIImage.animatedImage(with: images, duration: 1)
        
        // 設置動畫圖片
        //imageView.image = animatedImage
        
        // 開始動畫
        //startAnimation()
    }
    @objc func addDeer() {
           // Call the addAnimal method with the deer type
           addAnimal(type: .deer)
       }
    func animatedImages(for name: String) -> [UIImage] {
        var i = 0
        var images = [UIImage]()
        
        while let image = UIImage(named: "\(name)\(i)") {
            images.append(image)
            i += 1
        }
        // Add this print statement
        print("Loaded \(images.count) images for \(name)")
        return images
    }
    
    func startAnimation(for imageView: UIImageView)  {
        // 設置左右移動的範圍
        let minX = view.frame.minX
        let maxX = view.frame.maxX - imageView.frame.width
        
        
        // 地面高度
        //let groundHeight: CGFloat = 20.0
        
        // 向左移動
        UIView.animate(withDuration: 5, delay: 0, options: [.curveLinear], animations: {
            if self.moveDirection == 1 {
                imageView.frame.origin.x = minX
            } else {
                imageView.frame.origin.x = maxX
            }
//            if self.isGoingUp {
//                imageView.frame.origin.y -= 20
//                self.isGoingUp.toggle()
//            } else {
//                imageView.frame.origin.y += 20
//                self.isGoingUp.toggle()
            //}// 模擬地面反饋
            
            // 模擬地面反饋，如果在地面上，降低圖片高度
            //            if self.imageView.frame.origin.y == (self.view.frame.height - groundHeight - self.imageView.frame.height) {
            //                self.imageView.frame.origin.y += groundHeight
            //            }
            
        }) { (completed) in
            // 改變移動方向
            self.moveDirection *= -1.0
            
            // 模擬地面反饋，如果抬起腳，提高圖片高度
            //            if self.imageView.frame.origin.y == (self.view.frame.height - self.imageView.frame.height) {
            //                self.imageView.frame.origin.y -= groundHeight
            //            }
            
            // 改變面向方向
            imageView.transform = CGAffineTransform(scaleX: self.moveDirection, y: 1.0)
            self.startAnimation(for: imageView)
        }
    }
    func addAnimal(type: AnimalType) {
        //let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 201, height: 131))
        let newImageView = UIImageView(frame: CGRect(x: CGFloat(arc4random_uniform(UInt32(view.frame.width))),
                                                     y:CGFloat(arc4random_uniform(UInt32(view.frame.height))),
                                                     width: 201, height: 131))//隨機位置
        newImageView.contentMode = .scaleAspectFit
        //newImageView.center = view.center  // 設置圖片的中心點為屏幕的中心點

        let images = animatedImages(for: type.rawValue)
        let animatedImage = UIImage.animatedImage(with: images, duration: 1)

        newImageView.image = animatedImage
        
        // 設置 zPosition，y 值越小，zPosition 越大
        newImageView.layer.zPosition = newImageView.frame.origin.y
        print(newImageView.frame.origin.y)
        print(newImageView.layer.zPosition)
        view.addSubview(newImageView)
        
        startAnimation(for: newImageView)
    }


    func setupBackgroundMusic() {
           // 取得音樂檔案的 URL
        if let musicURL = Bundle.main.url(forResource: "rainbowlBgmusic", withExtension: "mp3") {
               do {
                   // 初始化 AVAudioPlayer 實例
                   backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                   
                   // 設置音量（可選）
                   backgroundMusicPlayer?.volume = 1
                   
                   // 設置循環播放
                   backgroundMusicPlayer?.numberOfLoops = -1
                   
                   // 準備播放
                   backgroundMusicPlayer?.prepareToPlay()
                   
                   // 開始播放
                   backgroundMusicPlayer?.play()
               } catch {
                   print("Error loading background music: \(error.localizedDescription)")
               }
           }
       }
    
}
