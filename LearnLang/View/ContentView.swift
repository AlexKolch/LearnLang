//
//  ContentView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 01.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selected = 2
    @StateObject var listViewModel = ListViewModel()
    @StateObject var linksViewModel = LinksViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: .constant(1)) {
                ListView(listViewModel: listViewModel).tag(1)
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
                LinksView(linksViewModel: linksViewModel).tag(3)
                    .padding(.horizontal, 15)
                    .tabItem {
                        Image(systemName: "link")
                        Text("Links")
                    }
            }
            
            if listViewModel.isShowAddView {
                AddNewWordView(listViewModel: listViewModel)
            }
            if linksViewModel.isShowAddLink {
                AddLinkView(linksViewModel: linksViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
