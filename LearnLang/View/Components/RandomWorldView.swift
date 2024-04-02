//
//  RandomWorldView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 02.04.2024.
//

import SwiftUI

struct RandomWorldView: View {
    @State private var isShowTranslate = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(spacing: 20.0) {
                    VStack(alignment: .leading) {
                        Text("TR")
                            .font(.system(size: 12, weight: .black))
                            .padding(.bottom, 0)
                        Text("Araba")
                            .font(.system(size: 36, weight: .black))
                    }
                    ZStack {
                        Text("Машина")
                            .font(.system(size: 26, weight: .thin))
                            .opacity(isShowTranslate ? 1.0 : 0.0)
                        Button(action: {
                            withAnimation(.spring()) {
                                isShowTranslate.toggle()
                            }
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
                Spacer()
                
                Button(action: {
                    //
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
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView()
}
