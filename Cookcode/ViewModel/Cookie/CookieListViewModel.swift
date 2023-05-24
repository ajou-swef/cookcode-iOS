//
//  CookieListViewModel.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/23.
//

import SwiftUI
import AVFoundation

struct Cookie: Identifiable {
    let id: String = UUID().uuidString
    var url: String
    
    static func mock() -> Cookie {
        Cookie(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    }
}

final class CookieListViewModel: ObservableObject {
    @Published var avPlayers: [AVPlayer] = [
        AVPlayer(playerItem: AVPlayerItem(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)),
        AVPlayer(playerItem: AVPlayerItem(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)),
        AVPlayer(playerItem: AVPlayerItem(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!)),
    ]
    
    @Published var cookies: [Cookie] = []
    @Published var cookieSelection: String = ""
    @Published var drag: CGFloat = .zero 
    
    init() {
        let cookie1 = Cookie(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        let cookie2 = Cookie(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
        let cookie3 = Cookie(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
        let cookie4 = Cookie(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")
        
        cookies.append(cookie1)
        cookies.append(cookie2)
        cookies.append(cookie3)
        cookies.append(cookie4)
        cookies.append(Cookie.mock())
        cookieSelection = cookies[0].id
        
        // 메모리 테스트용. 추후 삭제
    }
    
    @MainActor
    func rotateTab() {
        guard check() else { return }
        
        if cookieSelection == cookies[0].id && drag < 0 {
            cookieSelection = cookies[cookies.count - 1].id
            print("carousel!")
        }

        if cookieSelection == cookies[cookies.count - 1].id && drag > 0 {
            cookieSelection = cookies[0].id
            print("carousel!")
        }
    }
    
    @MainActor
    func loadNewCookie() async {
        print("loadNewCookie called")
        
        guard let currentIndex = cookies.firstIndex(where: { $0.id == cookieSelection }) else {
            return
        }
        
        guard check() else { return }
        
        
        let updatedIndex = (currentIndex + 2) % 4
        
        cookies[updatedIndex].url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4"
        
        if updatedIndex == 0 {
            cookies[cookies.count - 1].url = cookies[0].url
        }
    }
    
    private func check() -> Bool {
        let indices = cookies.indices
        return indices.contains(0) && indices.contains(cookies.count - 1)
    }
}
