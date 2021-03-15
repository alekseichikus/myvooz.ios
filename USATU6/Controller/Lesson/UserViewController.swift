//
//  UserViewController.swift
//  USATU6
//
//  Created by aleksei on 27.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var nilPhoto: UIImageView!
    @IBOutlet weak var nameTeacher: UILabel!
    @IBOutlet weak var userPhoto: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var userPhotoImage: UIImageView!
    @IBOutlet weak var showScheduleButton: UIButton!
    @IBOutlet weak var clickNumberButton: UIButton!
    @IBOutlet weak var clickMailBoxButton: UIButton!
    @IBOutlet weak var loadDataView: UIView!
    @IBOutlet weak var loadImage: UIImageView!
    
    var id_teacher:Int = 0
    var name_teacher:String = ""

    var customData = CustomData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        nameTeacher.text = name_teacher
        
        customData.rotateImage(loadImage: loadImage)
        getData(week: 1, id_group: 2, type: "teacher")
    }
    func setup(){
        userPhoto.layer.shadowColor = UIColor.darkGray.cgColor
        userPhoto.layer.shadowOffset = CGSize(width: 0, height: 0)
        userPhoto.layer.shadowOpacity = 0.05
        
        mainView.layer.cornerRadius = 20
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        userPhoto.layer.cornerRadius = 28
        userPhotoImage.layer.cornerRadius = 28
        userPhotoImage.layer.masksToBounds = true
        showScheduleButton.tintColor = UIColor.white
    
        customData.changeImageColor(image: nilPhoto, color: UIColor(displayP3Red: 145/255, green: 146/255, blue: 159/255, alpha: 1))
        customData.changeImageColor(image: closeButton.imageView!, color: UIColor(displayP3Red: 173/255, green: 179/255, blue: 187/255, alpha: 1))
        showScheduleButton.layer.backgroundColor = UIColor(displayP3Red: 132/255, green: 160/255, blue: 234/255, alpha: 1).cgColor
        showScheduleButton.layer.cornerRadius = 4
        showScheduleButton.setImage( UIImage(named: "icon-schedule-week"), for: .normal)
        customData.changeImageColor(image: showScheduleButton.imageView!, color: UIColor.white)
    }
    func getData(week:Int, id_group:Int, type:String){
        let urlGetNextLesson = "https://createtogether.ru/lesson?type=week&week=" + String(week) + "&id_"+type+"=" + String(id_group)
        let urlObjGetNextLesson = URL(string: urlGetNextLesson)
        URLSession.shared.dataTask(with: urlObjGetNextLesson!) {(data, response, error) in
            
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                DispatchQueue.main.async {
                    self.loadDataView.isHidden = true
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clickMainBoxButton(_ sender: Any) {
        /*if let indexPath = (sender as AnyObject).tag {
            if let url = NSURL(string: "mailto://mokshantsev.aleksei@yandex.ru"){
                UIApplication.shared.openURL(url as URL)
            }
        }*/
    }
    @IBAction func clickNumberButton(_ sender: Any) {
        /*if let indexPath = (sender as AnyObject).tag {
            if let url = NSURL(string: "tel://89991340640"){
                UIApplication.shared.openURL(url as URL)
            }
        }*/
    }
    @IBAction func clickShowScheduleButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "UserScheduleViewController") as? UserScheduleViewController
        controller?.id_teacher = id_teacher
        customData.presentModalView(view: self, controller: controller!, YOffset: 86)
    }
}
