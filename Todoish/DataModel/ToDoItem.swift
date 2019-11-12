//
//  ToDoItem.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 10/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

class ToDoItem: Codable {
    private var title: String = ""
    private var done: Bool = false
    
    func setData(withTitle title: String, done: Bool = false) {
        self.title = title
        self.done = done
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getDone() -> Bool {
        return done
    }
    
    func switchDone() {
        self.done = !self.done
    }
}
