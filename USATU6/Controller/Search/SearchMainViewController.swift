//
//  SearchViewController.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 18/01/2020.
//  Copyright © 2020 aleksei. All rights reserved.
//

import UIKit

class SearchMainViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var listTV: UITableView!
    
    var datas = [inffo]()
    var customData = CustomData()
    var ii = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        customData.setupNavigationController(navigationController: self.navigationController!)
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon-angle-left")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon-angle-left")
        customData.setGradientMainView(view: view, gradient: customData.firstGradient)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        mainView.layer.cornerRadius = 15
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        listTV.separatorStyle = .none
        
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowOpacity = 0.1
        
        listTV.isScrollEnabled = false
        
        
        
    }
}
extension SearchMainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchEmptyClassroomViewController") as? SearchEmptyClassroomViewController
        vc?.modalPresentationStyle = .fullScreen
        vc?.modalTransitionStyle   = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SearchListBigViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchListBigViewCell", for: indexPath) as! SearchListBigViewCell
       let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        cell.layer.cornerRadius = 15
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.4
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
}
