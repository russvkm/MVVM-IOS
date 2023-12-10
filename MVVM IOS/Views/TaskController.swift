//
//  TaskController.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 11/12/23.
//

import Foundation
import UIKit
import CoreData

class TaskController:UIViewController{
    @IBOutlet weak var taskList:UITableView!
    var taskListData: [NSManagedObject] = []
    var coreDataViewModel = CoreDataViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        taskList.dataSource = self
        taskList.register(TaskCell.uiNib(), forCellReuseIdentifier: TaskCell.identifier)
        dataObserver()
    }
    
    @IBAction func addTask(_ sender:Any){
        showInputBox()
    }
    
    private func showInputBox(){
        let inputBox = UIAlertController(title: "Add Task", message: "", preferredStyle: .alert)
        inputBox.addTextField { textFiled in
            textFiled.placeholder = "Enter text"
        }
        inputBox.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            let label = inputBox.textFields?.first?.text
            let uuid = UUID().uuidString
            let data = TaskModel(title: label, id: uuid, description: nil)
            self.coreDataViewModel.save(data:data)
        }))
        self.present(inputBox, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataViewModel.fetchData()
    }
    
    private func dataObserver(){
        coreDataViewModel.coreDataEvent = {
            event in
            switch event{
            case .onFetchdata(let dataList):
                self.taskListData = dataList
                self.taskList.reloadData()
                break
            case .onUpdate(let data):
                self.taskListData.append(data)
                self.taskList.reloadData()
            }
        }
    }
}

extension TaskController:UITableViewDataSource, TaskProtocol{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.showData(task: taskListData[indexPath.row])
        cell.delegate = self
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(taskListData[indexPath.row])
//    }
    
    func onDeleteTask(task onDelete: NSManagedObject?) {
        deleteDialog(task: onDelete)
        
    }
    
    private func deleteDialog(task onDelete: NSManagedObject?){
        let alert = UIAlertController(title: "Delete!", message: "This action will permanently delete your task", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { handler in
            guard let data = onDelete else { return }
            self.coreDataViewModel.deleteData(model: data)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
}

struct TaskModel{
    let title:String?
    let id:String
    let description:String?
}
