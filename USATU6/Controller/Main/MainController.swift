//
//  ViewController.swift
//  USATU6
//
//  Created by aleksei on 22.09.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var secondMainView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var LoadView: UIView!
    @IBOutlet weak var notScheduleView: UIView!
    @IBOutlet weak var errorInternetView: UIView!
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var NewsCollectionView: UICollectionView!
    @IBOutlet weak var storiesView: UIView!
    @IBOutlet weak var notScheduleImage: UIImageView!
    @IBOutlet weak var DayScheduleTableView: UITableView!
    @IBOutlet weak var heightScrollViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var notSelectedView: UIView!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var loadImageView: UIImageView!
    @IBOutlet var WarningOutletCollectionViews: [UIView]!
    
    var id_group=0, id_teacher = 0, id_type=0, is_empty_hidden = true
    var id_news_cv = "newsCV", id_now_next_tv = "nowNextTV", id_schedule_tv = "scheduleTV"
    
    
    private var _view: IGHomeView{return view as! IGHomeView}
    private var viewModel: IGHomeViewModel = IGHomeViewModel()
    let defaults = UserDefaults.standard
    var customData = CustomData()
    var openedNowNextSchedule = [Bool]()
    var openedDaySchedule = [Bool]()
    var refreshContent = UIRefreshControl()
    var news_board = [news]()
    var day_schedule = [[lesson]]()
    
    var scheduleTableView:UITableView?
    
    override func loadView() {
        view = IGHomeView(frame: UIScreen.main.bounds)
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*refreshContent.addTarget(self, action: #selector(MainController.refreshGetData), for: UIControl.Event.valueChanged)
        
        
        for ij in WarningOutletCollectionViews{
            ij.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        
        id_group = customData.checkExistingDataInt(string: "id_group_profile")
        id_teacher = customData.checkExistingDataInt(string: "id_teacher_profile")
        id_type = customData.checkExistingDataInt(string: "id_type_profile")
        if let data:Bool = defaults.bool(forKey: "id_hide_empty_profile"){
            is_empty_hidden = defaults.bool(forKey: "id_hide_empty_profile")
        }
        
        NewsCollectionView?.dataSource = self
        NewsCollectionView?.delegate = self
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        updateInfo(id_type: id_type, id_group: id_group, id_teacher: id_teacher, is_empty_hidden: is_empty_hidden)
        if CheckInternet.isConnectedToNetwork(){
            getNews()
        }
        
        heightScrollViewConstraint.constant = view.frame.height - 110
        setup()
        
        customData.rotateImage(loadImage: loadImageView)
        setNeedsStatusBarAppearanceUpdate()*/
        customData.setupNavigationController(navigationController: self.navigationController!)
        customData.setGradientMainView(view: view, gradient: customData.firstGradient)
    }
    @objc private func clearImageCache() {
        IGCache.shared.removeAllObjects()
    }
    func setup(){
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowOpacity = 0.05
        mainView.layer.cornerRadius = 20
        LoadView.layer.cornerRadius = 20
        notSelectedView.layer.cornerRadius = 20
        notScheduleView.layer.cornerRadius = 20
        errorInternetView.layer.cornerRadius = 20
        notScheduleView.layer.cornerRadius = 20
        notScheduleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        refreshContent.tintColor = UIColor.white
        DayScheduleTableView.separatorStyle = .none
        
        scrollView.isScrollEnabled = true
        DayScheduleTableView?.isScrollEnabled = false
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        
        customData.changeImageColor(image: notScheduleImage, color: UIColor(displayP3Red: 143/255, green: 152/255, blue: 168/255, alpha: 1))
        customData.setGradientMainView(view: view, gradient: customData.firstGradient)
    }
    
    func hideWarningOutletCollectionViews(){
        for vv in WarningOutletCollectionViews{
            vv.isHidden = true
        }
    }
    func updateInfo(id_type:Int, id_group:Int, id_teacher:Int, is_empty_hidden:Bool){
        hideWarningOutletCollectionViews()
        
        if (id_type == 0 && id_group == 0) || (id_type == 1 && id_teacher == 0){
            notSelectedView.isHidden = false
            heightScrollViewConstraint.constant = view.frame.height - 61
            refreshContent.endRefreshing()
        }
        else{
            if CheckInternet.isConnectedToNetwork(){
                LoadView.isHidden = false
                if id_type == 0{
                    getData(id_group: id_group, type: "group", is_empty_hidden: is_empty_hidden)
                }
                else{
                    getData(id_group: id_teacher, type: "teacher", is_empty_hidden: is_empty_hidden)
                }
            }
            else{
                errorInternetView.isHidden = false
                refreshContent.endRefreshing()
            }
        }
    }
    @objc func refreshGetData(){
        updateInfo(id_type: id_type, id_group: id_group, id_teacher: id_teacher, is_empty_hidden: is_empty_hidden)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.storiesView = IGHomeView(frame: UIScreen.main.bounds)
        /*super.viewWillAppear(animated)
        
        let id_group_profile = customData.checkExistingDataInt(string: "id_group_profile")
        let id_teacher_profile = customData.checkExistingDataInt(string: "id_teacher_profile")
        let id_type_profile = customData.checkExistingDataInt(string: "id_type_profile")
        var is_empty_hidden_profile = true
        if let data:Bool = defaults.bool(forKey: "id_hide_empty_profile"){
            is_empty_hidden_profile = data
        }
        if (id_type != id_type_profile ||  id_group != id_group_profile || id_teacher != id_teacher_profile || is_empty_hidden != is_empty_hidden_profile){
            updateInfo(id_type: id_type_profile, id_group: id_group_profile, id_teacher: id_teacher_profile, is_empty_hidden: is_empty_hidden_profile)
            id_group = id_group_profile
            id_type = id_type_profile
            id_teacher = id_teacher_profile
            is_empty_hidden = is_empty_hidden_profile
        }
        
        customData.setupNavigationController(navigationController: self.navigationController!)
        */
    }
    @objc func getNews(){
        let urlGetLessons = "https://createtogether.ru/lesson?type=news"
        let urlObjGetLessons = URL(string: urlGetLessons)
        URLSession.shared.dataTask(with: urlObjGetLessons!) {(data, response, error) in
            
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode([news].self, from: data)
                DispatchQueue.main.async {
                    self.news_board = JSONLessons
                    self.NewsCollectionView!.reloadData()
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
    @objc func getData(id_group: Int, type: String, is_empty_hidden: Bool){
        let urlGetLessons = "https://createtogether.ru/lesson?type=day&id_"+String(type)+"=" + String(id_group)
        print(urlGetLessons)
        let urlObjGetLessons = URL(string: urlGetLessons)
        URLSession.shared.dataTask(with: urlObjGetLessons!) {(data, response, error) in
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode(findings.self, from: data)
                DispatchQueue.main.async {
                    
                    var heightSecondMV:CGFloat = 0
                    self.day_schedule = JSONLessons.day_schedule
                    self.navigationController?.navigationBar.topItem?.title = String(JSONLessons.number_week) + "-ая неделя"
                    self.customData.setData(keyData: "name_week_profile", data: String(JSONLessons.number_week))
                    self.customData.setData(keyData: "name_week_profile", data: String(JSONLessons.number_week))
                    self.dayNameLabel.text = JSONLessons.name_day
                    self.openedDaySchedule = []
                    
                    if self.day_schedule.count > 0 {
                        if is_empty_hidden{
                            for _ in 0...(self.day_schedule.count-1){
                                self.openedDaySchedule.append(false)
                            }
                        }
                        else{
                            self.day_schedule = [[lesson]]()
                            for var i in 0...6{
                                self.openedDaySchedule.append(false)
                                if self.issetNumberLesson(numb: i + 1, arr: JSONLessons.day_schedule){
                                    self.day_schedule.append(JSONLessons.day_schedule[self.getKeyNumberLesson(numb: i + 1, arr: JSONLessons.day_schedule)])
                                }
                                else{
                                    self.day_schedule.append([])
                                }
                            }
                        }
                        heightSecondMV = CGFloat(self.getHeightSecondMainView())
                    }
                    
                    if heightSecondMV == 0{
                        self.notScheduleView.isHidden = false
                        self.heightScrollViewConstraint.constant = self.view.safeAreaLayoutGuide.layoutFrame.height
                    }
                    else{
                        self.mainView.isHidden = false
                        self.heightScrollViewConstraint.constant = heightSecondMV + 16 + 16 + 130 + 8 + 21 + 16
                    }
                
                    self.DayScheduleTableView.reloadData()
                    self.LoadView.isHidden = true
                    self.refreshContent.endRefreshing()
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
    func issetNumberLesson(numb:Int, arr:[[lesson]]) -> Bool{
        for less in arr{
            if numb == Int(less[0].number){
                return true
            }
        }
        return false
    }
    func getKeyNumberLesson(numb:Int, arr:[[lesson]]) -> Int{
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
    func getHeightSecondMainView() -> Int{
        if day_schedule.count > 0 {
            var heightFirstMainView:Int = 16 + 18  + 8 + 24
            for i in 0...(day_schedule.count - 1){
                if openedDaySchedule[i]{
                    heightFirstMainView += 55 * day_schedule[i].count
                }
                else{
                    heightFirstMainView += 55
                }
            }
            return heightFirstMainView
        }
        return 0
    }
    @IBAction func clickPersonalAccount(_ sender: Any) {
        if let indexPath = (sender as AnyObject).tag {
            if let url = NSURL(string: "https://lk.ugatu.su/lk/"){
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    @IBAction func clickGetPublic(_ sender: Any) {
        if let indexPath = (sender as AnyObject).tag {
            if let url = NSURL(string: "https://vk.com/myvoooz"){
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
extension MainController: UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IGStoryListCell.reuseIdentifier,for: indexPath) as? IGStoryListCell else { fatalError() }
        let story = viewModel.cellForItemAt(indexPath: indexPath)
        cell.story = story
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let stories = self.viewModel.getStories(), let stories_copy = try? stories.copy() {
                let storyPreviewScene = IGStoryPreviewController.init(stories: stories_copy, handPickedStoryIndex:  indexPath.row)
                self.present(storyPreviewScene, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 130)
    }
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 16
    }
}
extension MainController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if openedDaySchedule[section] == true{
            return day_schedule[section].count
        }
        else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if day_schedule[indexPath.section].count > 1{
            if openedDaySchedule[indexPath.section] == true{
                let cell:scheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: id_schedule_tv, for: indexPath) as! scheduleTableViewCell
                cell.addSubjectLabel.isHidden = false
                cell.closeNumberLabel.isHidden = false
                openedDaySchedule[indexPath.section] = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                let heightSecondMV = CGFloat(self.getHeightSecondMainView())
     
                heightScrollViewConstraint.constant = heightSecondMV + 16 + 16 + 130 + 8 + 21
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
                let vc = storyboard?.instantiateViewController(withIdentifier: "LessonViewController") as? LessonViewController
                vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                vc?.modalTransitionStyle   = .flipHorizontal
                let ds = day_schedule[indexPath.section][indexPath.row]
                vc?.name = ds.name
                vc?.classroom_lesson = ds.classroom
                vc?.type_lesson = ds.type
                vc?.time_lesson = ds.time
                vc?.id_group = id_group
                vc?.id_schedule = ds.id
                vc?.number_lesson = ds.number_text
                vc?.id_object = ds.id_object
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else{
                let cell:scheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: id_schedule_tv, for: indexPath) as! scheduleTableViewCell
                
                openedDaySchedule[indexPath.section] = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                cell.closeStatusImageBlock.isHidden = true
                cell.addSubjectLabel.isHidden = true
                cell.closeNumberLabel.isHidden = true
                cell.numberLabel.isHidden = false
                
                let heightSecondMV = CGFloat(self.getHeightSecondMainView())

                heightScrollViewConstraint.constant = heightSecondMV + 16 + 16 + 130 + 8 + 21
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        else if day_schedule[indexPath.section].count == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LessonViewController") as? LessonViewController
            vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc?.modalTransitionStyle   = .flipHorizontal
            let ds = day_schedule[indexPath.section][indexPath.row]
            vc?.name = ds.name
            vc?.id_object = ds.id
            vc?.classroom_lesson = ds.classroom
            vc?.type_lesson = ds.type
            vc?.time_lesson = ds.time
            vc?.id_group = id_group
            vc?.id_schedule = ds.id
            vc?.number_lesson = ds.number_text
            vc?.id_object = ds.id_object
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:scheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: id_schedule_tv, for: indexPath) as! scheduleTableViewCell
        cell.selectionStyle = .none
        if day_schedule[indexPath.section].count>0{
            
            var ds = day_schedule[indexPath.section][indexPath.row]
            
            cell.title.tag = indexPath.item
            cell.closeStatusImageBlock.image = cell.closeStatusImageBlock.image?.withRenderingMode(.alwaysTemplate)
            cell.closeStatusImageBlock.tintColor = UIColor.black
            cell.title.text = ds.name
            cell.timeLabel.text = ds.time
            
            if ds.classroom != ""{
                cell.info.text = ds.classroom + ", " + String(customData.getTypeLesson(typeLesson: ds.type))
            }
            else{
                cell.info.text = String(customData.getTypeLesson(typeLesson: ds.type))
            }
            
            cell.closeStatusImageBlock.isHidden = true
            cell.addSubjectLabel.isHidden = true
            cell.numberLabel.text = ds.number_text
            cell.closeNumberLabel.text = ds.number_text
            let typeLesson = day_schedule[indexPath.section][indexPath.row].type
            
            if indexPath.row == 0{
                if day_schedule[indexPath.section][0].is_run{
                    cell.closeStatusImageBlock.image = cell.closeStatusImageBlock.image?.withRenderingMode(.alwaysTemplate)
                    cell.closeStatusImageBlock.tintColor = UIColor.white
                    cell.closeNumberLabel.textColor = UIColor.white
                    cell.numberLabel.textColor = UIColor.white
                    customData.setBackgroundView(typeLesson: typeLesson, view: cell.numberGradientView)
                }
                else{
                    cell.closeStatusImageBlock.image = cell.closeStatusImageBlock.image?.withRenderingMode(.alwaysTemplate)
                    cell.closeStatusImageBlock.tintColor = UIColor(displayP3Red: 177/255, green: 180/255, blue: 181/255, alpha: 1)
                    cell.closeNumberLabel.textColor = UIColor.black
                    cell.numberLabel.textColor = UIColor.black
                    customData.setBackgroundView(typeLesson: -1, view: cell.numberGradientView)
                }
                cell.title.text = day_schedule[indexPath.section][0].name
                cell.numberLabel.text = day_schedule[indexPath.section][0].number_text
                
                cell.timeLabel.text = day_schedule[indexPath.section][0].time
                
                if day_schedule[indexPath.section].count > 1{
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
                cell.numberLabel.textColor = UIColor.black
                cell.closeNumberLabel.isHidden = true
                cell.numberLabel.isHidden = false
            }
            cell.emptyView.isHidden = true
            cell.title.isHidden = false
            cell.info.isHidden = false
        }
        else{
            cell.numberLabel.isHidden = false
            cell.closeNumberLabel.isHidden = true
            cell.emptyView.isHidden = false
            cell.title.isHidden = true
            cell.info.isHidden = true
            cell.closeStatusImageBlock.isHidden = true
            cell.numberLabel.textColor = UIColor.lightGray
            cell.numberLabel.text = String(indexPath.section + 1)
            cell.timeLabel.text = customData.getTimeOfLessonShort(numb: indexPath.section + 1)
        }
        cell.numberBlock.layer.cornerRadius = 20.0
        cell.numberGradientView.layer.cornerRadius = 20.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(55)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return day_schedule.count
    }

}
