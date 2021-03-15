//
//  changeInfoViewController.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 26/12/2019.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class changeInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var numbStudentsTextField: UITextField!
    @IBOutlet weak var FIOTextFields: UITextField!
    
    var customData = CustomData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailTextField.delegate = self
        numbStudentsTextField.delegate = self
        FIOTextFields.delegate = self
        
        customData.addBottomBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: mailTextField, width: 1)
        customData.addBottomBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: numbStudentsTextField, width: 1)
        
        customData.addBottomBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: FIOTextFields, width: 1)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
