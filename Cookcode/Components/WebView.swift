//
//  WebView.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import SwiftUI
import WebKit

// uikit의 uiview를 사용할 수 있도록 해줌
// uiviewcontroller를 사용하고 싶으면 UIViewControllerRepresentable 하면됨
struct MyWebView: UIViewRepresentable {
    
    var urlToLoad: String
    
    //uiview 만들기
    func makeUIView(context: Context) -> WKWebView {
        //웹뷰 인스턴스 생성
        let webview = WKWebView()
        let encoded = urlToLoad.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let encodedURL = URL(string: encoded)!
        //웹뷰 로드
        webview.load(URLRequest(url: encodedURL))
        
        return webview
    }
    
    //uiview 업데이트
    //context는 uiviewrepresentablecontext로 감싸야 함.
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
        
    }
}
