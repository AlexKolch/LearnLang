//
//  WebView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 04.04.2024.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
//    @Binding var url: String
    var url: String
    var isLoad: (Bool) -> () //дернем этот кложур в другом месте при создании объекта
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        if let openURL = URL(string: url) {
            let urlComponents = URLComponents(url: openURL, resolvingAgainstBaseURL: true)
            
            let request = URLRequest(url: urlComponents?.url ?? openURL)
            webView.load(request)
        }
        
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator { isLoad in
            self.isLoad(isLoad) //передаем данные из делегата о завершении загрузки
        }
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    let isLoad: (Bool) -> () //Для передачи данных о загрузки
    
    init(isLoad: @escaping (Bool) -> Void) {
        self.isLoad = isLoad
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoad(true)
    }
}
