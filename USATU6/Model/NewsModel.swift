//
//  NewsModel.swift
//  USATU6
//
//  Created by aleksei on 27.09.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import Foundation

class news: Decodable{
    var title:String = ""
    var image:String = ""
    var id:Int = 0
    var name:String = ""
    var logo_image:String = ""
    var link:String = ""
    var link_public:String = ""
}
