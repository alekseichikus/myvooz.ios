//
//  DayScheduleView.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 15/12/2019.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class DayScheduleView: UIViewController {
    
    @IBOutlet weak var weekScheduleTV: UITableView!
    @IBOutlet var DayNamesLabel: [UILabel]!
    @IBOutlet weak var notScheduleImageView: UIImageView!
    @IBOutlet weak var heightMainViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sView: UIView!
    @IBOutlet weak var EmptyLessonView: UIView!
    
    var openedDaySchedule = [Bool]()
    var week_schedule = schedule()
    var nvContrl = UINavigationController()
    var customData = CustomData()
    var id_week_select:Int = 0
    
    var id_group:Int = 0
    var bool_hide_empty:Bool = false
    
    override func viewDidLoad() {
        
        setup()
        
        if self.week_schedule.schedule.count > 0{
            for _ in 0...6{
                self.openedDaySchedule.append(false)
                
            }
        }
        
        for dnl in DayNamesLabel{
            dnl.text = week_schedule.name_day
        }

        let heightSecondMV = CGFloat(self.getHeightSecondMainView())
        let hmv = heightSecondMV + 20 + 8 + 21
        heightMainViewConstraint.constant = hmv
        
    }
    
    func setup(){
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.1
        weekScheduleTV.isScrollEnabled = false
        mainView.layer.cornerRadius = 16
        EmptyLessonView.layer.cornerRadius = 16
        EmptyLessonView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        weekScheduleTV.separatorStyle = .none
        
        if week_schedule.schedule.count == 0{
            EmptyLessonView.isHidden = false
        }
        customData.changeImageColor(image: notScheduleImageView, color: UIColor(displayP3Red: 143/255, green: 152/255, blue: 168/255, alpha: 1))
    }
}
extension DayScheduleView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if openedDaySchedule.count>0{
            if openedDaySchedule[section] == true{
                return week_schedule.schedule[section].count
            }
        }
        return 1
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if week_schedule.schedule[indexPath.section].count > 1{
            if openedDaySchedule[indexPath.section] == true{
                let cell:weekScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weekScheduleTableViewCell", for: indexPath) as! weekScheduleTableViewCell
                cell.closeNumberLabel.isHidden = false
                openedDaySchedule[indexPath.section] = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                let heightSecondMV = CGFloat(self.getHeightSecondMainView())
                
                heightMainViewConstraint.constant = heightSecondMV + 20 + 8 + 21
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "LessonViewController") as? LessonViewController
                let ds = week_schedule.schedule[indexPath.section][indexPath.row]
                vc?.name = ds.name
                vc?.classroom_lesson = ds.classroom
                vc?.type_lesson = ds.type
                vc?.time_lesson = ds.time
                vc?.id_week_select = id_week_select
                vc?.id_group = id_group
                vc?.id_schedule = ds.id
                vc?.number_lesson = ds.number_text
                vc?.id_object = ds.id_object
                customData.presentViewNavigationController(vc: vc!, navigationController: nvContrl)
            }
            else{
                let cell:weekScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weekScheduleTableViewCell", for: indexPath) as! weekScheduleTableViewCell
                
                openedDaySchedule[indexPath.section] = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                
                cell.closeStatusImageBlock.isHidden = true
                cell.closeNumberLabel.isHidden = true
                cell.numberLabel.isHidden = false
                
                let heightSecondMV = CGFloat(self.getHeightSecondMainView())
                heightMainViewConstraint.constant = heightSecondMV + 20 + 8 + 21
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        else if week_schedule.schedule[indexPath.section].count == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LessonViewController") as? LessonViewController
            let ds = week_schedule.schedule[indexPath.section][indexPath.row]
            vc?.name = ds.name
            vc?.classroom_lesson = ds.classroom
            vc?.type_lesson = ds.type
            vc?.time_lesson = ds.time
            vc?.id_week_select = id_week_select
            vc?.id_group = id_group
            vc?.id_schedule = ds.id
            vc?.number_lesson = ds.number_text
            vc?.id_object = ds.id_object
            customData.presentViewNavigationController(vc: vc!, navigationController: nvContrl)
        }
    }
    func getHeightSecondMainView() -> Int{
        if week_schedule.schedule.count > 0 {
            var heightFirstMainView:Int = 0
            for i in 0...(week_schedule.schedule.count - 1){
                
                if openedDaySchedule[i]{
                    for j in week_schedule.schedule[i]{
                        var widthText = view.frame.width - 16 - 40
                        widthText = widthText - 16 - 16
                        let size = CGSize(width: widthText, height: 1000)
                        let attributes = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 15, weight: .medium)]
                        let estimatedFrame = NSString(string: j.name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                        var hh = estimatedFrame.height
                        if estimatedFrame.height > 39{
                            hh = 39
                        }
                        heightFirstMainView = heightFirstMainView + 81 + 5 + Int(hh)
                    }
                }
                else{
                    var widthText = view.frame.width - 16 - 40
                    widthText = widthText - 16 - 16
                    let size = CGSize(width: widthText, height: 1000)
                    let attributes = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 15, weight: .medium)]
                    var estimatedFrame = CGRect()
                    if week_schedule.schedule[i].count > 0{
                        estimatedFrame = NSString(string: week_schedule.schedule[i][0].name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                    }
                    else{
                    }
                    var hh = estimatedFrame.height
                    if estimatedFrame.height > 39{
                        hh = 39
                    }
                    heightFirstMainView = heightFirstMainView + 81 + 5 + Int(hh)
                }
            }
            return heightFirstMainView
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:weekScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weekScheduleTableViewCell", for: indexPath) as! weekScheduleTableViewCell
        let backgroundView = UIView()
        
        backgroundView.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        if week_schedule.schedule.count != indexPath.section + 1{
            customData.addBottomBorder(color: UIColor(displayP3Red: 246/255, green: 247/255, blue: 246/255, alpha: 1), view: cell.backView, width: 1)
        }
        cell.userView.layer.borderColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        cell.userView.layer.borderWidth = 1
        
        customData.changeImageColor(image: cell.userImage, color: UIColor(displayP3Red: 145/255, green: 146/255, blue: 159/255, alpha: 1))
        customData.changeImageColor(image: cell.doorImage, color: UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1))
        if bool_hide_empty{
            
            cell.userView.layer.cornerRadius = 12
            cell.numberBlock.layer.cornerRadius = 23.0
            cell.numberLabel.textColor = UIColor.white
            cell.title.textColor = UIColor.black
            
            let lesson_ = week_schedule.schedule[indexPath.section][indexPath.row]
            cell.title.text = lesson_.name
            cell.timeLabel.text = lesson_.time
            if lesson_.classroom != ""{
                cell.info.text = lesson_.classroom + ", " + String(customData.getTypeLesson(typeLesson: lesson_.type))
            }
            else{
                cell.info.text = String(customData.getTypeLesson(typeLesson: lesson_.type))
            }
            cell.numberLabel.text = lesson_.number_text
            cell.closeNumberLabel.text = lesson_.number_text
            cell.nameTeacherLabel.text = lesson_.name_teacher
            
            cell.closeStatusImageBlock.isHidden = true
            
            let typeLesson = lesson_.type
            customData.setBackgroundView(typeLesson: typeLesson, view: cell.numberGradientView)
            if indexPath.row == 0{
                if week_schedule.schedule[indexPath.section].count > 1{
                    cell.closeStatusImageBlock.isHidden = false
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
        else{
            if week_schedule.schedule[indexPath.section].count > 0{
                
                let lesson_ = week_schedule.schedule[indexPath.section][indexPath.row]
                let typeLesson = lesson_.type
                
                cell.numberBlock.layer.cornerRadius = 20.0
                cell.userView.layer.cornerRadius = 12
                cell.numberLabel.textColor = UIColor.white
                cell.title.textColor = UIColor.black
                customData.setBackgroundView(typeLesson: typeLesson, view: cell.numberGradientView)
                
                
                cell.title.text = lesson_.name
                cell.typeLabel.text = String(customData.getTypeLesson(typeLesson: lesson_.type))
                cell.timeLabel.text = customData.getTimeOfLesson(numb: Int(lesson_.number)!)
                cell.nameTeacherLabel.text = lesson_.name_teacher
                cell.numberLabel.text = lesson_.number_text
                cell.closeNumberLabel.text = lesson_.number_text
                if lesson_.classroom != ""{
                    cell.info.text = lesson_.classroom
                }
                else{
                    cell.info.text = String(customData.getTypeLesson(typeLesson: lesson_.type))
                }
                
                cell.closeStatusImageBlock.isHidden = true
                
                if indexPath.row == 0{
                    if week_schedule.schedule[indexPath.section].count > 1{
                        cell.closeStatusImageBlock.isHidden = false
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
            }
            else{
                
                cell.timeLabel.text = customData.getTimeOfLessonShort(numb: indexPath.section + 1)
                cell.typeLabel.isHidden = true
                cell.closeNumberLabel.isHidden = true
                cell.numberLabel.isHidden = false
                cell.title.isHidden = true
                cell.emptyLabel.isHidden = false
                cell.doorImage.isHidden = true
                cell.info.isHidden = true
                cell.timeLabel.isHidden = true
                cell.userView.isHidden = true
                cell.nameTeacherLabel.isHidden = true
                
                cell.numberLabel.textColor = UIColor.lightGray
                cell.title.textColor = UIColor.darkGray
                cell.numberBlock.layer.cornerRadius = 20
                cell.numberLabel.text = String(indexPath.section + 1)
                cell.emptyLabel.layer.cornerRadius = 3
                customData.setBackgroundView(typeLesson: -1, view: cell.numberGradientView)
                cell.isSelected = false
                cell.userView.isHidden = true
                cell.nameTeacherLabel.isHidden = true
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var widthText = view.frame.width - 16 - 40
        widthText = widthText - 16 - 16
        let size = CGSize(width: widthText, height: 1000)
        let attributes = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 15, weight: .medium)]
        var estimatedFrame = CGRect()
        if week_schedule.schedule[indexPath.section].count > 0{
            estimatedFrame = NSString(string: week_schedule.schedule[indexPath.section][0].name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        }
        else{
            
        }
        var hh = estimatedFrame.height
        if estimatedFrame.height > 39{
            hh = 39
        }
        return CGFloat(81 + 5 + hh)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return week_schedule.schedule.count
    }
    
}
