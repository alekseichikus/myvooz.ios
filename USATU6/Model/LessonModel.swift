//
//  LessonModel.swift
//  USATU6
//
//  Created by aleksei on 27.09.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import Foundation

struct lesson: Decodable{
    var name:String = ""
    var classroom:String = ""
    var type:Int = 0
    var number:String = ""
    var state:Bool = false
    var is_run:Bool = false
    var time:String = ""
    var number_text:String = ""
    var id:Int = 0
    var id_object:Int = 0
}
struct findings: Decodable{
    var day_schedule = [[lesson]]()
    var now_next_schedule = [[lesson]]()
    var number_week:Int = 0
    var name_day:String = ""
}
class weekLesson: Decodable{
    var name:String = ""
    var classroom:String = ""
    var type:Int = 0
    var number:String = ""
    var state:Bool = false
    var is_run:Bool = false
    var time:String = ""
    var weeks:String = ""
    var name_teacher:String = ""
    var groups:String = ""
    var number_text:String = ""
    var id:Int = 0
    var id_object:Int = 0
}
class weekLiteLesson: Decodable{
    var classroom:String = ""
    var type:Int = 0
    var number:String = ""
    var time:String = ""
}
struct schedule:Decodable{
    var schedule = [[weekLesson]]()
    var name_day:String = ""
}
struct schedule_2:Decodable{
    var schedule = [weekLiteLesson]()
    var name_day:String = ""
}

struct Week_Number:Decodable{
    var number_week:Int = 0
    var state:Int = 0
}

struct infoaddLes:Decodable{
    var id_group:Int = 0
    var id_teacher:Int = 0
    var time = ""
    var weeks:String = ""
}
struct infoGroup:Decodable{
    var name:String = ""
    var id:Int = 0
}
struct lesson_week:Decodable{
    var wday:Int = 0
    var type:Int = 0
}
struct notif{
    var text:String = ""
}
struct user:Decodable{
    var name:String = ""
    var image:String = ""
    var id:Int = 0
}
struct inffo{
    var name:String = ""
    var title:String = ""
    var imageName:String = ""
}
struct day_m{
    var name:String = ""
    var date:String = ""
}
