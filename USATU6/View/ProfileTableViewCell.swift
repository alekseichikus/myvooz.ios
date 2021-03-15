//
//  ProfileTableViewCell.swift
//  USATU6
//
//  Created by aleksei on 05.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class profileTableViewCell: UITableViewCell {
    @IBOutlet weak var angle_right_image: UIImageView!
    @IBOutlet weak var select_name_label: UILabel!
    @IBOutlet weak var type_name_label: UILabel!
}
class hideEmptyTableViewCell: UITableViewCell {
    @IBOutlet weak var switchEnable: UISwitch!
    @IBOutlet weak var title: UILabel!
}

class listLinkProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
}
