//
//  AddNewWord.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 02.04.2024.
//

import SwiftUI

struct AddNewWordView: View {
    @State private var newWord = ""
    @State private var wordTranslate = ""
    @State private var wordDesription = ""
    @ObservedObject var listViewModel: ListViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("New word")
                    .font(.system(size: 20, weight: .black))
                    .padding(.leading, 16)
                Spacer()
                Button(action: {
                    listViewModel.isShowAddView.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.black)
                })
            }
            
            VStack(alignment: .leading) {
                Text("TR").font(.system(size: 12, weight: .black))
                
                VStack {
                    TextField("Word", text: $newWord)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 23)
                        .background(Color("Gray"))
                        .cornerRadius(10)
                    TextField("Translate", text: $wordTranslate)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 23)
                        .background(Color("Gray"))
                        .cornerRadius(10)
                }
               
                Text("Description")
                    .font(.system(size: 14, weight: .black))
                    .padding(.top, 13)
                    .padding(.leading, 23)
                
                Rectangle()
                    .opacity(0)
                    .frame(height: 90)
                    .padding(.vertical, 13)
                    .padding(.horizontal, 23)
                    .background(Color("Gray"))
                    .cornerRadius(10)
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
    AddNewWordView(listViewModel: ListViewModel())
}
