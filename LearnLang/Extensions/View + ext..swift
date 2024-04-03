//
//  View + ext..swift
//  LearnLang
//
//  Created by Алексей Колыченков on 03.04.2024.
//

import SwiftUI

extension View {
    ///получить размер экрана
    static func screenSize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        return window.screen.bounds.size
    }
}
