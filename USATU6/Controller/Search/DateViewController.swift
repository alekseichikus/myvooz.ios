//
//  DateViewController.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 20/01/2020.
//  Copyright © 2020 aleksei. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var SearchEmptyClassroomVC:SearchEmptyClassroomViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        selectButton.layer.cornerRadius = 4
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    @IBAction func selectClickButton(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        if SearchEmptyClassroomVC != nil{
            SearchEmptyClassroomVC.name_date = selectedDate
            SearchEmptyClassroomVC.reloadMData()
        }
        print(selectedDate)
        self.dismiss(animated: true, completion: nil)
    }

}
