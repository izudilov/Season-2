//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by user179996 on 05.04.2021.
//

import UIKit

class ToDoTableViewController: UITableViewController, UINavigationControllerDelegate {

    private var currentTask: ToDo = ParentTask(name: "Main")
    private var toDoController: ToDoTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ToDoController") as? ToDoTableViewController
        return vc!
    }
    private var newTitle = "All tasks"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = newTitle
        self.navigationController?.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButton))
        self.navigationItem.rightBarButtonItem = button
    }

    @objc func barButton() {
        print("Button Tapped")
        //performSegue(withIdentifier: "addNewTask", sender: self)
        let controller = UIAlertController(
            title: "Task Name",
            message: "Enter the tittle of task",
            preferredStyle: .alert)

          controller.addTextField { textField in
            textField.placeholder = "Enter Task Title"
          }


          let saveAction = UIAlertAction(title: "Save",
                                         style: .default) {
            [weak self] alert in

            let titleTextField = controller.textFields![0]
        
            guard let text = titleTextField.text, !text.isEmpty else {return}
            self!.currentTask.addTask(newTask: Task(name:text))

            self?.tableView.reloadData()

          }

          let cancelAction = UIAlertAction(title: "Cancel",
                                           style: .default)
          controller.addAction(saveAction)
          controller.addAction(cancelAction)

          present(controller, animated: true)
        
    
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTask.taskCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! TableViewCell
        guard let tasks = currentTask.showTasks() as? [ToDo] else {
            fatalError() }
        let item = tasks[indexPath.row]
        cell.tasksName.text = item.name
        cell.countOfTasks.text = "Count of task: \(item.taskCount() - 1)"

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tasks = currentTask.showTasks() as? [ToDo] else {
            fatalError() }
        let item = tasks[indexPath.row]
        toDoController.currentTask = item
        toDoController.newTitle = item.name
        navigationController?.navigationBar.topItem?.title = item.name
        navigationController?.pushViewController(toDoController, animated: true)
    }
}
