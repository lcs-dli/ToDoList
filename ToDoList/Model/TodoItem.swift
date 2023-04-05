//
//  TodoItem.swift
//  ToDoList
//
//  Created by Justin Zack Wei on 2023-04-03.
//

import Blackbird
import Foundation

struct TodoItem: BlackbirdModel{
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var description: String
    @BlackbirdColumn var completed: Bool
}

var existingTodoItems = [

    TodoItem(id: 1, description: "STUDY FOR CHEMISTRY QUIZ", completed: false)
    
    ,
    
    TodoItem(id: 2, description: "Do Computer science homework", completed: true)
    
    ,
    
    TodoItem(id: 3, description: "Play Genshin Impact", completed: false)
]
