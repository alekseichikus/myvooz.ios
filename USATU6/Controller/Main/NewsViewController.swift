//
//  NewsViewController.swift
//  USATU6
//
//  Created by aleksei on 07.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var WebView: WKWebView!
    @IBOutlet weak var LoadView: UIView!
    @IBOutlet weak var loadImage: UIImageView!
    @IBOutlet weak var IETitleImageView: UIImageView!
    @IBOutlet weak var InternetErrorView: UIView!
    
    var news_data = news()
    var customData = CustomData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CheckInternet.isConnectedToNetwork(){
            let url = URL(string: "https://createtogether.ru/lesson?type=news&id=" + String(news_data.id))
            let request = URLRequest(url: url!)
            WebView.load(request)
            WebView.navigationDelegate = self
            
            InternetErrorView.isHidden = true
            
            customData.rotateImage(loadImage: loadImage)
        }
        else{
            InternetErrorView.isHidden = false
        }
        setup()
    }
    
    func setup(){
        let navView = UIView()
        let label = UILabel()
        let iimage = UIImageView()

        label.text = news_data.name
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        
        iimage.layer.cornerRadius = label.frame.size.height/2
        iimage.layer.backgroundColor = UIColor(displayP3Red: 245/255, green: 243/255, blue: 245/255, alpha: 1).cgColor
        iimage.layer.masksToBounds = true
        iimage.frame = CGRect(x: label.frame.origin.x-label.frame.size.height - 5, y: label.frame.origin.y, width: 20, height: label.frame.size.height)
        iimage.contentMode = UIView.ContentMode.scaleAspectFit
        
        navView.addSubview(label)
        navView.addSubview(iimage)
        
        let session  = URLSession.shared
        let url:URL = URL(string: news_data.logo_image)!
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            if data != nil{
                let image = UIImage(data: data!)
                if image != nil{
                    DispatchQueue.main.async(execute: {
                        iimage.image = image
                    })
                }
            }
        })
        task.resume()
        
        self.navigationItem.titleView = navView
        
        customData.changeImageColor(image: IETitleImageView, color: UIColor(displayP3Red: 143/255, green: 152/255, blue: 168/255, alpha: 1))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 146/255, green: 155/255, blue: 166/255, alpha: 1)
        customData.addTopBorder(color: UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1), view: WebView, width: 1)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func transitionPublicButton(_ sender: Any) {
        if let indexPath = (sender as AnyObject).tag {
            if let url = NSURL(string: news_data.link_public){
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    @IBAction func shareButtonClick(_ sender: Any) {
        share(message: news_data.title, link: news_data.link)
    }
    
    func share(message: String, link: String) {
        if let link = NSURL(string: link) {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
