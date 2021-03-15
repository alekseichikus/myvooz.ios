//
//  ScheduleViewController.swift
//  USATU6
//
//  Created by aleksei on 13.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class UserScheduleViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var dayListCV: UICollectionView!
    @IBOutlet weak var weekScheduleTV: UITableView!
    @IBOutlet weak var heightMainViewConstrains: NSLayoutConstraint!
    @IBOutlet weak var heightViewConstrains: NSLayoutConstraint!
    @IBOutlet weak var notScheduleImage: UIImageView!
    @IBOutlet weak var notScheduleLabel: UILabel!
    @IBOutlet weak var notSchedulePostLabel: UILabel!
    @IBOutlet weak var infoScheduleLabel: UILabel!
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loadDataView: UIView!
    @IBOutlet weak var loadImage: UIImageView!
    @IBOutlet weak var weekLabel: UILabel!
    
    private var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
    
    var place_number:Int = 0
    var id_week:Int = 0
    var id_teacher:Int = 0
    var selectDay:Int = 0
    
    var week_schedule = [schedule]()
    var customData = CustomData()
    var openedDaySchedule = [Bool]()
    var days = [day_m]()
    var indexPathCV = [IndexPath]()
    
    struct m_data:Decodable{
        var week_schedule = [schedule]()
        var number_dayofweek = [String]()
    }
    var days_week = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        id_week = customData.checkExistingDataInt(string: "id_week_profile")
        weekLabel.text = String(id_week)+"-ая неделя"
        
        var ds1 = day_m()
        ds1.date = "-"
        ds1.name = "Пн"
        
        var ds2 = day_m()
        ds2.date = "-"
        ds2.name = "Вт"
        
        var ds3 = day_m()
        ds3.date = "-"
        ds3.name = "Ср"
    
        var ds4 = day_m()
        ds4.date = "-"
        ds4.name = "Чт"
        
        var ds5 = day_m()
        ds5.date = "-"
        ds5.name = "Пт"
        
        var ds6 = day_m()
        ds6.date = "-"
        ds6.name = "Сб"
        
        days.append(ds1)
        days.append(ds2)
        days.append(ds3)
        days.append(ds4)
        days.append(ds5)
        days.append(ds6)
        
        setup()
        customData.rotateImage(loadImage: loadImage)
        getData(week: id_week, id_group: id_teacher, type: "teacher")
    }
    
    func setup(){
        customData.changeImageColor(image: closeButton.imageView!, color: UIColor(displayP3Red: 173/255, green: 179/255, blue: 187/255, alpha: 1))
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        mainView.layer.cornerRadius = 20
        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        weekScheduleTV.isScrollEnabled = false
        weekScheduleTV.separatorStyle = .none
        
        customData.changeImageColor(image: notScheduleImage, color: UIColor(displayP3Red: 143/255, green: 152/255, blue: 168/255, alpha: 1))
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon-angle-left")
       self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon-angle-left")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
       self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func getHeightMainView() -> Int{
        if week_schedule[selectDay].schedule.count > 0 {
            var heightFirstMainView:Int = 16 + 21 + 8 + 16
            for i in 0...(week_schedule[selectDay].schedule.count - 1){
                if openedDaySchedule[i]{
                    heightFirstMainView += 80 * week_schedule[selectDay].schedule[i].count
                }
                else{
                    heightFirstMainView += 80
                }
            }
            return heightFirstMainView
        }
        return 0
    }
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func getData(week:Int, id_group:Int, type:String){
        let urlGetNextLesson = "https://createtogether.ru/lesson?type=week&week=" + String(id_week) + "&id_"+type+"=" + String(id_group)
        print(urlGetNextLesson)
        let urlObjGetNextLesson = URL(string: urlGetNextLesson)
        URLSession.shared.dataTask(with: urlObjGetNextLesson!) {(data, response, error) in
            
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode(m_data.self, from: data)
                DispatchQueue.main.async {
                    
                    self.loadDataView.isHidden = true
                    
                    self.week_schedule = JSONLessons.week_schedule
                    self.days_week = JSONLessons.number_dayofweek
                    
                    if self.week_schedule[self.selectDay].schedule.count > 0{
                        for _ in 0...(self.week_schedule[self.selectDay].schedule.count-1){
                            self.openedDaySchedule.append(false)
                        }
                        self.infoScheduleLabel.isHidden = false
                    }
                    else{
                        self.infoScheduleLabel.isHidden = true
                    }
                    
                    self.weekScheduleTV.reloadData()
                    self.dayListCV.reloadData()
                    
                    let heightMainView = CGFloat(self.getHeightMainView())
                    if heightMainView == 0{
                        self.heightMainViewConstrains.constant = 300
                        self.notScheduleImage.isHidden = false
                        self.notScheduleLabel.isHidden = false
                        self.notSchedulePostLabel.isHidden = false
                    }
                    else{
                        self.heightMainViewConstrains.constant = heightMainView
                        self.notScheduleImage.isHidden = true
                        self.notScheduleLabel.isHidden = true
                        self.heightViewConstrains.constant = CGFloat(8 + 8 + heightMainView + 8 + 16 + 18)
                        self.notSchedulePostLabel.isHidden = true
                    }
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
}
extension UserScheduleViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectDay = indexPath.item
        place_number = indexPath.item
        
        dayNameLabel.text = week_schedule[selectDay].name_day
        
        var opDS = [Bool]()
        if self.week_schedule[self.selectDay].schedule.count > 0{
            for _ in 0...(self.week_schedule[self.selectDay].schedule.count-1){
                opDS.append(false)
            }
            self.infoScheduleLabel.isHidden = false
        }
        else{
            self.infoScheduleLabel.isHidden = true
        }
        openedDaySchedule = opDS
        
        weekScheduleTV.reloadData()
        dayListCV.reloadData()
        
        let heightMainView = CGFloat(self.getHeightMainView())
        if heightMainView == 0{
            self.heightMainViewConstrains.constant = 300
            notScheduleImage.isHidden = false
            notScheduleLabel.isHidden = false
            self.notSchedulePostLabel.isHidden = false
        }
        else{
            self.heightMainViewConstrains.constant = heightMainView
            notScheduleImage.isHidden = true
            notScheduleLabel.isHidden = true
            self.notSchedulePostLabel.isHidden = true
            self.heightViewConstrains.constant = CGFloat(8 + 8 + heightMainView + 8 + 16 + 18)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UserWeekListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserWeekListCollectionViewCell", for: indexPath) as! UserWeekListCollectionViewCell
        
        if indexPath.item == selectDay{
            cell.date.textColor = UIColor.black
            cell.name.textColor = UIColor.white
            cell.gradientView.layer.backgroundColor = UIColor(displayP3Red: 100/255, green: 110/255, blue: 120/255, alpha: 1).cgColor
            cell.gradientView.layer.cornerRadius = 3
        }
        else{
            cell.gradientView.layer.backgroundColor = UIColor.white.cgColor
            if week_schedule.count > 0{
                if week_schedule[indexPath.item].schedule.count == 0{
                    cell.date.textColor = UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1)
                    cell.name.textColor = UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1)
                }
                else{
                    cell.layer.backgroundColor = UIColor.white.cgColor
                    cell.date.textColor = UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1)
                    cell.name.textColor = UIColor.black
                }
            }
            else{
                cell.layer.backgroundColor = UIColor.white.cgColor
                cell.date.textColor = UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1)
                cell.name.textColor = UIColor.black
            }
            
        }
        
        cell.name.text = days[indexPath.item].name
        if days_week.count > 0 {
            cell.date.text = days_week[indexPath.item]
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item+1 == days.count{
            let heightb = Int(self.view.frame.width/6) * 5
            return CGSize(width: CGFloat(Int(self.view.frame.width) - heightb), height: 60)
        }
        else{
            return CGSize(width: Int((self.view.frame.width)/6), height: 60)
        }
    }
}

