 //
//  ScheduleTableViewCell.swift
//  USATU6
//
//  Created by aleksei on 27.09.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit


class nowNextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var closeStatusImageBlock: UIImageView!
    @IBOutlet weak var numberBlock: UIView!
    @IBOutlet weak var addSubjectLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var closeNumberLabel: UILabel!
    @IBOutlet weak var numberGradientView: UIView!
    
}

class scheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var closeStatusImageBlock: UIImageView!
    @IBOutlet weak var numberBlock: UIView!
    @IBOutlet weak var addSubjectLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var closeNumberLabel: UILabel!
    @IBOutlet weak var numberGradientView: UIView!
    @IBOutlet weak var emptyView: UIView!
}
class weekScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var closeStatusImageBlock: UIImageView!
    @IBOutlet weak var numberBlock: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var closeNumberLabel: UILabel!
    @IBOutlet weak var numberGradientView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTeacherLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var angleRImage: UIImageView!
    @IBOutlet weak var doorImage: UIImageView!
}
class weekUserScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var closeStatusImageBlock: UIImageView!
    @IBOutlet weak var numberBlock: UIView!
    @IBOutlet weak var groupsLabel: UILabel!
    @IBOutlet weak var addSubjectLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var closeNumberLabel: UILabel!
    @IBOutlet weak var weeksLabel: UILabel!
    @IBOutlet weak var numberGradientView: UIView!
}
