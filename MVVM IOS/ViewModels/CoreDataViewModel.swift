//
//  CoreDataViewModel.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 12/12/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataViewModel{
    
    var coreDataEvent:((_ data:CoreDataEvent)->Void)?
    
    func save(data: TaskModel) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
        
      let managedContext =
        appDelegate.persistentContainer.viewContext
        
      let entity =
        NSEntityDescription.entity(forEntityName: "TaskDB",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        person.setValue(data.title, forKeyPath: "title")
        person.setValue(data.id, forKeyPath: "id")
        person.setValue(data.description, forKeyPath: "desc")
        
      do {
        try managedContext.save()
          self.coreDataEvent?(.onUpdate(person))
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func fetchData(){
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
        
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "TaskDB")
        
          do {
            let taskListData = try managedContext.fetch(fetchRequest)
            coreDataEvent?(.onFetchdata(taskListData))
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
    
    func deleteData(model:NSManagedObject){
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        managedContext.delete(model)
        do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
        
        fetchData()
        
    }
}

enum CoreDataEvent{
    case onUpdate(_ data:NSManagedObject)
    case onFetchdata(_ data:[NSManagedObject])
}
