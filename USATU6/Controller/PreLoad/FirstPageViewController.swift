//
//  FirstPageViewController.swift
//  USATU6
//
//  Created by aleksei on 01.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var label_2: UILabel!
    
    private var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
    
    var name:String = ""
    var key_id:String = ""
    var name_request:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 5
        label_1.text = "Выберите свою " + name
        label_2.text = "Для доступа к расписанию необходимо выбрать свою " + name
        nextButton.tintColor = UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        nextButton.semanticContentAttribute = .forceRightToLeft
        firstView.layer.cornerRadius = 20
        firstView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBAction func clickNextButton(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller!)
        controller?.modalPresentationStyle = .custom
        controller?.key_id = key_id
        controller?.name_request = name_request
        controller?.FirstPageVC = self
        controller?.transitioningDelegate = detailsTransitioningDelegate
        present(controller!, animated: true, completion: nil)
  
    }
    func reloadMData(){
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "id_group_profile") != nil) ||  (defaults.string(forKey: "id_teacher_profile") != nil){
            
            if defaults.string(forKey: "id_group_profile") != nil{
                defaults.set(0, forKey: "id_type_profile")
            }
            else{
                defaults.set(1, forKey: "id_type_profile")
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoadPageViewController") as? LoadPageViewController
            vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc?.modalTransitionStyle   = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
