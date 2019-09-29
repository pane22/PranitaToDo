//
//  ViewController.swift
//  todoPranita
//
//  Created by Felix 12 on 28/09/19.
//  Copyright © 2019 SwarajyaIT. All rights reserved.
//

import UIKit

//MARK: - this protocol used for mark check on task
protocol CheckImage {
    func changeCheckImg()
}


class ViewController: UIViewController {

    var toDo = [ToDo]()
    var selectedIndexpathRow : Int?
    
    @IBOutlet weak var tableView : UITableView!
    
    var checkImageDelegate: CheckImage?
    var checkImageDelegateArray: [CheckImage] = []
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        let addTaskVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTaskViewController")
        self.navigationController?.pushViewController(addTaskVC!, animated: true)
    }
    
    func strikeOnLabel(_ label : UILabel) {

        let attributedString = NSMutableAttributedString(string: label.text!)

    // Swift 4.1 and below
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        
        label.attributedText = attributedString
    }
    
    func removeStrikeOnLabel(_ label : UILabel) {

        let attributedString = NSMutableAttributedString(string: label.text!)

    // Swift 4.1 and below
        attributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
        
        label.attributedText = attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toDo = Database.shared.getData()
        tableView.reloadData()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toDoCell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoTableViewCell
        
        toDoCell.selectionStyle = .none
        
        var checkMarkImagDelegate : CheckImage?

        checkMarkImagDelegate = toDoCell
        checkImageDelegateArray.append(checkMarkImagDelegate!)
        
        toDoCell.mainCategory.text = toDo[indexPath.row].mainCategory
        toDoCell.task.text = toDo[indexPath.row].task
        
        return toDoCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexpath) in
            
            tableView.beginUpdates()
            
            self.toDo = Database.shared.deleteData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (editAction, indexpath) in
            
            tableView.beginUpdates()
            
            let addTaskVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
            let toDoCell = tableView.cellForRow(at: indexPath) as! ToDoTableViewCell
            
            addTaskVC.dict = ["mainCategory" : self.toDo[indexPath.row].mainCategory!, "task" : self.toDo[indexPath.row].task!]
            addTaskVC.flag = true
            addTaskVC.indexNo = indexPath.row
            
            self.removeStrikeOnLabel(toDoCell.mainCategory)
            self.removeStrikeOnLabel(toDoCell.task)
            toDoCell.flag = true
            toDoCell.task.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            let delegate = self.checkImageDelegateArray[indexPath.row]
            self.selectedIndexpathRow = indexPath.row
            delegate.changeCheckImg()
            
            self.navigationController?.pushViewController(addTaskVC, animated: true)

            tableView.endUpdates()
        }
        
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toDoCell = tableView.cellForRow(at: indexPath) as! ToDoTableViewCell
        
        let delegate = checkImageDelegateArray[indexPath.row]
        selectedIndexpathRow = indexPath.row
          
        toDoCell.task.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        strikeOnLabel(toDoCell.mainCategory)
        strikeOnLabel(toDoCell.task)
        
        delegate.changeCheckImg()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
