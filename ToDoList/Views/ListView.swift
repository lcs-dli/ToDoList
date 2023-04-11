//
//  ListView.swift
//  ToDoList
//
//  Created by Justin Zack Wei on 2023-04-03.
//

import SwiftUI
import Blackbird

struct ListView: View {
    
    //MARK: Stored property
    @Environment(\.blackbirdDatabase) var db:
        Blackbird.Database?
    
    @BlackbirdLiveModels({db in
        try await TodoItem.read(from: db)
    }) var TodoItems
    
    @State var newItemDescription: String = ""
    //MARK: Computed Property
    var body: some View {
        NavigationView{
            
            VStack{
                
                HStack{
                    TextField("Enter a to-do item", text: $newItemDescription)
                        .padding()
                    Button(action: {
                      /*  let lastId = TodoItems.last!.id
                        
                        let newId = lastId + 1
                        
                        let newTodoItem = TodoItem(id: newId, description: newItemDescription, completed: false)
                        
                        TodoItems.append(newTodoItem)
                        
                        newItemDescription = ""*/
                        Task{
                            try await db!.transaction({ core in
                                try core.query("INSERT INTO TodoItem (description) VALUES (?)", newItemDescription)
                                
                            })
                            
                            newItemDescription = ""
                        }
                        
                    }, label:{
                        Text("ADD")
                            .font(.caption)
                            
                    })
                    .padding()
                }
                
                List(TodoItems.results){ currentItem in
                    
                    Label(title: {
                        Text(currentItem.description)
                    }, icon: {
                        if currentItem.completed{
                            Image(systemName: "checkmark.circle")
                        }else{
                            Image(systemName: "circle")
                        }
                    })
                    .onTapGesture {
                        Task{
                            try await db!.transaction({core in
                                
                                try core.query("Update ToDoItem SET completed = (?) WHERE id = (?)",
                                               !currentItem.completed,
                                               currentItem.id
                                )
                                
                            })
                        }
                    }
                    
                }
                
            }
            
        }
        .navigationTitle("To do")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }
    }
}
