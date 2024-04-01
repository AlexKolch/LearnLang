//
//  ListView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 01.04.2024.
//

import SwiftUI

struct ListView: View {
    @State var searchText: String = ""
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            ScrollView(.vertical) {
                VStack(spacing: 25.0) {
                    HStack(spacing: 10.0) {
                        //Search
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 15, height: 15)
                        TextField("Search", text: $searchText)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color("Gray"))
                    .clipShape(Capsule())
                    
                    VStack(spacing: 20.0) {
                        //Cards
                        CardItemsView()
                        CardItemsView()
                        CardItemsView()
                    }
                }
            }
            Button(action: {
                //
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
        }
    }
}

struct CardItemsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            VStack(alignment: .leading, spacing: 0.0) { //1
                Text("TR").font(.system(size: 12, weight: .black))
                    .padding(.bottom, 5)
                Text("Araba").font(.system(size: 18, weight: .black))
                
                Rectangle().frame(height: 2).opacity(0.0) //прозрачное вью
                
                Text("Машина").font(.system(size: 16, weight: .light))
            }
            
            Divider()
            
            VStack(alignment: .leading) { //2
                Text ("Примечание").font(.system(size: 12, weight: .black))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 2)
                Text ("Lorem ipsum, dolor sit amet, consectetur adipisicing elit. Quia vel a eveniet explicabo")
            }
        }.frame(maxWidth: .infinity)
            .padding(20)
            .background(Color("Gray"))
            .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
