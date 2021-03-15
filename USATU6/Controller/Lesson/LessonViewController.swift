//
//  BellViewController.swift
//  USATU6
//
//  Created by aleksei on 06.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
    
    @IBOutlet weak var addGroupVC: UICollectionView!
    @IBOutlet weak var userVC: UICollectionView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightMainViewConstrains: NSLayoutConstraint!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var heightViewConstrains: NSLayoutConstraint!
    @IBOutlet weak var heightUserVCConstrains: NSLayoutConstraint!
    @IBOutlet weak var loadImage: UIImageView!
    @IBOutlet weak var imageLoadView: UIView!
    @IBOutlet weak var gradView: UIView!
    @IBOutlet weak var infoCV: UICollectionView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var weekInfoCV: UICollectionView!
    @IBOutlet weak var heightUserViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var topUserViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoWeekView: UIView!
    @IBOutlet weak var weeksLabel: UILabel!
    @IBOutlet weak var weekWeeksLabel: UILabel!
    @IBOutlet weak var weekInfoWeeksLabel: UILabel!
    @IBOutlet weak var nameMonthLabel: UILabel!
    
    var day_name_arr = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]
    var id_group:Int = 0
    var type_lesson:Int = 0
    var id_schedule:Int = 0
    var number_lesson:String = ""
    var classroom_lesson:String = ""
    var time_lesson:String = ""
    var id_object:Int = 1
    var name:String = ""
    var id_week_select:Int = 0
    
    var groups = [infoGroup]()
    var users = [user]()
    var info = infoaddLes()
    var customData = CustomData()
    var infos = [inffo]()
    var lessons_week = [lesson_week]()
    var number_day_of_week = [String]()
    var name_month:String = ""
    
    struct GData:Decodable{
        var teachers = [user]()
        var info = infoaddLes()
        var groups = [infoGroup]()
        var lessons_week = [lesson_week]()
        var name_month:String = ""
        var number_day_of_week = [String]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        numberLabel.text = number_lesson
        let id_week = customData.checkExistingDataInt(string: "id_week_profile")
        weekInfoWeeksLabel.text = String(id_week) + " -ая неделя"
        weekWeeksLabel.text = String(id_week_select) + " н."
        

        var classroomI = inffo()
        classroomI.imageName = "icon-door"
        classroomI.name = "аудитория"
        var timeI = inffo()
        timeI.imageName = "icon-clock"
        timeI.name = "время"
        timeI.title = customData.getTimeOfLesson(numb: Int(number_lesson)!)
        var typeI = inffo()
        typeI.imageName = "icon-flask"
        typeI.name = "тип"
        typeI.title = "12:10-13:45"

        self.infos.append(typeI)
        self.infos.append(classroomI)
        self.infos.append(timeI)
        
        
        getData()
        setup()
        customData.rotateImage(loadImage: loadImage)
    }
    func setup(){
        photoView.layer.cornerRadius = 20
        mainView.layer.cornerRadius = 10
        imageLoadView.layer.cornerRadius = 10
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowOpacity = 0.15
        customData.setBackgroundView(typeLesson: type_lesson, view: gradView)
        customData.setGradientMainView(view: view, gradient: customData.firstGradient)
        customData.addTopBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: userView, width: 1)
        customData.addBottomBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: userView, width: 1)
        view.layer.backgroundColor = UIColor(displayP3Red: 101/255, green: 122/255, blue: 191/255, alpha: 1).cgColor
        infoWeekView.layer.cornerRadius = 4
        infoWeekView.layer.borderColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        infoWeekView.layer.borderWidth = 1
    }
    func getData(){
        let urlGetNextLesson = "https://createtogether.ru/lesson?type=info&id_schedule=" + String(id_schedule)
        let urlObjGetNextLesson = URL(string: urlGetNextLesson)
        URLSession.shared.dataTask(with: urlObjGetNextLesson!) {(data, response, error) in
            
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode(GData.self, from: data)
                DispatchQueue.main.async {
                    self.infos[0].title = self.customData.getTypeLesson(typeLesson: self.type_lesson)
                
                    if self.classroom_lesson != ""{
                        self.infos[1].title = self.classroom_lesson
                    }
                    else{
                        self.infos[1].title = "-"
                    }
                    
                    self.imageLoadView.isHidden = true
                    
                    self.nameMonthLabel.text = JSONLessons.name_month
                    self.number_day_of_week = JSONLessons.number_day_of_week
                    self.groups = JSONLessons.groups
                    self.lessons_week = JSONLessons.lessons_week
                    self.info = JSONLessons.info
                    self.weeksLabel.text = JSONLessons.info.weeks + " н."
                    self.users = JSONLessons.teachers
                    
                    var heightMainView = 0
                    if self.users.count == 0{
                        self.heightUserVCConstrains.constant = 0
                        self.heightUserViewConstraint.constant = 0
                        self.userView.isHidden = true
                        self.topUserViewConstraint.constant = 0
                    }
                    else{
                        self.userVC.reloadData()
                        heightMainView += 186
                        self.heightUserViewConstraint.constant = 166
                    }
                    if self.groups.count != 0{
                        self.addGroupVC.reloadData()
                    }
                    self.infoCV.reloadData()
                    self.weekInfoCV.reloadData()
                    
                    heightMainView += 24 + 40 + 20 + 25 + 20 + 120
                    heightMainView += 8 + 18 + 32 + 60 + 55 + 45 + 50
                    
                    self.heightMainViewConstrains.constant = CGFloat(heightMainView)
                    self.heightViewConstrains.constant = CGFloat(heightMainView + 16)
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
    
    @IBAction func semestrButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SemestrViewController") as? SemestrViewController
        controller!.id_schedule = self.id_schedule
        customData.presentModalView(view: self, controller: controller!, YOffset: 86)
    }
}
extension LessonViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.addGroupVC{
            return groups.count
        }
        else if collectionView == self.userVC{
            return users.count
        }
        else if collectionView == self.infoCV{
            return infos.count
        }
        else{
            return number_day_of_week.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.userVC{
            let controller = storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController
            controller?.id_teacher = users[indexPath.item].id
            controller?.name_teacher = users[indexPath.item].name
            customData.presentModalView(view: self, controller: controller!, YOffset: 100)
        }
        else if collectionView == self.addGroupVC{
            let controller = storyboard?.instantiateViewController(withIdentifier: "InfoGroupViewController") as? InfoGroupViewController
            controller?.name_group = groups[indexPath.item].name
            customData.presentModalView(view: self, controller: controller!, YOffset: 100)
        }
        else if collectionView == self.weekInfoCV{
            let controller = storyboard?.instantiateViewController(withIdentifier: "NotesViewController") as? NotesViewController
            customData.presentModalView(view: self, controller: controller!, YOffset: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.addGroupVC{
            let cell:AdditionalGroupCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdditionalGroupCollectionViewCell", for: indexPath) as! AdditionalGroupCollectionViewCell
            cell.nameLabel.text = groups[indexPath.item].name
            cell.layer.cornerRadius = 4
            return cell
        }
        else if collectionView == self.userVC{
            let cell:UserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
            cell.photoView.layer.cornerRadius = 20
            cell.photoView.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.photoView.layer.shadowOpacity = 0.03
            cell.photoView.layer.shadowColor = UIColor.darkGray.cgColor
            cell.photoImage.layer.cornerRadius = 20.0
            cell.photoImage.layer.masksToBounds = true
            cell.name.text = users[indexPath.item].name
            cell.nilPhotoImage.image = cell.nilPhotoImage.image?.withRenderingMode(.alwaysTemplate)
            cell.nilPhotoImage.tintColor = UIColor(displayP3Red: 145/255, green: 146/255, blue: 159/255, alpha: 1)
            
            cell.nilPhotoImage.isHidden = true
            
            if users[indexPath.item].image != ""{
                customData.getImageUrl(stringURLImage:  users[indexPath.item].image, imageView: cell.photoImage)
                cell.nilPhotoImage.isHidden = true
                cell.photoImage.isHidden = false
            }
            else{
                cell.nilPhotoImage.isHidden = false
                cell.photoImage.isHidden = true
            }
            return cell
        }
        else if collectionView == self.infoCV{ //if collectionView == self.infoCV
            let cell:infoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCollectionViewCell", for: indexPath) as! infoCollectionViewCell
            cell.name.text = infos[indexPath.item].title
            cell.title.text = infos[indexPath.item].name
            cell.leftImage.image = UIImage(named: infos[indexPath.item].imageName)
            customData.changeImageColor(image: cell.leftImage, color: UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1))
            customData.addBottomBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: cell, width: 1)
            
            
            return cell
        }
        else{
            let cell:weekInfoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekInfoCollectionViewCell", for: indexPath) as! weekInfoCollectionViewCell
            cell.stateView.layer.cornerRadius = 14
            cell.instateView.layer.cornerRadius = 12
            for jj in lessons_week{
                if indexPath.item == jj.wday{
                    customData.setBackgroundView(typeLesson: jj.type, view: cell.stateView)
                    cell.numberLabel.textColor = UIColor.darkGray
                    break
                }
            }
            
            cell.numberLabel.text = number_day_of_week[indexPath.item]
            cell.stateView.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.stateView.layer.shadowOpacity = 0.03
            cell.stateView.layer.shadowColor = UIColor.darkGray.cgColor
            cell.dayLabel.text = day_name_arr[indexPath.item]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.addGroupVC{
            return CGSize(width: 60, height: 25)
        }
        else if collectionView == self.userVC{
            return CGSize(width: 80, height: 100)
        }
        else if collectionView == self.infoCV{
            return CGSize(width: view.frame.size.width - 32, height: 40)
        }
        else{ //if collectionView == self.weekInfoCV
            let ww = (Int(view.frame.size.width) - 32)/6
            return CGSize(width: ww, height: 60)
        }
    }
}

