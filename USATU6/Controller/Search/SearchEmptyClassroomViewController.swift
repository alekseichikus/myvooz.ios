//
//  SearchViewController.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 18/01/2020.
//  Copyright © 2020 aleksei. All rights reserved.
//

import UIKit
import SwiftRangeSlider

class SearchEmptyClassroomViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var listTV: UITableView!
    @IBOutlet weak var classroomsTV: UITableView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var timeRangeSlider: RangeSlider!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var heightMainViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var classroomsLabel: UILabel!
    @IBOutlet weak var emptyClassroomsLabel: UILabel!
    @IBOutlet weak var corpusLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loadImage: UIImageView!
    @IBOutlet weak var LoadView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var classrooms = [[classroom]]()
    var datas = [inffo]()
    var customData = CustomData()
    var ii = 0
    var id_corpus = 0
    var name_corpus = ""
    var name_date = ""
    
    struct MData:Decodable{
    var classrooms = [[classroom]]()
    }
    
    struct classroom:Decodable{
        var name:String = ""
        var floor:String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateData()
        
        timeRangeSlider.listTV = listTV
        timeRangeSlider.frame.size.width = view.frame.width-32
        
        heightMainViewConstraint.constant = view.frame.height - 40 - 16 - 19
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let selectedDate = dateFormatter.string(from: Date())
        
        name_date = selectedDate
        
        setup()
        
        customData.rotateImage(loadImage: loadImage)
    }
    
    func updateData(){
        datas = []
        var d1 = inffo()
        d1.title = "Корпус"
        if id_corpus == 0{
            d1.name = "Не выбран"
        }
        else{
            d1.name = name_corpus + " корпус"
        }
        
        
        var d2 = inffo()
        d2.title = "День"
        d2.name = name_date
        
        var d3 = inffo()
        d3.title = "Время"
        d3.name = customData.getTimeOfLessonLower(numb: Int(timeRangeSlider!.lowerValue)) + "-" + customData.getTimeOfLessonUpper(numb: Int(timeRangeSlider!.upperValue))
        
        datas.append(d1)
        datas.append(d2)
        datas.append(d3)
    }
    
    func setup(){
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        listTV.separatorStyle = .none
        
        timeRangeSlider.gg = 12.0
        timeRangeSlider.trackHighlightTintColor = UIColor.systemGreen
        
        searchButton.layer.cornerRadius = 4
        searchButton.layer.backgroundColor = UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1).cgColor
        
        customData.changeImageColor(image: closeButton.imageView!, color: UIColor(displayP3Red: 173/255, green: 179/255, blue: 187/255, alpha: 1))
        
        view.layer.backgroundColor = UIColor(displayP3Red: 250/255, green: 250/255, blue: 250/255, alpha: 1).cgColor
        
        listTV.isScrollEnabled = false
        
        classroomsTV.isScrollEnabled = false
        
        classroomsTV.separatorStyle = .none
        
        customData.changeImageColor(image: loadImage, color: UIColor(displayP3Red: 161/255, green: 165/255, blue: 178/255, alpha: 1))
        
    }
    func getData(){
        let urlGetNextLesson = "https://createtogether.ru/lesson?type=classroom&id_corpus="+String(id_corpus)+"&low_number="+String(Int(timeRangeSlider!.lowerValue))+"&upper_number="+String(Int(timeRangeSlider!.upperValue))+"&date=" + name_date
        print(urlGetNextLesson)
        print(urlGetNextLesson)
        let urlObjGetNextLesson = URL(string: urlGetNextLesson)
        URLSession.shared.dataTask(with: urlObjGetNextLesson!) {(data, response, error) in
            
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode(MData.self, from: data)
                DispatchQueue.main.async {
                    self.classrooms = JSONLessons.classrooms
                    if JSONLessons.classrooms.count > 0{
                        var crs = ""
                        self.classrooms = JSONLessons.classrooms
                        self.corpusLabel.text = self.name_corpus + " корпус"
                        self.classroomsLabel.text = "Свободные аудитории в теч. " + self.customData.getTimeOfLessonLower(numb: Int(self.timeRangeSlider!.lowerValue)) + "-" + self.customData.getTimeOfLessonUpper(numb: Int(self.timeRangeSlider!.upperValue))
                        
                        self.emptyClassroomsLabel.isHidden = true
                        self.corpusLabel.isHidden = false
                        self.classroomsLabel.isHidden = false
                        
                        var hhheight = 195 + 8 + 32 + 32 + 21
                        hhheight = hhheight + 45 + 16 + 18 + 8 + Int(self.getHeightClassrooms()) + 16
                        
                        if hhheight < Int(self.view.frame.height) - 40 - 16 - 19{
                            self.heightMainViewConstraint.constant = CGFloat(self.view.frame.height - 40 - 16 - 19)
                        }
                        else{
                            self.heightMainViewConstraint.constant = CGFloat(hhheight)
                        }
                        
                        self.classroomsTV.reloadData()
                        
                        var offbh = hhheight - Int(self.view.frame.height - 75)
                        
                        if offbh < 0{
                            offbh = 0
                        }
                        
                        var bottomOffset = CGPoint(x: 0, y: offbh)
                        
                        UIView.animate(withDuration: 3.0, delay: 2.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                            self.scrollView.setContentOffset(bottomOffset, animated: true)
                            self.LoadView.isHidden = true
                            
                        }, completion: nil)
                    }
                    else{
                        self.emptyClassroomsLabel.isHidden = false
                        self.corpusLabel.isHidden = true
                        self.classroomsLabel.isHidden = true
                        self.heightMainViewConstraint.constant = CGFloat(self.view.frame.height - 40 - 16 - 19)
                        self.LoadView.isHidden = true
                    }
                }
            }
            catch let error{
                print(error)
            }
            }.resume()
    }
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func searchButtonClick(_ sender: Any) {
        
        if id_corpus != 0{
            heightMainViewConstraint.constant = view.frame.height - 40 - 16 - 19
            infoLabel.isHidden = true
            LoadView.isHidden = false
            getData()
        }
        else{
            listTV.shake()
        }
    }
    
    func reloadMData(){
        listTV.reloadData()
    }
    
    func getHeightClassrooms() -> CGFloat{
        var hheight:CGFloat = 0
        for fl in classrooms{
            var widthText = view.frame.width - 16 - 16
            let size = CGSize(width: widthText, height: 1000)
            let attributes = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 14, weight: .regular)]
            var estimatedFrame = CGRect()
            
            
            var crs = ""
            if classrooms.count>0{
                for cl in fl{
                    if cl.name != fl.last?.name{
                        crs += cl.name + ", "
                    }
                    else{
                        crs += cl.name
                    }
                }
            }
            
            estimatedFrame = NSString(string: crs).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            var hh = estimatedFrame.height
            if estimatedFrame.height > 34{
                hh = 34
            }
            hheight += 30 + hh
        }
        return hheight
    }
}
extension SearchEmptyClassroomViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listTV == tableView{
            updateData()
            return datas.count
        }
        else{
            return classrooms.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listTV == tableView{
            if indexPath.item == 0{
                let controller = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
                controller?.key_id = "corpus_search"
                controller?.name_request = "corpus"
                controller?.SearchEmptyClassroomVC = self
                customData.presentModalView(view: self, controller: controller!, YOffset: 100)
            }
            else if indexPath.item == 1{
                let controller = storyboard?.instantiateViewController(withIdentifier: "DateViewController") as? DateViewController
                controller?.SearchEmptyClassroomVC = self
                customData.presentModalView(view: self, controller: controller!, YOffset: 150)
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listTV.self{
            var cell:SearchListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableViewCell", for: indexPath) as! SearchListTableViewCell
            
            cell.title.text = datas[indexPath.item].title
            cell.selectLabel.text = datas[indexPath.item].name
            if indexPath.item != datas.count-1{
                customData.addBottomBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: cell, width: 1)
            }
            cell.selectionStyle = .none
            return cell
        }
        else{
            var cell:SearchClassroomsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchClassroomsTableViewCell", for: indexPath) as! SearchClassroomsTableViewCell
            
            var crs = ""
            if classrooms.count>0{
                for cl in classrooms[indexPath.item]{
                    if cl.name != classrooms[indexPath.item].last?.name{
                        crs += cl.name + ", "
                    }
                    else{
                        crs += cl.name
                    }
                }
            }
            cell.listLabel.text = crs
            cell.title.text = classrooms[indexPath.item][0].floor + " этаж"
            
            cell.selectionStyle = .none
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == listTV{
            return CGFloat(65)
        }
        else{
            var widthText = view.frame.width - 16 - 16
            let size = CGSize(width: widthText, height: 1000)
            let attributes = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 14, weight: .regular)]
            var estimatedFrame = CGRect()
            
            
            var crs = ""
            if classrooms.count>0{
                for cl in classrooms[indexPath.item]{
                    if cl.name != classrooms[indexPath.item].last?.name{
                        crs += cl.name + ", "
                    }
                    else{
                        crs += cl.name
                    }
                }
            }
            
            estimatedFrame = NSString(string: crs).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            var hh = estimatedFrame.height
            if estimatedFrame.height > 34{
                hh = 34
            }
            return CGFloat(30 + hh)
        }
    }
}
