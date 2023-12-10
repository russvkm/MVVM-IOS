//
//  TaskCell.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 11/12/23.
//

import UIKit
import CoreData

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var taskTitle:UILabel!
    static let identifier = "TaskCell"
    weak var delegate:TaskProtocol?
    var task:NSManagedObject? = nil
    static func uiNib()->UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func showData(task taskLabel:NSManagedObject){
        taskTitle.text = taskLabel.value(forKeyPath: "title") as? String
        taskTitle.isUserInteractionEnabled = true
        self.task = taskLabel
        taskTitle.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(onClickTask)))
    }
    
    @objc private func onClickTask(){
        delegate?.onDeleteTask(task: task)
    }
    
}

protocol TaskProtocol:AnyObject{
    func onDeleteTask(task onDelete:NSManagedObject?)
}

