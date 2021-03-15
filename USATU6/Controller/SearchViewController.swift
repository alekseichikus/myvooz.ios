//
//  SearchProfileViewController.swift
//  rtreterg
//
//  Created by aleksei on 12.09.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource,  UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var listTV: UITableView!
    
    var key_id:String = ""
    var name_request:String = ""
    
    var arr = [sectionData]()
    var arr_search = [sectionData]()
    
    var FilterVC:FilterViewController!
    var ProfileVC:ProfileViewController!
    var SearchEmptyClassroomVC:SearchEmptyClassroomViewController!
    
    struct sectionData:Decodable{
        var id:Int = 0
        var name:String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iii = #imageLiteral(resourceName: "icon-close-circle")
        let jjj = iii.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(jjj, for: .normal)
        closeButton.tintColor = UIColor(displayP3Red: 173/255, green: 179/255, blue: 187/255, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainView.layer.cornerRadius = 20
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        navigationController?.setNavigationBarHidden(false, animated: true)
        listTV.separatorColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        searchBar.placeholder = "Найти"

        let urlGetLessons = "https://createtogether.ru/profile?type=" + name_request
        print(urlGetLessons)
        let urlObjGetLessons = URL(string: urlGetLessons)
        URLSession.shared.dataTask(with: urlObjGetLessons!) {(data, response, error) in
            
            guard let data = data else{ return}
            guard error == nil else{return}
            do{
                let JSONLessons = try JSONDecoder().decode([sectionData].self, from: data)
                DispatchQueue.main.async {
                    self.arr = JSONLessons
                    self.arr_search = self.arr
                    self.listTV.reloadData()
                }
            }
            catch let error{
                print("keks")
                print(error)
            }
            }.resume()
        searchBar.delegate = self
        listTV.delegate = self
        listTV.dataSource = self
    }
    @IBAction func closeClickButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        var ii:Int
        var name:String
        if arr_search.count>0{
            ii = arr_search[indexPath.item].id
            name = arr_search[indexPath.item].name
        }
        else{
            ii = arr[indexPath.item].id
            name = arr[indexPath.item].name
        }
        defaults.set(name, forKey: "name_" + key_id)
        defaults.set(ii, forKey: "id_" + key_id)
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        if FilterVC != nil{
            if key_id == "group"{
                FilterVC.id_group = ii
                FilterVC.name_group = name
            }
            else if key_id == "teacher"{
                FilterVC.id_teacher = ii
                FilterVC.name_teacher = name
            }
            else if key_id == "week"{
                FilterVC.id_week = ii
                FilterVC.name_week = name
            }
            FilterVC.reloadMData()
        }
        if ProfileVC != nil{
            ProfileVC.reloadMData()
        }
        if SearchEmptyClassroomVC != nil{
            if name_request == "corpus"{
                SearchEmptyClassroomVC.id_corpus = ii
                SearchEmptyClassroomVC.name_corpus = name
            }
            SearchEmptyClassroomVC.reloadMData()
        }
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_search.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.name.text = arr_search[indexPath.item].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(55)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            arr_search = arr
            listTV.reloadData()
            return
        }
        arr_search = arr.filter({ (sectData) -> Bool in
            
            return sectData.name.lowercased().contains(searchText.lowercased())
        })
        listTV.reloadData()
    }
}