extension UserScheduleViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if openedDaySchedule[section] == true{
            return week_schedule[selectDay].schedule[section].count
        }
        else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if week_schedule[place_number].schedule[indexPath.section].count > 1{
            if openedDaySchedule[indexPath.section] == true{
                let cell:weekUserScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weekUserScheduleTableViewCell", for: indexPath) as! weekUserScheduleTableViewCell
                
                cell.addSubjectLabel.isHidden = false
                cell.closeNumberLabel.isHidden = false
                openedDaySchedule[indexPath.section] = false
                
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                
                let heightMainView = CGFloat(self.getHeightMainView())
                self.heightMainViewConstrains.constant = heightMainView
                self.heightViewConstrains.constant = CGFloat(8 + 30 + 8 + heightMainView + 8 + 16 + 18)
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
            else{
                let cell:weekUserScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weekUserScheduleTableViewCell", for: indexPath) as! weekUserScheduleTableViewCell
                
                openedDaySchedule[indexPath.section] = true
                
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                
                cell.closeStatusImageBlock.isHidden = true
                cell.addSubjectLabel.isHidden = true
                cell.closeNumberLabel.isHidden = true
                cell.numberLabel.isHidden = false
                
                let heightMainView = CGFloat(self.getHeightMainView())
                self.heightMainViewConstrains.constant = heightMainView
                self.heightViewConstrains.constant = CGFloat(8 + 30 + 8 + heightMainView + 8 + 16 + 18)
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:weekUserScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weekUserScheduleTableViewCell", for: indexPath) as! weekUserScheduleTableViewCell
        
        cell.numberBlock.layer.cornerRadius = 20.0
        
        cell.selectionStyle = .none
        
        cell.title.tag = indexPath.item
        cell.title.text = week_schedule[selectDay].schedule[indexPath.section][indexPath.row].name
        cell.timeLabel.text = week_schedule[selectDay].schedule[indexPath.section][indexPath.row].time
        cell.groupsLabel.text = week_schedule[selectDay].schedule[indexPath.section][indexPath.row].groups
        cell.numberLabel.text = week_schedule[selectDay].schedule[indexPath.section][indexPath.row].number
        cell.closeNumberLabel.text = week_schedule[selectDay].schedule[indexPath.section][indexPath.row].number
        
        if week_schedule[selectDay].schedule[indexPath.section][indexPath.row].classroom != ""{
            cell.info.text = week_schedule[selectDay].schedule[indexPath.section][indexPath.row].classroom + ", " + String(customData.getTypeLesson(typeLesson: week_schedule[selectDay].schedule[indexPath.section][indexPath.row].type))
        }
        else{
            cell.info.text = String(customData.getTypeLesson(typeLesson: week_schedule[selectDay].schedule[indexPath.section][indexPath.row].type))
        }
        
        cell.closeStatusImageBlock.isHidden = true
        cell.addSubjectLabel.isHidden = true
        
        let typeLesson = week_schedule[selectDay].schedule[indexPath.section][indexPath.row].type
        customData.setBackgroundView(typeLesson: typeLesson, view: cell.numberGradientView)
        if indexPath.row == 0{
            
            cell.title.text = week_schedule[selectDay].schedule[indexPath.section][0].name
            cell.numberLabel.text = week_schedule[selectDay].schedule[indexPath.section][0].number
            if week_schedule[selectDay].schedule[indexPath.section][indexPath.row].classroom != ""{
                cell.info.text = week_schedule[selectDay].schedule[indexPath.section][0].classroom + ", " + String(customData.getTypeLesson(typeLesson: week_schedule[selectDay].schedule[indexPath.section][0].type))
            }
            else{
                cell.info.text = String(customData.getTypeLesson(typeLesson: week_schedule[selectDay].schedule[indexPath.section][0].type))
            }
            cell.timeLabel.text = week_schedule[selectDay].schedule[indexPath.section][0].time
            
            if week_schedule[selectDay].schedule[indexPath.section].count > 1{
                cell.closeStatusImageBlock.isHidden = false
                cell.addSubjectLabel.isHidden = false
                cell.closeNumberLabel.isHidden = false
                cell.numberLabel.isHidden = true
            }
            else{
                cell.closeNumberLabel.isHidden = true
                cell.numberLabel.isHidden = false
                cell.closeStatusImageBlock.isHidden = true
            }
        }
        else{
            cell.closeNumberLabel.isHidden = true
            cell.numberLabel.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if week_schedule.count>0{
            return week_schedule[selectDay].schedule.count
        }
        else{
            return 0
        }
    }
    
}



