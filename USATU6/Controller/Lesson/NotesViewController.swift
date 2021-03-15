//
//  NotesViewController.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 15/01/2020.
//  Copyright © 2020 aleksei. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    let customData = CustomData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 15
        mainView.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        customData.changeImageColor(image: imageImage, color: UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1))
        customData.changeImageColor(image: closeButton.imageView!, color: UIColor(displayP3Red: 165/255, green: 175/255, blue: 189/255, alpha: 1))
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
