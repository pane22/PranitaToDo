//
//  Database.swift
//  todoPranita
//
//  Created by Felix 12 on 28/09/19.
//  Copyright © 2019 SwarajyaIT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Database {
    
    static var shared = Database()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveData(object : [String : String]) {
        
        let toDoTable = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context!) as! ToDo
        
        toDoTable.mainCategory = object["mainCategory"]
        toDoTable.task = object["task"]
        
        do {
            
            try context?.save()
                UIViewController().showToast(message: "Data is Saved")
        } catch {
            UIViewController().showToast(message: "Data isn't Saved")
        }
    }
    
    func getData() -> [ToDo] {
        
        var toDo = [ToDo]()
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        
        do {
            
            toDo = try context?.fetch(fetchData) as! [ToDo]
        } catch {
            UIViewController().showToast(message: "Cannot Fetch Data")
        }
        
        return toDo
    }
    
    func deleteData(index : Int) -> [ToDo] {
        
        var toDo = getData()
        
        context?.delete(toDo[index])
        toDo.remove(at: index)
        
        do {
            try context?.save()
        } catch {
            
            UIViewController().showToast(message: "Cannot Delete")
        }
        
        return toDo
    }
    
    func editData(object : [String : String], indexNo : Int) {
        
        let editInfo = getData()
        
        editInfo[indexNo].mainCategory = object["mainCategory"]
        editInfo[indexNo].task = object["task"]
        
        do {
            
            try context?.save()
        } catch {
            
            UIViewController().showToast(message: "Cannot Edit")
        }
    }
}
