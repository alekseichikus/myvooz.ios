//
//  DayLessonTableViewCell.swift
//  USATU6
//
//  Created by aleksei on 09.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class DayLessonTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberBlock: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var gradView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
