//
//  LoadPageViewController.swift
//  USATU6
//
//  Created by aleksei on 17.11.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class LoadPageViewController: UIViewController {
    
    @IBOutlet weak var loadImage: UIImageView!
    
    var id_week:Int = 0
    var customData = CustomData()
    @IBOutlet weak var errorUpdateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getData()
        
        customData.rotateImage(loadImage: loadImage)
    }
    func setup(){

        customData.changeImageColor(image: loadImage, color: UIColor(displayP3Red: 161/255, green: 165/255, blue: 178/255, alpha: 1))
    }
    @objc func getData(){
        let urlGetLessons = "https://createtogether.ru/lesson?type=week"
        let urlObjGetLessons = URL(string: urlGetLessons)
        URLSession.shared.dataTask(with: urlObjGetLessons!) {(data, response, error) in
            
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode(Week_Number.self, from: data)
                DispatchQueue.main.async {
                    if JSONLessons.state == 1{
                        self.customData.setData(keyData: "id_week_profile", data: String(JSONLessons.number_week))
                        self.customData.setData(keyData: "name_week_profile", data: String(JSONLessons.number_week))
                        let appdelegate = UIApplication.shared.delegate as! AppDelegate
                        let tabBarController = UITabBarController()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "MainController") as? MainController
                        self.customData.addTopBorder(color: UIColor(displayP3Red: 247/255, green: 247/255, blue: 247/255, alpha: 1), view: tabBarController.tabBar, width: 1)
                        tabBarController.tabBar.isTranslucent = false
                        tabBarController.tabBar.shadowImage = UIImage()
                        tabBarController.tabBar.backgroundImage = UIImage()
                        tabBarController.tabBar.layer.borderWidth = 0.0
                        tabBarController.tabBar.clipsToBounds = true;
                        let vc1 = storyboard.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController
                        let vc2 = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
                        let tabViewController1 = mainNavigationController(rootViewController: vc!)
                        let tabViewController2 = mainNavigationController(rootViewController: vc2!)
                        let tabViewController4 = mainNavigationController(rootViewController: vc1!)
                        
                        tabViewController1.tabBarItem = UITabBarItem(title: "Главная", image: #imageLiteral(resourceName: "white_logo"),tag: 1)
                        tabViewController2.tabBarItem = UITabBarItem(title: "Настройки",image: UIImage(named: "icon-user"), tag:2)
                        tabViewController4.tabBarItem = UITabBarItem(title: "Расписание",image: #imageLiteral(resourceName: "icon-calendar-50") ,tag:2)
                        
                        
                        tabBarController.tabBar.backgroundImage = UIImage()
                        tabBarController.viewControllers = [tabViewController1, tabViewController4, tabViewController2]
                        tabBarController.tabBar.barTintColor = UIColor.white
                        tabBarController.tabBar.tintColor = UIColor(displayP3Red: 100/255, green: 110/255, blue: 120/255, alpha: 1)
                        tabBarController.tabBar.unselectedItemTintColor = UIColor(displayP3Red: 146/255, green: 155/255, blue: 166/255, alpha: 1)
                        appdelegate.window!.rootViewController = tabBarController
                        appdelegate.window!.makeKeyAndVisible()
                    }
                    else if JSONLessons.state == 2{
                        self.errorUpdateLabel.isHidden = false
                        self.loadImage.isHidden = true
                    }
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
}
