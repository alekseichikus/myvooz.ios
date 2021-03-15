//
//  SecondPageViewController.swift
//  USATU6
//
//  Created by aleksei on 01.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController {

    @IBOutlet weak var teacherButton: UIButton!
    @IBOutlet weak var studentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor.clear
        navigationController?.navigationBar.isTranslucent = true
        let yourBackImage = #imageLiteral(resourceName: "icon-angle-left")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        
        let grad = CAGradientLayer()
        grad.frame = view.bounds
        grad.frame.size.width = view.frame.width
        grad.frame.size.height = view.frame.height
        grad.colors = [UIColor(displayP3Red: 151/255, green: 150/255, blue: 240/255, alpha: 1).cgColor, UIColor(displayP3Red: 251/255, green: 199/255, blue: 212/255, alpha: 1).cgColor]
        grad.startPoint = CGPoint(x:1.0, y:0.0)
        grad.endPoint = CGPoint(x: 0.0, y: 1.0)
        grad.locations = [0.0, 1.0]
        view.layer.insertSublayer(grad, at: 0)
        
        teacherButton.layer.cornerRadius = 5
        studentButton.layer.cornerRadius = 5
    }
    @IBAction func studentClickButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstPageViewController") as? FirstPageViewController
        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc?.modalTransitionStyle   = .flipHorizontal
        vc?.key_id = "group_profile"
        vc?.name_request = "groups"
        vc?.name = "группу"
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func teacherClickButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstPageViewController") as? FirstPageViewController
        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc?.modalTransitionStyle   = .flipHorizontal
        vc?.key_id = "teacher_profile"
        vc?.name_request = "teachers"
        vc?.name = "фамилию"
        self.present(vc!, animated: true, completion: nil)
    }

}
