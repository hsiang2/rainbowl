//
//  SoundPlayer.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/4.
//

import AVFoundation

class SoundPlayer {
    static let shared = SoundPlayer() // 單例實例

    private var btnclick = AVPlayer()

    private init() {
        // 防止外部實例化
    }
    func playIconSound() {
        let url = Bundle.main.url(forResource: "iconclick", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)
        btnclick.replaceCurrentItem(with: playerItem)
        btnclick.play()
    }//主頁Icon音效

    func playClickSound() {
        let url = Bundle.main.url(forResource: "click", withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        btnclick.replaceCurrentItem(with: playerItem)
        btnclick.play()
    }//按鈕點擊音效
    
    func playSucceedSound()  {
        let url = Bundle.main.url(forResource: "success", withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        btnclick.replaceCurrentItem(with: playerItem)
        btnclick.play()
    }//獲得動植物音效
    
    func playCloseSound() {
        let url = Bundle.main.url(forResource: "close", withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        btnclick.replaceCurrentItem(with: playerItem)
        btnclick.play()
    }//xmark音效
    
    func playDatePickerSound() {
        let url = Bundle.main.url(forResource: "dateselected", withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        btnclick.replaceCurrentItem(with: playerItem)
        btnclick.play()
    }//datepicker音效
    
    func playColorSelectedSound() {
        let url = Bundle.main.url(forResource: "color", withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        btnclick.replaceCurrentItem(with: playerItem)
        btnclick.play()
    }//datepicker音效
    
    func playEnterSound() {
        let url = Bundle.main.url(forResource: "login", withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        btnclick.replaceCurrentItem(with: playerItem)
        btnclick.play()
    }//datepicker音效
}
