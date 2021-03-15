//
//  ScheduleViewController.swift
//  USATU6
//
//  Created by aleksei on 13.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit
import  CoreData

class ScheduleViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var dayListCV: UICollectionView!
    @IBOutlet weak var weekScheduleTV: UITableView!
    @IBOutlet weak var notScheduleImage: UIImageView!
    @IBOutlet weak var notScheduleLabel: UILabel!
    @IBOutlet weak var notSchedulePostLabel: UILabel!
    @IBOutlet weak var errorInternetView: UIView!
    @IBOutlet weak var loadDataView: UIView!
    @IBOutlet weak var loadImage: UIImageView!
    @IBOutlet weak var notSelectedView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var getDayNowView: UIView!
    @IBOutlet weak var IEImageView: UIImageView!
    @IBOutlet var WarningOutletCollectionViews: [UIView]!
    private var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
    @IBOutlet weak var FilterButton: UIButton!
    
    var place_number:Int = 0
    
    var id_group:Int = 0, id_type:Int = 0, id_week = 0, id_teacher = 0
    var name_group:String = "", name_teacher:String = "", name_week:String = ""
    
    var id_group_:Int = 0, id_type_:Int = 0, id_week_ = 0, id_teacher_ = 0
    var name_group_:String = "", name_teacher_:String = "", name_week_:String = ""
    
    var bool_hide_empty = true
    var number_day:Int = 0
    var selectDay:Int = 0
    
    var people: [NSManagedObject] = []
    var backgroundGradientViews = [CAGradientLayer]()
    var week_schedule = [schedule]()
    var isOpenDayOfWeek = false
    var customData = CustomData()
    var indexPathCV = [IndexPath]()
    var dateDaysOfWeek = [String]()
    var days = [day_m]()
    
    struct m_data:Decodable{
        var week_schedule = [schedule]()
        var number_day:Int = 0
        var number_dayofweek = [String]()
    }

    let defaults = UserDefaults.standard
    
    var slides:[DayScheduleView]
        = []
    var pointFilter = UIView()
    
    func setupScrollView(pages: [DayScheduleView]){
        scrollView.contentOffset.x = 0
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-170)
        scrollView.contentSize = CGSize(width: view.frame.width*CGFloat(pages.count), height: view.frame.height-170)
        scrollView.isPagingEnabled = true
        for view in scrollView.subviews{
            view.removeFromSuperview()
        }
        for i in 0..<pages.count{
            pages[i].view.frame = CGRect(x: view.frame.width * CGFloat(i), y:0, width: view.frame.width, height: view.frame.height-170)
            scrollView.addSubview(pages[i].view)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        id_group = customData.checkExistingDataInt(string: "id_group_profile")
        if let _:Bool = defaults.bool(forKey: "id_hide_empty_profile"){
            bool_hide_empty = defaults.bool(forKey: "id_hide_empty_profile")
        }
        id_week = customData.checkExistingDataInt(string: "id_week_profile")
        id_teacher = customData.checkExistingDataInt(string: "id_teacher_profile")
        id_type = customData.checkExistingDataInt(string: "id_type_profile")
        
        if customData.checkExistingData(string: "name_teacher_profile") != ""{
            name_teacher = customData.checkExistingData(string: "name_teacher_profile")
        }
        else{
            name_teacher = "Не выбрано"
        }
        if customData.checkExistingData(string: "name_group_profile") != ""{
            name_group = customData.checkExistingData(string: "name_group_profile")
        }
        else{
            name_group = "Не выбрано"
        }
        name_week = customData.checkExistingData(string: "name_week_profile")
        
        id_week_ = id_week
        id_teacher_ = id_teacher
        id_group_ = id_group
        id_type_ = id_type
        name_group_ = name_group
        name_teacher_ = name_teacher
        name_week_ = name_week
        
        var ds1 = day_m(), ds2 = day_m(), ds3 = day_m(), ds4 = day_m(), ds5 = day_m(), ds6 = day_m()
        ds1.date = "-"
        ds1.name = "Пн"
        ds2.date = "-"
        ds2.name = "Вт"
        ds3.date = "-"
        ds3.name = "Ср"
        ds4.date = "-"
        ds4.name = "Чт"
        ds5.date = "-"
        ds5.name = "Пт"
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
        updateInfo(id_week: id_week, id_type: id_type, id_group: id_group, id_teacher: id_teacher, is_empty_hidden: bool_hide_empty)
        getDayNowView.frame.origin.x = scrollView.contentOffset.x/6 + view.frame.width/12 - getDayNowView.frame.width/2
        
        

    }
    
    func setup(){
        customData.setupNavigationController(navigationController: self.navigationController!)
        loadDataView.layer.cornerRadius = 16
        notSelectedView.layer.cornerRadius = 16
        
        pointFilter.frame = CGRect(x: 10, y: 12, width: 8, height: 8)
        pointFilter.layer.cornerRadius = 4
        pointFilter.layer.backgroundColor = UIColor(displayP3Red: 172/255, green: 197/255, blue: 140/255, alpha: 1).cgColor
        pointFilter.layer.borderColor = UIColor.white.cgColor
        pointFilter.layer.borderWidth = 1
        pointFilter.layer.shadowColor = UIColor.black.cgColor
        pointFilter.layer.shadowOpacity = 0.1
        pointFilter.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon-angle-left")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon-angle-left")
        
        getDayNowView.layer.backgroundColor = UIColor(displayP3Red: 100/255, green: 110/255, blue: 120/255, alpha: 1).cgColor
        getDayNowView.layer.cornerRadius = 3
        customData.changeImageColor(image: IEImageView, color: UIColor(displayP3Red: 143/255, green: 152/255, blue: 168/255, alpha: 1))
        
        customData.setGradientMainView(view: view, gradient: customData.firstGradient)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        customData.addTopBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: dayListCV, width: 1)
    }
    
    func hideWarningOutletCollectionViews(){
        for vv in WarningOutletCollectionViews{
            vv.isHidden = true
        }
    }
    func updateInfo(id_week:Int, id_type:Int, id_group:Int, id_teacher:Int, is_empty_hidden:Bool){
        hideWarningOutletCollectionViews()
        
        if (id_type == 0 && id_group == 0) || (id_type == 1 && id_teacher == 0){
            notSelectedView.isHidden = false
        }
        else{
            if CheckInternet.isConnectedToNetwork(){
                loadDataView.isHidden = false
                if id_type == 0{
                    getData(week: id_week, id_group: id_group, type: "group", is_empty_hidden: is_empty_hidden)
                }
                else{
                    getData(week: id_week, id_group: id_teacher, type: "teacher", is_empty_hidden: is_empty_hidden)
                }
            }
            else{
                // если есть в schedule данные этой недели и этой группы, то выводим
                
                var CDSchedule = [schedule].self
                
                guard let appDelegate =
                  UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                let managedContext = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Schedule")
                  do {
                    people = try managedContext.fetch(fetchRequest)
                  } catch let error as NSError {
                    print("Could not save.")
                  }
                if people.count > 0{
                    
                }
                else{
                    errorInternetView.isHidden = false
                }
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        getDayNowView.frame.origin.x = scrollView.contentOffset.x/6 + view.frame.width/12 - getDayNowView.frame.width/2
        selectDay = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset

        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.20) {
            
            slides[0].view.transform = CGAffineTransform(scaleX: (0.20-percentOffset.x)/0.20, y: (0.20-percentOffset.x)/0.20)
            slides[1].view.transform = CGAffineTransform(scaleX: percentOffset.x/0.20, y: percentOffset.x/0.20)
        } else if(percentOffset.x > 0.20 && percentOffset.x <= 0.4) {
            slides[1].view.transform = CGAffineTransform(scaleX: (0.4-percentOffset.x)/0.20, y: (0.4-percentOffset.x)/0.20)
            slides[2].view.transform = CGAffineTransform(scaleX: percentOffset.x/0.4, y: percentOffset.x/0.4)
            
        } else if(percentOffset.x > 0.4 && percentOffset.x <= 0.6) {
            slides[2].view.transform = CGAffineTransform(scaleX: (0.6-percentOffset.x)/0.20, y: (0.6-percentOffset.x)/0.20)
            slides[3].view.transform = CGAffineTransform(scaleX: percentOffset.x/0.6, y: percentOffset.x/0.6)
            
        }
        else if(percentOffset.x > 0.6 && percentOffset.x <= 0.8) {
            slides[3].view.transform = CGAffineTransform(scaleX: (0.8-percentOffset.x)/0.20, y: (0.8-percentOffset.x)/0.20)
            slides[4].view.transform = CGAffineTransform(scaleX: percentOffset.x/0.8, y: percentOffset.x/0.8)
        
        }
        else if(percentOffset.x > 0.8 && percentOffset.x <= 1) {
            slides[4].view.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.20, y: (1-percentOffset.x)/0.20)
            slides[5].view.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        dayListCV.reloadData()
    }
    func save(name: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      
      let entity = NSEntityDescription.entity(forEntityName: "Schedule", in: managedContext)!
      
      let person = NSManagedObject(entity: entity, insertInto: managedContext)
      
      person.setValue(name, forKeyPath: "name")

      do {
        try managedContext.save()
        people.append(person)
      } catch let error as NSError {
        print("Could not save.")
      }
    }
    @IBAction func clickFilterButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController
        controller?.ScheduleVC = self
        controller?.id_type = id_type_
        controller?.id_group = id_group_
        controller?.id_week = id_week_
        controller?.id_teacher = id_teacher_
        controller?.name_week = name_week_
        controller?.name_group = name_group_
        controller?.name_teacher = name_teacher_
        customData.presentModalView(view: self, controller: controller!, YOffset: 86)
    }
    func resetMainData(){
        id_week_ = id_week
        id_teacher_ = id_teacher
        id_group_ = id_group
        id_type_ = id_type
        
        name_group_ = name_group
        name_teacher_ = name_teacher
        name_week_ = name_week
        
        for view in FilterButton.subviews.first!.subviews{
            view.removeFromSuperview()
        }
        
        updateInfo(id_week: id_week, id_type: id_type, id_group: id_group, id_teacher: id_teacher, is_empty_hidden: bool_hide_empty)
    }
    func reloadMainData(id_group:Int, id_teacher:Int, id_week:Int, id_type:Int, name_group:String, name_teacher:String, name_week:String){
        week_schedule = [schedule]()
        
        for view in FilterButton.subviews.first!.subviews{
            view.removeFromSuperview()
        }
        
        self.id_group_ = id_group
        self.id_type_ = id_type
        self.id_teacher_ = id_teacher
        self.id_week_ = id_week
        
        self.name_week_ = name_week
        self.name_group_ = name_group
        self.name_teacher_ = name_teacher
        
        if (self.id_type != id_type_ || self.id_teacher != id_teacher_ || self.id_week != id_week_ || self.id_group != id_group_){
            FilterButton.subviews.first!.addSubview(pointFilter)
        }
        else{
            for view in FilterButton.subviews.first!.subviews{
                view.removeFromSuperview()
            }
        }
        
        updateInfo(id_week: id_week, id_type: id_type, id_group: id_group, id_teacher: id_teacher, is_empty_hidden: bool_hide_empty)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        var bool_hide_empty_profile:Bool = false
        
        let id_group_profile = customData.checkExistingDataInt(string: "id_group_profile")
        let id_type_profile = customData.checkExistingDataInt(string: "id_type_profile")
        let id_teacher_profile = customData.checkExistingDataInt(string: "id_teacher_profile")
        let id_week_profile = customData.checkExistingDataInt(string: "id_week_profile")
        let name_week_profile = customData.checkExistingData(string: "name_week_profile")
        var name_teacher_profile = ""
        var name_group_profile = ""
        
        if customData.checkExistingData(string: "name_teacher_profile") != ""{
            name_teacher_profile = customData.checkExistingData(string: "name_teacher_profile")
        }
        else{
            name_teacher_profile = "Не выбрано"
        }
        if customData.checkExistingData(string: "name_group_profile") != ""{
            name_group_profile = customData.checkExistingData(string: "name_group_profile")
        }
        else{
            name_group_profile = "Не выбрано"
        }
        
        if let data:Bool = defaults.bool(forKey: "id_hide_empty_profile"){
            bool_hide_empty_profile = data
        }
        
        if ((id_type != id_type_profile) ||  id_group != id_group_profile || id_teacher != id_teacher_profile || bool_hide_empty != bool_hide_empty_profile){
            week_schedule = [schedule]()
            
            for view in FilterButton.subviews.first!.subviews{
                view.removeFromSuperview()
            }
            
            id_group = id_group_profile
            id_type = id_type_profile
            id_teacher = id_teacher_profile
            bool_hide_empty = bool_hide_empty_profile
            id_week = id_week_profile
            
            name_teacher = name_teacher_profile
            name_group = name_group_profile
            name_week = name_week_profile
            
            id_group_ = id_group_profile
            id_type_ = id_type_profile
            id_teacher_ = id_teacher_profile
            id_week_ = id_week_profile
            
            name_teacher_ = name_teacher_profile
            name_group_ = name_group_profile
            name_week_ = name_week_profile
            
            updateInfo(id_week: id_week, id_type: id_type, id_group: id_group, id_teacher: id_teacher, is_empty_hidden: bool_hide_empty)
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    func getData(week:Int, id_group:Int, type: String, is_empty_hidden:Bool){
        let urlGetNextLesson = "https://createtogether.ru/lesson?type=week&week=" + String(week) + "&id_" + type + "=" + String(id_group)
        let urlObjGetNextLesson = URL(string: urlGetNextLesson)
        URLSession.shared.dataTask(with: urlObjGetNextLesson!) {(data, response, error) in
            
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode(m_data.self, from: data)
                DispatchQueue.main.async {
                    if !self.isOpenDayOfWeek{
                        self.selectDay = JSONLessons.number_day
                        
                        self.isOpenDayOfWeek = true
                    }
                    
                    self.slides = []
                    self.week_schedule = [schedule]()
                    
                    for ws in JSONLessons.week_schedule{
                        var day_schedule = ws.schedule
                        if day_schedule.count > 0 {
                            if is_empty_hidden{
                                self.week_schedule.append(ws)
                            }
                            else{
                                day_schedule = [[weekLesson]]()
                                for i in 0...6{
                                    if self.issetNumberLesson(numb: i + 1, arr: ws.schedule){
                                        day_schedule.append(ws.schedule[self.getKeyNumberLesson(numb: i + 1, arr: ws.schedule)])
                                    }
                                    else{
                                        day_schedule.append([])
                                    }
                                }
                                var wws = ws
                                wws.schedule = day_schedule
                                self.week_schedule.append(wws)
                            }
                        }
                        else{
                            self.week_schedule.append(ws)
                        }
                    }
                    
                    let slide1:DayScheduleView = (self.storyboard?.instantiateViewController(withIdentifier: "DayScheduleView") as? DayScheduleView)!
                    slide1.week_schedule = self.week_schedule[0]
                    slide1.nvContrl = self.navigationController!
                    
                    let slide2:DayScheduleView = (self.storyboard?.instantiateViewController(withIdentifier: "DayScheduleView") as? DayScheduleView)!
                    slide2.week_schedule = self.week_schedule[1]
                    slide2.nvContrl = self.navigationController!
                    
                    let slide3:DayScheduleView = (self.storyboard?.instantiateViewController(withIdentifier: "DayScheduleView") as? DayScheduleView)!
                    slide3.week_schedule = self.week_schedule[2]
                    slide3.nvContrl = self.navigationController!
                    
                    let slide4:DayScheduleView = (self.storyboard?.instantiateViewController(withIdentifier: "DayScheduleView") as? DayScheduleView)!
                    slide4.week_schedule = self.week_schedule[3]
                    slide4.nvContrl = self.navigationController!
                    
                    let slide5:DayScheduleView = (self.storyboard?.instantiateViewController(withIdentifier: "DayScheduleView") as? DayScheduleView)!
                    slide5.week_schedule = self.week_schedule[4]
                    slide5.nvContrl = self.navigationController!
                    
                    let slide6:DayScheduleView = (self.storyboard?.instantiateViewController(withIdentifier: "DayScheduleView") as? DayScheduleView)!
                    slide6.week_schedule = self.week_schedule[5]
                    slide6.nvContrl = self.navigationController!
                    
                    self.slides.append(slide1)
                    self.slides.append(slide2)
                    self.slides.append(slide3)
                    self.slides.append(slide4)
                    self.slides.append(slide5)
                    self.slides.append(slide6)
                    
                    for vv in self.slides{
                        vv.id_week_select = self.id_week_
                    }
                 
                    self.setupScrollView(pages: self.slides)
                    
                    self.dateDaysOfWeek = JSONLessons.number_dayofweek
                    
                    let gg = self.selectDay * Int(self.view.frame.width/6)
                    self.getDayNowView.frame.origin.x =  CGFloat(gg + Int(self.view.frame.width/12 - self.getDayNowView.frame.width/2))
                    self.dayListCV.reloadData()
                    self.loadDataView.isHidden = true
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
    func issetNumberLesson(numb:Int, arr:[[weekLesson]]) -> Bool{
        for less in arr{
            if numb == Int(less[0].number){
                return true
            }
        }
        return false
    }
    func getKeyNumberLesson(numb:Int, arr:[[weekLesson]]) -> Int{
        if arr.count>0{
            var i = 0
            for less in arr{
                if numb == Int(less[0].number){
                    return i
                }
                i+=1
            }
        }
        return 0
    }
}
extension ScheduleViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if week_schedule.count>0{
            selectDay = indexPath.item
            
            dayListCV.reloadData()
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                let gg = indexPath.item * Int(self.view.frame.width/6)
                self.getDayNowView.frame.origin.x =  CGFloat(gg + Int(self.view.frame.width/12 - self.getDayNowView.frame.width/2))
            }, completion: { finished in
            })
            self.scrollView.contentOffset.x = CGFloat(indexPath.item) * self.view.frame.width
            for sl in slides{
                sl.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WeekListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekListCollectionViewCell", for: indexPath) as! WeekListCollectionViewCell
        if indexPath.item == selectDay{
            cell.date.textColor = UIColor.black
            cell.name.textColor = UIColor.white
        }
        else{
            if week_schedule.count > 0{
                if week_schedule[indexPath.item].schedule.count == 0{
                    cell.date.textColor = UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1)
                    cell.name.textColor = UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1)
                }
                else{
                  
                    cell.date.textColor = UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1)
                    cell.name.textColor = UIColor.black
                }
            }
            else{
                cell.date.textColor = UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1)
                cell.name.textColor = UIColor.lightGray
            }
        }
        
        cell.name.text = days[indexPath.item].name
        if dateDaysOfWeek.count>0{
            cell.date.text = dateDaysOfWeek[indexPath.item]
        }
        else{
            cell.date.text = days[indexPath.item].date
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


enum ModalScaleState {
    case presentation
    case interaction
}


