//
//  RandomWorldView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 02.04.2024.
//

import SwiftUI
import RealmSwift

struct RandomWorldView: View {
    @State private var isShowTranslate = false
    @ObservedResults(WordItem.self) var wordItems
    @State private var word = WordItem() //здесь лежит рандомное слово из БД
    @State private var offsetX: CGFloat = 0.0
    @State private var opacity: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(spacing: 20.0) {
                    VStack(alignment: .leading) {
                        Text("EN")
                            .font(.system(size: 12, weight: .black))
                            .padding(.bottom, 0)
                        Text(word.nativWord)
                            .font(.system(size: 36, weight: .black))
                    }
                    ZStack {
                        Text(word.translateWord)
                            .font(.system(size: 26, weight: .thin))
                            .opacity(isShowTranslate ? 1.0 : 0.0)
                        //Кнопка Show translate
                        Button(action: {
                                isShowTranslate.toggle()
                        }, label: {
                            Text("Show translate")
                        })
                        .padding(.horizontal, 60)
                        .padding(.vertical, 13)
                        .foregroundStyle(.background)
                        .background(Color.main)
                        .clipShape(Capsule())
                        .opacity(isShowTranslate ? 0.0 : 1.0)
                    }
                }
                .offset(x: offsetX)
                .opacity(opacity)
                
                Spacer()
                //Кнопка Next
                Button(action: {
                    withAnimation {
                        offsetX = -50.0
                        opacity = 0.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        getRandomWord()
                        offsetX = 30.0
                        isShowTranslate = false
                        
                        withAnimation {
                            offsetX = 0.0
                            opacity = 1.0
                        }
                    }
                }, label: {
                    HStack(spacing: 4.0, content: {
                        Text("Next").font(.title3)
                        Image(systemName: "chevron.right").frame(width: 15, height: 15)
                    })
                }).foregroundStyle(.main)
                Rectangle()
                    .frame(height: 38)
                    .hidden()
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            getRandomWord()
        }
    }
    
    func getRandomWord() {
        if !wordItems.isEmpty {
            let random = Int.random(in: 0...wordItems.count - 1)
            self.word = wordItems[random]
        }
    }
}

#Preview {
    ContentView()
}
