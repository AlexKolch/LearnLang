//
//  ContentView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 01.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selected = 2
    var body: some View {
        TabView(selection: .constant(3)) {
            ListView().tag(1)
                .padding(.horizontal, 15)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
                }
            RandomWorldView().tag(2)
                .padding(.horizontal, 15)
                .tabItem {
                    Image(systemName: "textformat.abc")
                    Text("Words")
                }
            LinksView().tag(3)
                .padding(.horizontal, 15)
                .tabItem {
                    Image(systemName: "link")
                    Text("Links")
                }
        }
    }
}

#Preview {
    ContentView()
}
