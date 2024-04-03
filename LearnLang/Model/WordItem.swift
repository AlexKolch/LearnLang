//
//  WordItem.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 03.04.2024.
//

import Foundation
import RealmSwift

final class WordItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var location: String = "TR"
    @Persisted var nativWord: String = ""
    @Persisted var translateWord: String = ""
    @Persisted var descriptionWord: String = ""
    ///частота слова для повторения
    @Persisted var repeatWord: Int = 0
    
    override class func primaryKey() -> String? {
        "id"
    }
}
