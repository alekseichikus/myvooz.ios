//
//  FilterViewController.swift
//  USATU6
//
//  Created by aleksei on 15.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet var GroupButtons: [UIButton]!
    @IBOutlet weak var teacherButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var functionTV: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nextWeekButton: UIButton!
    @IBOutlet weak var prevWeekButton: UIButton!
    
    var id_week = 0, id_type = 0, id_teacher = 0, id_group = 0
    var name_week = "", name_teacher = "", name_group = ""
    var selectedColor = UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1)
    
    var datas = [dataProfile]()
    var datas2 = [dataProfile]()
    var ScheduleVC:ScheduleViewController!
    var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
    var customData = CustomData()
    
    enum ActivityType:Int{
        case groups
        case teachers
    }
    
    struct dataProfile{
        var name:String?
        var select_name:String?
        var key_name:String?
        var request_name:String?
    }

    @IBAction func closeClickButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if id_type == 0{
            customData.addBottomBorder(color: selectedColor, view: groupButton, width: 3)
            
            groupButton.layer.cornerRadius = 2
            groupButton.setTitleColor(UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1), for: .normal)
            teacherButton.layer.cornerRadius = 2
            teacherButton.setTitleColor(UIColor(displayP3Red: 150/255, green: 150/255, blue: 150/255, alpha: 1), for: .normal)
        }
        else{
            customData.addBottomBorder(color: selectedColor, view: teacherButton, width: 3)
            teacherButton.layer.cornerRadius = 2
            teacherButton.setTitleColor(UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1), for: .normal)
            groupButton.layer.cornerRadius = 2
            groupButton.setTitleColor(UIColor(displayP3Red: 150/255, green: 150/255, blue: 150/255, alpha: 1), for: .normal)
        }
        
        setup()
        reloadMData()
    }
    func setup(){
        customData.changeImageColor(image: closeButton.imageView!, color: UIColor(displayP3Red: 173/255, green: 179/255, blue: 187/255, alpha: 1))
        
        mainView.layer.cornerRadius = 20
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        prevWeekButton.layer.cornerRadius = 4
        nextWeekButton.layer.cornerRadius = 4
        searchButton.layer.cornerRadius = 4
        prevWeekButton.layer.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        nextWeekButton.layer.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        searchButton.layer.backgroundColor = UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1).cgColor
        
        functionTV.isScrollEnabled = false
        functionTV.separatorStyle = .none
    }
    @IBAction func NextClickButton(_ sender: Any) {
        if id_week < 20 {
            id_week += 1
            name_week = String(id_week)
            reloadMData()
        }
    }
    @IBAction func PrevClickButton(_ sender: Any) {
        if id_week > -1 {
            id_week -= 1
            name_week = String(id_week)
            reloadMData()
        }
    }
    @IBAction func SeacrhClickButton(_ sender: Any) {
        if (id_type == 0 && id_group == 0) || (id_type == 1 && id_teacher == 0){
            functionTV.shake()
        }
        else{
            ScheduleVC.reloadMainData(id_group: id_group, id_teacher: id_teacher, id_week: id_week, id_type: id_type, name_group: name_group, name_teacher: name_teacher, name_week: name_week)
            dismiss(animated: true, completion: nil)
        }
        
    }
    func reloadMData(){
        datas2 = [dataProfile]()
        datas = [dataProfile]()
        var ds1 = dataProfile()
        var ds2 = dataProfile()
        var ds3 = dataProfile()
        ds1.name = "Неделя"
        ds1.key_name = "week"
        ds1.request_name = "weeks"
        ds2.name = "Преподаватель"
        ds2.key_name = "teacher"
        ds2.request_name = "teachers"
        ds3.name = "Группа"
        ds3.key_name = "group"
        ds3.request_name = "groups"
        ds1.select_name = name_week
        ds2.select_name = name_teacher
        ds3.select_name = name_group
        
        datas.append(ds2)
        datas.append(ds1)
        datas2.append(ds3)
        datas2.append(ds1)
        
        functionTV.reloadData()
    }
    @IBAction func clickResetButton(_ sender: Any) {
        ScheduleVC.resetMainData()
        dismiss(animated: true, completion: nil)
    }
    func getSelectedActivityType() -> ActivityType{
        for (index, button) in GroupButtons.enumerated(){
            if button.titleLabel?.textColor	 == UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1){
                return ActivityType(rawValue: index) ?? ActivityType(rawValue: 0)!
            }
        }
        return ActivityType(rawValue: 0)!
    }
    @IBAction func activityTypeSelected(_ sender: UIButton) {
        GroupButtons.forEach({
            $0.backgroundColor = UIColor.white
            $0.setTitleColor(UIColor(displayP3Red: 150/255, green: 150/255, blue: 150/255, alpha: 1), for: .normal)
            customData.addBottomBorder(color: UIColor.white, view: $0, width: 3)
        })
        sender.backgroundColor = UIColor.white
        customData.addBottomBorder(color: selectedColor, view: sender, width: 3)
        sender.setTitleColor(UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1), for: .normal)
        let activityType:ActivityType = getSelectedActivityType()
        
        if activityType == ActivityType.groups{
            id_type = 0
        }
        else{
            id_type = 1
        }
        
        functionTV.reloadData()
    }
}
extension FilterViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var data_ = [dataProfile]()
        if id_type == 0{
            data_ = datas2
        }
        else{
            data_ = datas
        }
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        controller?.FilterVC = self
        controller?.key_id = data_[indexPath.item].key_name!
        controller?.name_request = data_[indexPath.item].request_name!
        customData.presentModalView(view: self, controller: controller!, YOffset: 86)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:profileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! profileTableViewCell
        var data_ = [dataProfile]()
        if id_type == 0{
            data_ = datas2
        }
        else{
            data_ = datas
        }
        customData.changeImageColor(image: cell.angle_right_image, color: UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 1))
        cell.select_name_label.text = data_[indexPath.item].select_name
        cell.type_name_label.text = data_[indexPath.item].name
        if indexPath.item != 0{
            customData.addTopBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: cell, width: 1)
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(65)
    }

}
