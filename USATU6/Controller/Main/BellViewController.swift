//
//  BellViewController.swift
//  USATU6
//
//  Created by aleksei on 06.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class BellViewController: UIViewController {

    @IBOutlet weak var NotificationTableView: UICollectionView!
    @IBOutlet weak var InternetErrorView: UIView!
    @IBOutlet weak var LoadView: UIView!
    @IBOutlet weak var loadImageView: UIImageView!
    @IBOutlet weak var IETitleImageView: UIImageView!
    
    var notifications = [notification]()
    var customData = CustomData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CheckInternet.isConnectedToNetwork(){
            getData(id_group: 31)
            InternetErrorView.isHidden = true
            
            customData.rotateImage(loadImage: loadImageView)
        }
        else{
            InternetErrorView.isHidden = false
        }
        
        setup()
    }
    
    func setup(){
        NotificationTableView.layer.cornerRadius = 15
        customData.changeImageColor(image: IETitleImageView, color: UIColor(displayP3Red: 143/255, green: 152/255, blue: 168/255, alpha: 1))
        
        view.layer.backgroundColor = UIColor(displayP3Red: 101/255, green: 122/255, blue: 191/255, alpha: 1).cgColor
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon-angle-left")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon-angle-left")
        
        customData.setGradientMainView(view: view, gradient: customData.firstGradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        setNeedsStatusBarAppearanceUpdate()
    }
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    @IBAction func clickNotificationButton(_ sender: Any) {
        if let indexPath = (sender as AnyObject).tag {
            if let url = NSURL(string: "https://vk.me/myvoooz"){
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    func getData(id_group:Int){
        let urlGetNextLesson = "https://createtogether.ru/profile?type=notification&id_group=" + String(id_group)
        let urlObjGetNextLesson = URL(string: urlGetNextLesson)
        URLSession.shared.dataTask(with: urlObjGetNextLesson!) {(data, response, error) in
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode([notification].self, from: data)
                DispatchQueue.main.async {
                    self.notifications = JSONLessons
                    self.NotificationTableView.reloadData()
                    self.LoadView.isHidden = true
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
}

extension BellViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:notificationCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "notificationCollectionViewCell", for: indexPath) as! notificationCollectionViewCell
        
        cell.photoView.layer.cornerRadius = 25
        cell.button.layer.cornerRadius = 3
        cell.complainButton.layer.cornerRadius = 3
        cell.photoView.layer.shadowColor = UIColor.darkGray.cgColor
        cell.photoView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.photoView.layer.shadowOpacity = 0.15
        cell.button.layer.backgroundColor = UIColor(displayP3Red: 240/255, green: 245/255, blue: 250/255, alpha: 1).cgColor
        cell.complainButton.tag = indexPath.item
        cell.complainButton.layer.backgroundColor = UIColor(displayP3Red: 240/255, green: 245/255, blue: 250/255, alpha: 1).cgColor
        cell.photoImage.layer.cornerRadius = 25
        cell.photoImage.layer.masksToBounds = true
        cell.criticalView.layer.cornerRadius = 11
        customData.addBottomBorder(color: UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1), view: cell, width: 1)
        
        let session  = URLSession.shared
        if notifications[indexPath.item].user_image != "" {
            let url:URL = URL(string: notifications[indexPath.item].user_image)!
            let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
                if data != nil{
                    let image = UIImage(data: data!)
                    if image != nil{
                        DispatchQueue.main.async(execute: {
                            cell.photoImage.image = image
                        })
                    }
                }
            })
            task.resume()
        }
        else{
            
        }
        
        cell.button.tag = indexPath.item
        cell.positionLabel.text = notifications[indexPath.item].position
        cell.name.text = notifications[indexPath.item].user_name
        cell.clipsToBounds = false
        cell.dateLAbel.text = notifications[indexPath.item].date
        cell.textLabel.text = notifications[indexPath.item].text
        
        if notifications[indexPath.item].type == 1{
            cell.button.isHidden = false
            cell.complainButton.isHidden = true
        }
        else{
            cell.button.isHidden = true
            cell.complainButton.isHidden = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthText = view.frame.width - 16 - 16
        var size = CGSize(width: widthText, height: 1000)
        let attributes = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 14)]
        let estimatedFrame = NSString(string: notifications[indexPath.item].text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 16 + 50 + 46 + 24)
    }

}
