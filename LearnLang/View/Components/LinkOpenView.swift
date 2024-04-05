//
//  LinkOpenView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 04.04.2024.
//

import SwiftUI

struct LinkOpenView: View {
    @State var isLoaded = false
    @State var title = ""
    @Environment(\.dismiss) var dismiss
    var url: String
    
    var body: some View {
        VStack{
            WebView(url: url) { loaded in
                self.isLoaded = loaded
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let url = URL(string: url) {
                self.title = url.host() ?? ""
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LinkOpenView(url: "https://www.native-english.ru")
}
