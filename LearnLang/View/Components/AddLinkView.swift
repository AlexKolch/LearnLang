//
//  AddLinkView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 02.04.2024.
//

import SwiftUI

struct AddLinkView: View {
    @State private var linkTitle = ""
    @State private var link = ""
 
    @ObservedObject var linksViewModel: LinksViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("New link")
                    .font(.system(size: 20, weight: .black))
                    .padding(.leading, 16)
                Spacer()
                Button(action: {
                    linksViewModel.isShowAddLink.toggle()
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
            Button(action: {
                //
            }, label: {
                Text("Save")
                    .padding(.vertical, 13)
                    .frame(maxWidth: .infinity)
                    .background(.main)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(15)
        .background(.white)
    }
}

#Preview {
    AddLinkView(linksViewModel: LinksViewModel())
}
