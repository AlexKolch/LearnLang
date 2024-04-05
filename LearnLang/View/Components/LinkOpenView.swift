//
//  LinkOpenView.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 04.04.2024.
//

import SwiftUI

struct LinkOpenView: View {
    
    @State var isLoaded = false
    @State var title = ""
//    @Binding var url: String
    var url: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack{
                HStack(alignment: .center) {
//                    if isLoaded {
                        Spacer()
                        Text(title).fontWeight(.bold)
                        Spacer()
                        withAnimation {
                            Button(action: {
                                self.dismiss()
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.black)
                            })
                        }
//                    }
                }.padding(.horizontal)
                
                WebView(url: url) { loaded in
                    self.isLoaded = loaded
                }
            }
        }
        .onAppear {
            if let url = URL(string: url) {
                self.title = url.host() ?? ""
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LinkOpenView(url: "https://www.native-english.ru")
}
