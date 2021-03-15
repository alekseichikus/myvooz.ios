//
//  ProfileViewController.swift
//  USATU6
//
//  Created by aleksei on 05.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var teacherButton: UIButton!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet var selectButtons: [UIButton]!
    @IBOutlet weak var hideEmpryTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var listLinkTV: UITableView!
    @IBOutlet weak var heightMainViewConstraint: NSLayoutConstraint!
    
    private var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
    
    var id_profile_tv:String = "ProfileTableViewCell"
    var selectedType:Int = 0
    
    var datas = [dataProfile]()
    var datas_ = [dataProfile]()
    var customData = CustomData()
    
    struct dataProfile{
        var name:String = ""
        var select_name:String = ""
    }
    enum ActivityType:Int{
        case student
        case teacher
    }
    struct dataSwift{
        var title:String = ""
        var enabled:Bool = false
    }
    struct linkStruct{
        var title:String = ""
        var image:String = ""
    }
    
    var links = [linkStruct]()
    
    var swiftCell = [dataSwift]()
    let defaults = UserDefaults.standard
    var selectedColor = UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listLinkTV.isScrollEnabled = false
        
        mainView.layer.cornerRadius = 15
        customData.setGradientMainView(view: view, gradient: customData.firstGradient)
        customData.setupNavigationController(navigationController: self.navigationController!)
        
        customData.addTopBorder(color: UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1), view: hideEmpryTableView, width: 1)
        customData.addBottomBorder(color: UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1), view: hideEmpryTableView, width: 1)
        
        listLinkTV.separatorStyle = .none
        
        var dss1 = dataSwift()
        dss1.title = "Скрывать пустые пары"
        if defaults.bool(forKey: "id_hide_empty_profile"){
            dss1.enabled = defaults.bool(forKey: "id_hide_empty_profile")
        }
        else{
            dss1.enabled = false
        }
        
        swiftCell.append(dss1)
        
        var ds1 = dataProfile()
        ds1.name = "Ваша группа"
        
        if let data = defaults.string(forKey: "name_group_profile") {
            ds1.select_name = String(data)
        }
        else{
            ds1.select_name = "Не выбрано"
        }
        datas.append(ds1)
        var ds2 = dataProfile()
        ds2.name = "Вы преподаватель"
        if let data = defaults.string(forKey: "name_teacher_profile") {
            ds2.select_name = String(data)
        }
        else{
            ds2.select_name = "Не выбрано"
        }
        if let data = defaults.string(forKey: "id_type_profile") {
            selectedType = Int(data)!
        }
        else{
            if let data = defaults.string(forKey: "id_group_profile") {
                selectedType = 0
                defaults.set(0, forKey: "id_type_profile")
            }
            else if let data = defaults.string(forKey: "id_teacher_profile") {
                selectedType = 1
                defaults.set(1, forKey: "id_type_profile")
            }
        }
        datas_.append(ds2)
        
        if heightMainViewConstraint.constant < view.frame.height - 48{
            heightMainViewConstraint.constant = view.frame.height - 126
        }
        
        profileTableView?.separatorStyle = .none
        
        if selectedType == 0{
            studentButton.setTitleColor(UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1), for: .normal)
            customData.addBottomBorder(color: selectedColor, view: studentButton, width: 3)
            
            teacherButton.layer.cornerRadius = 4
            teacherButton.setTitleColor(UIColor(displayP3Red: 150/255, green: 150/255, blue: 150/255, alpha: 1), for: .normal)
        }
        else{
            teacherButton.setTitleColor(UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1), for: .normal)
            customData.addBottomBorder(color: selectedColor, view: teacherButton, width: 3)
            
            studentButton.layer.cornerRadius = 4
            studentButton.setTitleColor(UIColor(displayP3Red: 150/255, green: 150/255, blue: 150/255, alpha: 1), for: .normal)
            
        }
        
        hideEmpryTableView.delegate = self
        hideEmpryTableView.dataSource = self
        hideEmpryTableView.isScrollEnabled = false
        hideEmpryTableView.separatorStyle = .none
        
        profileTableView.delegate = self
        profileTableView.isScrollEnabled = false
        profileTableView.dataSource = self
        
        
        var ls1 = linkStruct()
        ls1.title = "Найти свободные аудитории"
        ls1.image = "icon-search"
        links.append(ls1)
        
        var ls3 = linkStruct()
        ls3.title = "Перейти в сообщество"
        ls3.image = "icon-vk"
        links.append(ls3)
        
        var ls2 = linkStruct()
        ls2.title = "Связаться с нами"
        ls2.image = "icon-headset"
        links.append(ls2)
    }
    @IBAction func SwitchButton(_ sender: UISwitch) {
        if sender.isOn{
            defaults.set(true, forKey: "id_hide_empty_profile")
        }
        else{
            defaults.set(false, forKey: "id_hide_empty_profile")
        }
    }
    @IBAction func callButtonClick(_ sender: Any) {
        if let indexPath = (sender as AnyObject).tag {
            if let url = NSURL(string: "https://vk.me/myvoooz"){
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    @IBAction func activityTypeSelected(_ sender: UIButton) {

        selectButtons.forEach({
            $0.setTitleColor(UIColor(displayP3Red: 150/255, green: 150/255, blue: 150/255, alpha: 1), for: .normal)
            customData.addBottomBorder(color: UIColor.white, view: $0, width: 3)
        })

        sender.setTitleColor(UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1), for: .normal)
        customData.addBottomBorder(color: selectedColor, view: sender, width: 3)
        
        
        let activityType:ActivityType = getSelectedActivityType()
        

        if activityType == ActivityType.student{
            selectedType = 0
            defaults.set(0, forKey: "id_type_profile")
        }
        else{
            selectedType = 1
            defaults.set(1, forKey: "id_type_profile")
        }
        
        profileTableView.reloadData()
    }
    func getSelectedActivityType() -> ActivityType{
        for (index, button) in selectButtons.enumerated(){
            if button.titleLabel?.textColor == UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1){
                return ActivityType(rawValue: index) ?? ActivityType(rawValue: 0)!
            }
        }
        return ActivityType(rawValue: 0)!
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let data = defaults.string(forKey: "name_group_profile") {
            datas[0].select_name = String(data)
        }
        profileTableView.reloadData()
    }
    func reloadMData(){
        let defaults = UserDefaults.standard
        if let data = defaults.string(forKey: "name_group_profile") {
            datas[0].select_name = String(data)
        }
        if let data = defaults.string(forKey: "name_teacher_profile") {
            datas_[0].select_name = String(data)
        }
        profileTableView.reloadData()
    }
    func addTopBorder(color: UIColor, view:UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1)
        view.addSubview(border)
    }
    func addBottomBorder(color: UIColor, view:UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: view.frame.size.height - 3, width: view.frame.size.width, height: 3)
        view.addSubview(border)
    }
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == profileTableView.self{
            return datas.count
        }
        else if tableView == hideEmpryTableView{
            return 1
        }
        else{
            return links.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == profileTableView.self{
        
            let controller = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
            detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller!)
            controller?.modalPresentationStyle = .custom
            detailsTransitioningDelegate.presentedYOffset = 25
            if selectedType == 0{
                controller?.key_id = "group_profile"
                controller?.name_request = "groups"
            }
            else{
                controller?.key_id = "teacher_profile"
                controller?.name_request = "teachers"
            }
            controller?.ProfileVC = self
            controller?.transitioningDelegate = detailsTransitioningDelegate
            present(controller!, animated: true, completion: nil)
        }
        else if tableView == listLinkTV{
            if indexPath.item == 0{
                let vc = storyboard?.instantiateViewController(withIdentifier: "SearchEmptyClassroomViewController") as? SearchEmptyClassroomViewController
                vc?.modalPresentationStyle = .fullScreen
                vc?.modalTransitionStyle   = .coverVertical
                self.present(vc!, animated: true, completion: nil)
            }
            else if indexPath.item == 1{
                if let url = NSURL(string: "https://vk.com/myvoooz"){
                    UIApplication.shared.openURL(url as URL)
                }
            }
            else{
                if let url = NSURL(string: "https://vk.me/myvoooz"){
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == profileTableView.self{
            var cell:profileTableViewCell = tableView.dequeueReusableCell(withIdentifier: id_profile_tv, for: indexPath) as! profileTableViewCell
            if selectedType == 0{
                cell.angle_right_image.image = cell.angle_right_image.image?.withRenderingMode(.alwaysTemplate)
                cell.angle_right_image.tintColor = UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
                addTopBorder(color: UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1), view: cell)
                cell.type_name_label.text = datas[indexPath.item].name
                cell.select_name_label.text = datas[indexPath.item].select_name
            }
            else{
                cell.angle_right_image.image = cell.angle_right_image.image?.withRenderingMode(.alwaysTemplate)
                cell.angle_right_image.tintColor = UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
                addTopBorder(color: UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1), view: cell)
                
                cell.select_name_label.text = datas_[indexPath.item].select_name
                cell.type_name_label.text = datas_[indexPath.item].name
            }
            cell.selectionStyle = .none
            return cell
        }
        else if tableView == hideEmpryTableView{
            var cell:hideEmptyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HideEmptyTableViewCell", for: indexPath) as! hideEmptyTableViewCell
            cell.title.text = swiftCell[indexPath.item].title
            cell.switchEnable.isOn = swiftCell[indexPath.item].enabled
            cell.selectionStyle = .none
            return cell
        }
        else{
            var cell:listLinkProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listLinkProfileTableViewCell", for: indexPath) as! listLinkProfileTableViewCell
            customData.changeImageColor(image: cell.rightImage, color: UIColor(displayP3Red: 177/255, green: 180/255, blue: 181/255, alpha: 1))
            cell.title.text = links[indexPath.item].title
            cell.leftImage.image = UIImage(named: links[indexPath.item].image)
            customData.changeImageColor(image: cell.leftImage, color: UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1))
            cell.selectionStyle = .none
            if indexPath.item != links.count-1{
                customData.addBottomBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: cell, width: 1)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == listLinkTV{
            return CGFloat(55)
        }
        else{
            return CGFloat(65)
        }
    }
}
