//
//  ContentView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 01.04.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var listViewModel = ListViewModel()
    @StateObject var linksViewModel = LinksViewModel()
//    @Environment(\.colorScheme) var colorTheme
    
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().backgroundColor = colorTheme == .light ? UIColor.white : UIColor.black
    }
    
    var body: some View {
        ZStack {
            TabView() {
                ListView(listViewModel: listViewModel).tag(1)
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
                    .tabItem {
                        Image(systemName: "link")
                        Text("Links")
                    }
                    .environmentObject(linksViewModel)
            }
            //Переходы на детальные экраны
            if listViewModel.isShowAddView {
                AddNewWordView(listViewModel: listViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
