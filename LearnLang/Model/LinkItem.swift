//
//  LinkItem.swift
//  LearnLang
//
//  Created by Алексей Колыченков on 05.04.2024.
//

import Foundation
import RealmSwift

class LinkItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var linkTitle: String = ""
    @Persisted var linkUrl: String = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
}
