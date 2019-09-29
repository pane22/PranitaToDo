//
//  AddTaskViewController.swift
//  todoPranita
//
//  Created by Felix 12 on 28/09/19.
//  Copyright © 2019 SwarajyaIT. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var mainCategoryTF: UITextField!
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var addtaskBtn: UIButton!
    
    var mainCategoryArray = ["Health", "Personal", "Work", "Design"]
    var selectedItem = ""
    var newPicker : UIPickerView!
    
    var dict : [String : String]!
    var indexNo : Int?
    var flag : Bool?
    
    @IBAction func addTaskTapped(_ sender: UIButton) {
        
        if let mainCategory = mainCategoryTF.text , taskTextView.text != "Write task here..." {
            
            let task = taskTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
            dict = ["mainCategory" : mainCategory, "task" : task]
            
            if flag != nil {
                
                Database.shared.editData(object: dict, indexNo: indexNo!)
            } else {
                
                Database.shared.saveData(object: dict)
            }
            
            self.navigationController?.popViewController(animated: true)
        } else {
            
            let alert = UIAlertController(title: "Error", message: "Some Fields are Empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap() {
        
        newPicker.removeFromSuperview()
        view.endEditing(true)
    }

    @objc func pickerSelect(_ sender: UIBarButtonItem) {
        
        mainCategoryTF.text = selectedItem
        view.endEditing(true)
    }
    
    func showData() {
        
        mainCategoryTF.text = dict["mainCategory"]
        taskTextView.text = dict["task"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newPicker = UIPickerView()
        newPicker.delegate = self
        
        newPicker.frame = CGRect(x: 0, y: self.view.frame.height - 200, width: self.view.frame.width, height: 200)
        newPicker.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        mainCategoryTF.inputView = newPicker
        mainCategoryTF.inputAccessoryView = UIToolbar().toolBarPicker(mySelect: #selector(pickerSelect(_:)))
        
        taskTextView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        taskTextView.layer.borderWidth = 0.5
        taskTextView.layer.cornerRadius = 5.0
        taskTextView.delegate = self
        
        addtaskBtn.layer.cornerRadius = 5
        
        setTapGesture()
        
        if flag == true {
            
            showData()
        }
        // Do any additional setup after loading the view.
    }
}

extension AddTaskViewController : UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if textView == taskTextView {
            
            if textView.text == "Write task here..." {
                
                taskTextView.text = nil
            }
            
            taskTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            
            textView.text = "Write task here..."
            textView.textColor = UIColor.lightGray
        }
    }
}


extension AddTaskViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainCategoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return mainCategoryArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedItem = mainCategoryArray[row]
    }
}


