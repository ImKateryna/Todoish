//
//  ToDoItem.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 22/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<ToDoItem>()
}
