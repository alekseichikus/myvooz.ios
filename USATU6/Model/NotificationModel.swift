//
//  NotificationModel.swift
//  USATU6
//
//  Created by Алексей Мокшанцев on 21/12/2019.
//  Copyright © 2019 aleksei. All rights reserved.
//

import Foundation

struct notification: Decodable{
    var text:String = ""
    var user_name:String = ""
    var user_image:String = ""
    var date:String = ""
    var position:String = ""
    var type:Int = 0
}
