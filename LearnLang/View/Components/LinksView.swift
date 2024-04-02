//
//  LinksView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 02.04.2024.
//

import SwiftUI

struct LinksView: View {
    @ObservedObject var linksViewModel: LinksViewModel
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            
            ScrollView {
                VStack(spacing: 10.0) {
                    LinkItem(text: "Урок по грамматике языка")
                    LinkItem(text: "Урок 3. Личные местоимения. Аффиксы сказуемости")
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                linksViewModel.isShowAddLink.toggle()
            }, label: {
                ZStack {
                    Circle().frame(width: 56, height: 56).foregroundStyle(.main)
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.background)
                }
            })
            .offset(x: -20, y: -30)
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct LinkItem: View {
    let text: String
    
    var body: some View {
        HStack {
            HStack(spacing: 15.0) {
                Image(systemName: "link")
                Text(text)
                    .font(.system(size: 14))
            }
            Spacer()
            
            Button(action: {
                //
            }, label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
            })
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color("Gray"))
        .cornerRadius(10)
        .onTapGesture {
            print(1)
        }
    }
}

#Preview {
    ContentView()
}
