//
//  AddNewWord.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 02.04.2024.
//

import SwiftUI
import RealmSwift

struct AddNewWordView: View {
    @State private var newWord = ""
    @State private var wordTranslate = ""
    @State private var wordDesription = ""
    @State private var showAlert = false
    @ObservedResults(WordItem.self) var wordItems
    @ObservedObject var listViewModel: ListViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("New word")
                    .font(.system(size: 20, weight: .black))
                    .padding(.leading, 16)
                Spacer()
                    //Выход
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
                Text("EN").font(.system(size: 12, weight: .black))
                
                VStack {
                    TextField("Word", text: $newWord)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 23)
                        .background(Color("Gray"))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never) //Регистр с маленькой буквы
                    TextField("Translate", text: $wordTranslate)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 23)
                        .background(Color("Gray"))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                }
               
                Text("Description")
                    .font(.system(size: 14, weight: .black))
                    .padding(.top, 13)
                    .padding(.leading, 23)
                
                HStack {
                    TextEditor(text: $wordDesription)
                        .frame(height: 90)
                        .colorMultiply(Color("Gray"))
                        .autocorrectionDisabled() //Убрать автоисправления
                }
                .padding(.vertical, 13)
                .padding(.horizontal, 23)
                .background(Color("Gray"))
                .cornerRadius(10)
            }
            
            Spacer()
            //SAVE Button
            Button(action: {
                if newWord.count == 0 || wordTranslate.count == 0 {
                    showAlert.toggle()
                } else {
                    let word = WordItem() //создаем объект модели и записываем в него данные
                    word.nativWord = newWord
                    word.translateWord = wordTranslate
                    word.descriptionWord = wordDesription
                    
                    $wordItems.append(word) //Сохраняем в Realm
                    
                    withAnimation {
                        listViewModel.isShowAddView.toggle() //Закрываем Вью
                    }
                }
            }, label: {
                Text("Save")
                    .padding(.vertical, 13)
                    .frame(maxWidth: .infinity)
                    .background(.main)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }).alert(Text("Empty fields"), isPresented: $showAlert) {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(15)
        .background(.white)
    }
}

#Preview {
    AddNewWordView(listViewModel: ListViewModel())
}
