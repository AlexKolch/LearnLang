//
//  ListView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 01.04.2024.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    @State var searchText: String = ""
    @ObservedObject var listViewModel: ListViewModel
    @ObservedResults(WordItem.self) var wordItems
    
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
                        ForEach(wordItems, id: \.id) { item in
                            CardItemsView(cardItems: item) {
                                $wordItems.remove(item) //Удаление из Realm
                            }
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            
            Button(action: {
                listViewModel.isShowAddView.toggle()
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
    @State var offsetX: CGFloat = 0
    var cardItems: WordItem
    let onDelete: () -> ()
    
    var body: some View {
        ZStack(alignment: .trailing) {
            createRemoveImage()
            VStack(alignment: .leading, spacing: 10.0) {
                VStack(alignment: .leading, spacing: 0.0) { //1
                    Text("TR").font(.system(size: 12, weight: .black))
                        .padding(.bottom, 5)
                    Text(cardItems.nativWord)
                        .font(.system(size: 18, weight: .black))
                    
                    Rectangle().frame(height: 2).opacity(0.0) //прозрачное вью
                    
                    Text(cardItems.translateWord)
                        .font(.system(size: 16, weight: .light))
                }
                
                Divider()
                
                VStack(alignment: .leading) { //2
                    Text ("Примечание").font(.system(size: 12, weight: .black))
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 2)
                    Text (cardItems.descriptionWord)
                }
            }.frame(maxWidth: .infinity)
                .padding(20)
                .background(Color("Gray"))
                .cornerRadius(10)
                .offset(x: offsetX)
                .gesture(DragGesture()
                         
                    .onChanged { value in
                        if value.translation.width < 0 {
                            offsetX = value.translation.width
                        }
                    }
                         
                    .onEnded { value in
                        withAnimation {
                            if Self.screenSize().width * 0.7 < -value.translation.width {
                                offsetX = -Self.screenSize().width
                                onDelete()
                            }
                            offsetX = 0
                        }
                    }
            )
        }
    }
    @ViewBuilder
    func createRemoveImage() -> some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 10, height: 10)
            .offset(x: 30)
            .offset(x: offsetX * 0.4)
            .scaleEffect(CGSize(width: 0.1 * -offsetX * 0.08,
                                height: 0.1 * -offsetX * 0.08))
    }
}

#Preview {
    ContentView()
}
