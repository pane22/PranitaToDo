//
//  ToDoTableViewCell.swift
//  todoPranita
//
//  Created by Felix 12 on 28/09/19.
//  Copyright © 2019 SwarajyaIT. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell, CheckImage {
   
    func changeCheckImg() {
        
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        _ = viewController.selectedIndexpathRow
        checkMarkBtnTapped(checkBtn)
    }
    

    @IBOutlet weak var checkBtn : UIButton!
    @IBOutlet weak var mainCategory : UILabel!
    @IBOutlet weak var task : UILabel!
    
    var flag : Bool?
    
    @IBAction func checkMarkBtnTapped(_ sender: UIButton) {
        
        if sender.image(for: .normal) == #imageLiteral(resourceName: "icon_unchecked") {
            
            sender.setImage(#imageLiteral(resourceName: "icon_checked"), for: .normal)
        } else {
            
            if flag == true {
                
                sender.setImage(#imageLiteral(resourceName: "icon_unchecked"), for: .normal)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
