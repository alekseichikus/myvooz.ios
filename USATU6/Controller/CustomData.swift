//
//  CustomData.swift
//  USATU6
//
//  Created by aleksei on 31.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class CustomData{
    
    private var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
    
    var firstGradient:CAGradientLayer{
        let grad = CAGradientLayer()
        grad.colors = [UIColor(displayP3Red: 92/255, green: 124/255, blue: 189/255, alpha: 1).cgColor, UIColor(displayP3Red: 255/255, green: 240/255, blue: 234/255, alpha: 1).cgColor, UIColor.white.cgColor]
        grad.startPoint = CGPoint(x:0.0, y:0)
        grad.endPoint = CGPoint(x: 0.0, y: 1.0)
        grad.locations = [0.0, 0.75, 1.0]
        return grad
    }
    func setBackgroundView(typeLesson: Int, view: UIView){
        if typeLesson == 1{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
            grad.colors = [UIColor(displayP3Red: 224/255, green: 104/255, blue: 32/255, alpha: 1).cgColor, UIColor(displayP3Red: 253/255, green: 175/255, blue: 137/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:1.0, y:1 )
            grad.endPoint = CGPoint(x: 0.0, y: 0.0)
            view.layer.shadowColor = UIColor(displayP3Red: 253/255, green: 175/255, blue: 137/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
            
        }
        else if typeLesson == 0{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
            grad.colors = [UIColor(displayP3Red: 167/255, green: 191/255, blue: 232/255, alpha: 1).cgColor, UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1).cgColor]
            
            //grad.colors = [UIColor(displayP3Red: 172/255, green: 182/255, blue: 229/255, alpha: 1).cgColor, UIColor(displayP3Red: 141/255, green: 154/255, blue: 211/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:0.0, y:0.0)
            grad.endPoint = CGPoint(x: 1.0, y: 1.0)
            view.layer.shadowColor = UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
        }
        else if typeLesson == 2{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
            grad.colors = [UIColor(displayP3Red: 161/255, green: 140/255, blue: 238/255, alpha: 1).cgColor,UIColor(displayP3Red: 121/255, green: 97/255, blue: 207/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:0.0, y:0 )
            grad.endPoint = CGPoint(x: 1.0, y: 1.0)
            view.layer.shadowColor = UIColor(displayP3Red: 121/255, green: 97/255, blue: 207/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
        }
        else if typeLesson == 3{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
            grad.colors = [UIColor(displayP3Red: 255/255, green: 209/255, blue: 148/255, alpha: 1).cgColor, UIColor(displayP3Red: 255/255, green: 184/255, blue: 140/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:0.0, y:0 )
            grad.endPoint = CGPoint(x: 1.0, y: 1.0)
            view.layer.shadowColor = UIColor(displayP3Red: 209/255, green: 145/255, blue: 60/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
        }
        else if typeLesson == 4{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
            grad.colors = [UIColor(displayP3Red: 141/255, green: 194/255, blue: 111/255, alpha: 1).cgColor,UIColor(displayP3Red: 118/255, green: 184/255, blue: 82/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:0.0, y:0 )
            grad.endPoint = CGPoint(x: 1.0, y: 1.0)
            view.layer.shadowColor = UIColor(displayP3Red: 118/255, green: 184/255, blue: 82/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
        }
        else if typeLesson == 5{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
            grad.colors = [UIColor(displayP3Red: 146/255, green: 167/255, blue: 119/255, alpha: 1).cgColor,UIColor(displayP3Red: 100/255, green: 145/255, blue: 115/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:0.0, y:0 )
            grad.endPoint = CGPoint(x: 1.0, y: 1.0)
            view.layer.shadowColor = UIColor(displayP3Red: 100/255, green: 145/255, blue: 115/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
        }
        else if typeLesson == 7{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
           
            
            grad.colors = [UIColor(displayP3Red: 172/255, green: 182/255, blue: 229/255, alpha: 1).cgColor, UIColor(displayP3Red: 141/255, green: 154/255, blue: 211/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:0.0, y:0.0)
            grad.endPoint = CGPoint(x: 1.0, y: 1.0)
            view.layer.shadowColor = UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
        }
        else if typeLesson == 8{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
            grad.colors = [UIColor(displayP3Red: 234/255, green: 175/255, blue: 200/255, alpha: 1).cgColor,UIColor(displayP3Red: 101/255, green: 78/255, blue: 163/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:0.0, y:0 )
            grad.endPoint = CGPoint(x: 1.0, y: 1.0)
            view.layer.shadowColor = UIColor(displayP3Red: 100/255, green: 145/255, blue: 115/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
        }
        else if typeLesson == -1{
            let grad = CAGradientLayer()
            grad.frame = view.bounds
            grad.frame.size.width = view.frame.width
            grad.frame.size.height = view.frame.height
            grad.cornerRadius = CGFloat(view.frame.width/2)
            grad.colors = [UIColor(displayP3Red: 245/255, green: 243/255, blue: 245/255, alpha: 1).cgColor,UIColor(displayP3Red: 245/255, green: 243/255, blue: 245/255, alpha: 1).cgColor]
            grad.startPoint = CGPoint(x:0.0, y:0 )
            grad.endPoint = CGPoint(x: 1.0, y: 1.0)
            view.layer.shadowColor = UIColor(displayP3Red: 245/255, green: 243/255, blue: 245/255, alpha: 1).cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.insertSublayer(grad, at: UInt32(view.layer.sublayers?.count ?? 0))
            
            
        }
    }
    func setColorText(ttext:UILabel, typeLesson:Int){
        if typeLesson == 1{
            ttext.textColor = UIColor(displayP3Red: 253/255, green: 175/255, blue: 137/255, alpha: 1)
        }
        else if typeLesson == 0{
            ttext.textColor = UIColor(displayP3Red: 97/255, green: 144/255, blue: 232/255, alpha: 1)
        }
        else if typeLesson == 2{
            ttext.textColor = UIColor(displayP3Red: 121/255, green: 97/255, blue: 207/255, alpha: 1)
        }
        else if typeLesson == 3{
            ttext.textColor = UIColor(displayP3Red: 255/255, green: 184/255, blue: 140/255, alpha: 1)
        }
        else if typeLesson == 4{
            ttext.textColor = UIColor(displayP3Red: 118/255, green: 184/255, blue: 82/255, alpha: 1)
        }
        else if typeLesson == 5{
            ttext.textColor = UIColor(displayP3Red: 100/255, green: 145/255, blue: 115/255, alpha: 1)
        }
        else if typeLesson == 7{
            ttext.textColor = UIColor(displayP3Red: 141/255, green: 154/255, blue: 211/255, alpha: 1)
        }
        else if typeLesson == 8{
            ttext.textColor = UIColor(displayP3Red: 101/255, green: 78/255, blue: 163/255, alpha: 1)
        }
        else{
            ttext.textColor = UIColor(displayP3Red: 245/255, green: 243/255, blue: 245/255, alpha: 1)
            
            
        }
    }
    func getTypeLesson(typeLesson: Int) -> String{
        if typeLesson == 0{
            return "Лекция"
        }
        else if typeLesson == 1{
            return "Практика"
        }
        else if typeLesson == 2{
            return "Лабораторная работа"
        }
        else if typeLesson == 3{
            return "Физвоспитание"
        }
        else if typeLesson == 4{
            return "Военная подготовка"
        }
        else if typeLesson == 5{
            return "Лекция + практика"
        }
        else if typeLesson == 7{
            return "Консультанция"
        }
        else if typeLesson == 8{
            return "Прочее"
        }
        return "wtf..."
    }
    func changeImageColor(image:UIImageView, color:UIColor){
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = color
    }
    func checkExistingData(string:String) -> String{
        let defaults = UserDefaults.standard
        if let data = defaults.string(forKey: string) {
            return String(data)
        }
        return ""
    }
    func checkExistingDataInt(string:String) -> Int{
        let defaults = UserDefaults.standard
        if let data = defaults.string(forKey: string) {
            return Int(data)!
        }
        return 0
    }
    func getGradient(color1:UIColor, color2:UIColor, view:UIView) -> CAGradientLayer{
        let grad = CAGradientLayer()
        grad.frame = view.bounds
        grad.frame.size.width = view.frame.width
        grad.frame.size.height = view.frame.height
        grad.colors = [color1.cgColor, color2.cgColor]
        grad.startPoint = CGPoint(x:0.0, y:0)
        grad.endPoint = CGPoint(x: 0.0, y: 1.0)
        return grad
    }
    func setData(keyData:String, data:String){
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: keyData)
    }
    func setGradientMainView(view:UIView, gradient:CAGradientLayer){
        gradient.frame = view.bounds
        gradient.frame.size.width = view.frame.width
        gradient.frame.size.height = view.frame.height
        view.layer.insertSublayer(gradient, at: 0)
    }
    func setupNavigationController(navigationController: UINavigationController){
        navigationController.navigationBar.backgroundColor = UIColor.clear
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .blackTranslucent
        navigationController.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon-angle-left")
        navigationController.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon-angle-left")
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
        navigationController.navigationBar.barTintColor = UIColor.white
    }
    func addTopBorder(color: UIColor, view:UIView, width:CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: width)
        view.addSubview(border)
    }
    func addBottomBorder(color: UIColor, view:UIView, width:CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: view.frame.size.height - width, width: view.frame.size.width, height: width)
        view.addSubview(border)
    }
    func rotateImage(loadImage: UIImageView) {
        UIView.animate(withDuration: 1, animations: {
            loadImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            loadImage.transform = CGAffineTransform.identity
        }) { (completed) -> Void in
            self.rotateImage(loadImage: loadImage)
        }
    }
    func loadImage(href:String) -> UIImage{
        let session  = URLSession.shared
        let url:URL = URL(string: href)!
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            if data != nil{
                let image = UIImage(data: data!)
                if image != nil{
                    DispatchQueue.main.async(execute: {

                        return image
                    })
                }
            }
            
        })
        task.resume()
        return UIImage()
    }
    func getTimeOfLesson(numb:Int) -> String{
        if numb == 1{
            return "8:00-9:35"
        }
        else if numb == 2{
            return "9:45-11:20"
        }
        else if numb == 3{
            return "12:10-13:45"
        }
        else if numb == 4{
            return "13:55-15:30"
        }
        else if numb == 5{
            return "16:10-17:45"
        }
        else if numb == 6{
            return "17:55-19:30"
        }
        return "20:05-21:40"
    }
    func getTimeOfLessonShort(numb:Int) -> String{
        if numb == 1{
            return "8:00"
        }
        else if numb == 2{
            return "9:45"
        }
        else if numb == 3{
            return "12:10"
        }
        else if numb == 4{
            return "13:55"
        }
        else if numb == 5{
            return "16:10"
        }
        else if numb == 6{
            return "17:55"
        }
        return "20:05"
    }
    func getTimeOfLessonUpper(numb:Int) -> String{
        if numb == 1{
            return "9:35"
        }
        else if numb == 2{
            return "11:20"
        }
        else if numb == 3{
            return "13:45"
        }
        else if numb == 4{
            return "15:30"
        }
        else if numb == 5{
            return "17:45"
        }
        else if numb == 6{
            return "19:30"
        }
        return "21:40"
    }
    func getTimeOfLessonLower(numb:Int) -> String{
        if numb == 1{
            return "8:00"
        }
        else if numb == 2{
            return "9:45"
        }
        else if numb == 3{
            return "12:10"
        }
        else if numb == 4{
            return "13:55"
        }
        else if numb == 5{
            return "16:10"
        }
        else if numb == 6{
            return "17:55"
        }
        return "20:05"
    }
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    func presentModalView(view:UIViewController, controller:UIViewController, YOffset:Int){
        detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: view, to: controller)
        controller.modalPresentationStyle = .custom
        detailsTransitioningDelegate.presentedYOffset = CGFloat(YOffset)
        controller.transitioningDelegate = detailsTransitioningDelegate
        view.present(controller, animated: true, completion: nil)
    }
    func getImageUrl(stringURLImage:String, imageView: UIImageView){
        let url:URL = URL(string: stringURLImage)!
        let session  = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            if data != nil{
                let image = UIImage(data: data!)
                if image != nil{
                    DispatchQueue.main.async(execute: {
                        imageView.image = image
                    })
                }
            }
        })
        task.resume()
    }
    func presentViewNavigationController(vc:UIViewController, navigationController:UINavigationController){
        vc.modalPresentationStyle = UIModalPresentationStyle.currentContext
        vc.modalTransitionStyle   = .flipHorizontal
        navigationController.pushViewController(vc, animated: true)
    }
}

extension UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
