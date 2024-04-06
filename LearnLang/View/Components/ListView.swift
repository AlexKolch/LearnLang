//
//  ListView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 01.04.2024.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    @State private var searchText: String = ""
    @ObservedObject var listViewModel: ListViewModel
    @ObservedResults(WordItem.self, sortDescriptor: SortDescriptor(keyPath: "nativWord", ascending: true)) var wordItems //отсюда берутся данные из Realm
    
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
                            .textInputAutocapitalization(.never)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color("Gray"))
                    .clipShape(Capsule())
                    .searchable(text: $searchText, collection: $wordItems, keyPath: \.nativWord)
                    
                    VStack(spacing: 20.0) {
                        //Cards
                        ForEach(wordItems, id: \.id) { item in //Берем карточки из Realm и каждую кладем в вью
                            CardItemsView(cardItems: item) {
                                withAnimation {
                                    $wordItems.remove(item) //кложур onDelete: Удаление из Realm
                                }
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

//MARK: - CardItems
struct CardItemsView: View {
    @State private var offsetX: CGFloat = 0
    @State private var isShowDescription = true
    var cardItems: WordItem
    let onDelete: () -> ()
    
    var body: some View {
        ZStack(alignment: .trailing) {
            createRemoveImage()
            VStack(alignment: .leading, spacing: 10.0) {
                VStack(alignment: .leading, spacing: 0.0) { //1 блок слово
                    Text("EN").font(.system(size: 12, weight: .black))
                        .padding(.bottom, 5)
                    Text(cardItems.nativWord)
                        .font(.system(size: 18, weight: .black))
                    
                    Rectangle().frame(height: 2).opacity(0.0) //прозрачное вью
                    
                    Text(cardItems.translateWord)
                        .font(.system(size: 16, weight: .light))
                }
                
                if cardItems.descriptionWord.count != 0 {
                    Divider()
                    VStack(alignment: .leading) { //2 блок примечание
                        Text("Примечание").font(.system(size: 12, weight: .black))
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 2)
                        if isShowDescription {
                            Text(cardItems.descriptionWord)
                                .onTapGesture {
                                    withAnimation {
                                        isShowDescription.toggle()
                                    }
                                }
                        } else {
                            Rectangle().frame(minWidth: 200, maxHeight: 2).foregroundStyle(Color("Gray"))
                                .onTapGesture {
                                    withAnimation {
                                        isShowDescription.toggle()
                                    }
                                }
                        }
                    }
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
                        if Self.screenSize().width * 0.7 < -value.translation.width {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred() //Вибрация при удалении
                            withAnimation {
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
            .onTapGesture {
                onDelete()
            }
    }
}

#Preview {
    ContentView()
}
