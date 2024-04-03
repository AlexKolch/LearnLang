//
//  LearnLangApp.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 01.04.2024.
//

import SwiftUI

@main
struct LearnLangApp: App {
    var body: some Scene {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path) //путь для поиска папки Realm
        
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
