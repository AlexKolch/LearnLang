//
//  LinksView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 02.04.2024.
//

import SwiftUI
import RealmSwift

struct LinksView: View {
    @ObservedObject var linksViewModel: LinksViewModel
    @ObservedResults(LinkItem.self) var linkItem
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            
            NavigationStack {
                ScrollView {
                    VStack(spacing: 10.0) {
                        
                        ForEach(linkItem) { link in
                            NavigationLink {
                                LinkOpenView(url: link.linkUrl)
                            } label: {
                                LinkItems(linkData: link) {
                                    withAnimation {
                                        $linkItem.remove(link)
                                    }
                                }
                            }
                            .foregroundStyle(.black)
                            .navigationTitle("Links")
                            .navigationBarTitleDisplayMode(.large)
                        }
                    }
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            //Кнопка Рlus
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
            .sheet(isPresented: $linksViewModel.isShowAddLink) {
                AddLinkView(linksViewModel: linksViewModel)
            }
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
}

//MARK: - LinkItem
struct LinkItems: View {
    
    let linkData: LinkItem
    var onDelete: ()->()
    
    var body: some View {
        HStack {
            HStack(spacing: 15.0) {
                Image(systemName: "link")
                Text(linkData.linkTitle)
                    .font(.system(size: 14))
            }
            Spacer()
            //Кнопка удалить запись
            Button(action: {
                onDelete()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
            })
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color("Gray"))
        .cornerRadius(10)
    }
}

#Preview {
    LinksView(linksViewModel: LinksViewModel())
}
