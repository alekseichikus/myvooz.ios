//
//  InfoGroupViewController.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 26/12/2019.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class InfoGroupViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var photoBlock: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileVKButton: UIButton!
    @IBOutlet weak var EmptyLinkErrorView: UIView!
    @IBOutlet weak var EmptyLinkErrorImage: UIImageView!
    @IBOutlet weak var LoadView: UIView!
    @IBOutlet weak var InternetErrorView: UIView!
    @IBOutlet weak var loadImageView: UIImageView!
    @IBOutlet weak var nameGroupLabel: UILabel!
    
    var name_group = ""
    var customData = CustomData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameGroupLabel.text = name_group
        
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
        mainView.layer.cornerRadius = 20
        photoBlock.layer.cornerRadius = 30
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customData.changeImageColor(image: closeButton.imageView!, color: UIColor(displayP3Red: 173/255, green: 179/255, blue: 187/255, alpha: 1))
        customData.changeImageColor(image: EmptyLinkErrorImage, color: UIColor(displayP3Red: 173/255, green: 179/255, blue: 187/255, alpha: 1))
        EmptyLinkErrorView.layer.cornerRadius = 5
        profileVKButton.layer.cornerRadius = 5
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
                    self.LoadView.isHidden = true
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
    @IBAction func closeButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
