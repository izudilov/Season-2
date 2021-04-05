//
//  ToDo.swift
//  ToDoList
//
//  Created by user179996 on 05.04.2021.
//

import Foundation

protocol ToDo {
    
    var name: String { get set }
    func showTasks() -> Any
    func addTask(newTask: ToDo)
    func taskCount() -> Int
}

class Task: ToDo {
    
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func showTasks() -> Any {
        return name
    }
    
    func addTask(newTask: ToDo) { }
    
    func taskCount() -> Int {
        return 1
    }
}

class ParentTask: ToDo {
    
    var name: String
    init(name: String) {
        self.name = name
    }
    
    private var taskArray = [ToDo]()
    
    func showTasks() -> Any {
        return taskArray
    }
    
    func addTask(newTask: ToDo) {
        taskArray.append(newTask)
    }
    
    func taskCount() -> Int {
        return taskArray.count
    }
    
    
}
