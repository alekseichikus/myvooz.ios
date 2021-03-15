//
//  AddViewController.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 26/12/2019.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit
import  VK_ios_sdk

class AddViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate  {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    
    @IBOutlet weak var photoBlock: UIView!
    @IBOutlet weak var ListTV: UITableView!
    @IBOutlet weak var changeInfoButton: UIButton!
    @IBOutlet weak var buttonTV: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var AuthButton: UIButton!
    @IBOutlet weak var NotAuthUserView: UIView!
    @IBOutlet weak var TitleNAUimage: UIImageView!
    @IBOutlet weak var containerSocialView: UIView!
    
    struct listData{
        var name = ""
        var icon_name = ""
        var select_item_name = ""
        var type = 0
        var action = ""
    }
    var lds = [listData]()
    let SCOPE = ["email"]
    var customData = CustomData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerSocialView.layer.cornerRadius = 5
        
        containerSocialView.layer.borderWidth = 1
        containerSocialView.layer.borderColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        var ld1 = listData()
        ld1.icon_name = "icon-users"
        ld1.name = "Число студентов"
        ld1.select_item_name = "23"
        lds.append(ld1)
        
        var ld2 = listData()
        ld2.icon_name = "icon-user-2"
        ld2.name = "Староста"
        ld2.select_item_name = "Даянов Артур"
        lds.append(ld2)
        
        var ld3 = listData()
        ld3.icon_name = "icon-mailbox"
        ld3.name = "Почта"
        ld3.select_item_name = "ib116@gmail.com"
        ld3.type = 1
        ld3.action = "mailto://mokshantsev.aleksei@yandex.ru"
        lds.append(ld3)
        
        ListTV.separatorStyle = .none
        ListTV.isScrollEnabled = false
        
        buttonTV.separatorStyle = .none
        buttonTV.isScrollEnabled = false
        
        ListTV.delegate = self
        ListTV.dataSource = self
        
        buttonTV.delegate = self
        buttonTV.dataSource = self
        
        photoBlock.layer.cornerRadius = 30
        changeInfoButton.layer.cornerRadius = 12
        
        customData.addTopBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: buttonTV, width: 1)
        customData.changeImageColor(image: changeInfoButton.imageView!, color: UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1))
        customData.changeImageColor(image: TitleNAUimage, color: UIColor(displayP3Red: 143/255, green: 152/255, blue: 168/255, alpha: 1))
        customData.changeImageColor(image: AuthButton.imageView!, color: UIColor.white)
        AuthButton.layer.cornerRadius = 20
        
        var VK_APP_ID = "7261626"
        let sdkInstance = VKSdk.initialize(withAppId: VK_APP_ID)
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
        VKSdk.wakeUpSession(SCOPE) { (state, error) -> Void in
            if state == VKAuthorizationState.authorized {
                print("Authorized")
                if VKSdk.isLoggedIn() {
                    let userId = VKSdk.accessToken().userId
                    var rresponse:Any
                    if (userId != nil) {
                        self.NotAuthUserView.isHidden = true
                    }
                    
                }
            }
            else{
                self.NotAuthUserView.isHidden = false
            }
        }
        
        setupNavigationController()
    }
    @IBAction func AuthButtonClick(_ sender: Any) {
        VKSdk.wakeUpSession(SCOPE) { (state, error) -> Void in
            if state == VKAuthorizationState.authorized {
                print("Authorized")
            } else if error != nil {
                print(error)
            } else {
                print("Authorize....")
                var result = VKSdk.authorize(self.SCOPE)
            }
            
        }
        self.vkGetUser()
    }
    
    func vkGetUser(){
        if VKSdk.isLoggedIn() {
            let userId = VKSdk.accessToken().userId
            var rresponse:Any
            if (userId != nil) {
                VKApi.users().get([VK_API_FIELDS:"first_name, last_name, id, photo_100, sex, bdate, country",
                                   VK_API_USER_ID: userId])!.execute(resultBlock: { (response) -> Void in
                                    let json = JSON(arrayLiteral: response!.json)
                                    print(json)
                                    print(json[0][0]["first_name"])
                                    
                                    
                                   }, errorBlock: { (error) -> Void in
                                    
                                   })
            }
            
        }
    }
    
    func setupNavigationController(){
        let grad = CAGradientLayer()
        grad.frame = view.bounds
        grad.frame.size.width = view.frame.width
        grad.frame.size.height = view.frame.height
        grad.colors = [UIColor(displayP3Red: 101/255, green: 122/255, blue: 191/255, alpha: 1).cgColor, UIColor(displayP3Red: 101/255, green: 122/255, blue: 191/255, alpha: 1).cgColor]
        grad.startPoint = CGPoint(x:0.0, y:0)
        grad.endPoint = CGPoint(x: 1.0, y: 0.0)
        grad.locations = [0.0, 1.0]
        if let image = customData.getImageFrom(gradientLayer: grad) {
            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        }
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        
        setNeedsStatusBarAppearanceUpdate()
    }
    @IBAction func exitButtonClick(_ sender: Any) {
        VKSdk.forceLogout()
        NotAuthUserView.isHidden = false
    }
    @IBAction func clickMailButton(_ sender: Any) {
        if let indexPath = (sender as AnyObject).tag {
            if let url = NSURL(string: lds[indexPath].action){
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
}
extension AddViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ListTV.self{
            return lds.count
        }
        else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ListTV.self{
            let cell:ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
            if indexPath.item % 2 != 0{
                cell.layer.backgroundColor = UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1).cgColor
            }
            cell.name.text = lds[indexPath.item].name
            cell.infoLabel.text = lds[indexPath.item].select_item_name
            cell.infoButton.setTitle(lds[indexPath.item].select_item_name, for: .normal)
            cell.iconImageView.image = UIImage(named: lds[indexPath.item].icon_name)
            cell.infoButton.setTitleColor(UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1), for: .normal)
            customData.changeImageColor(image: cell.iconImageView, color: UIColor(displayP3Red: 161/255, green: 165/255, blue: 178/255, alpha: 1))
            cell.selectionStyle = .none
            cell.infoLabel.isUserInteractionEnabled = true
            if lds[indexPath.item].type == 1{
                cell.infoButton.tag = indexPath.item
                cell.infoButton.isHidden = false
                cell.infoLabel.isHidden = true
            }
            else{
                cell.infoButton.isHidden = true
                cell.infoLabel.isHidden = false
            }
            return cell
        }
        else{
            let cell:AddVCButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddVCButtonTableViewCell", for: indexPath) as! AddVCButtonTableViewCell
            customData.changeImageColor(image: cell.iconImageView, color: UIColor(displayP3Red: 161/255, green: 165/255, blue: 178/255, alpha: 1))
            
            customData.changeImageColor(image: cell.iconRightImageView, color: UIColor(displayP3Red: 201/255, green: 205/255, blue: 218/255, alpha: 1))
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == ListTV.self{
            return 35
        }
        else{
            return 65
        }
    }
}
