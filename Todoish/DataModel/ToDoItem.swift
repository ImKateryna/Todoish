//
//  ToDoItem.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 22/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    @objc dynamic var title = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
