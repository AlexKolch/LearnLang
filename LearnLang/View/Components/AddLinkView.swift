//
//  AddLinkView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 02.04.2024.
//

import SwiftUI
import RealmSwift

struct AddLinkView: View {
    @State private var linkTitle = ""
    @State private var link = ""
    @State private var isShowAlert = false
    @ObservedObject var linksViewModel: LinksViewModel
    @Environment(\.dismiss) var dismiss
    @ObservedResults(LinkItem.self) var linkItem
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("New link")
                    .font(.system(size: 20, weight: .black))
                    .padding(.leading, 16)
                Spacer()
                Button(action: {
//                    linksViewModel.isShowAddLink.toggle()
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.black)
                })
            }
            
            VStack(alignment: .leading) {
                
                VStack {
                    TextField("Title", text: $linkTitle)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 23)
                        .background(Color("Gray"))
                        .cornerRadius(10)
                    TextField("Link", text: $link)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 23)
                        .background(Color("Gray"))
                        .cornerRadius(10)
                }
            }
            Spacer()
            //Кнопка SAVE
            Button(action: {
                if linkTitle.count > 0, link.count > 0 {
                    let newLink = LinkItem()
                    newLink.linkTitle = self.linkTitle
                    newLink.linkUrl = self.link
                    
                    $linkItem.append(newLink)
                    
                    withAnimation {
                        linksViewModel.isShowAddLink.toggle()
                    }
                } else {
                    isShowAlert.toggle()
                }
            }, label: {
                Text("Save")
                    .padding(.vertical, 13)
                    .frame(maxWidth: .infinity)
                    .background(.main)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }).alert(Text("Empty fields"), isPresented: $isShowAlert) {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(15)
        .background(.white)
    }
}

#Preview {
    AddLinkView(linksViewModel: LinksViewModel())
}
