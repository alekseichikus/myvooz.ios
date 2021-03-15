//
//  IGRoundedView.swift
//  IGRoundedView
//
//  Created by Ranjith Kumar on 12/5/17.
//  Copyright © 2017 Dash. All rights reserved.
//

import Foundation
import UIKit

//@note:Recommended Size: CGSize(width:70,height:70)
struct Attributes {

    let size = CGSize(width:210,height:130)
}

class IGRoundedView: UIView {
    private var attributes:Attributes = Attributes()
    var customData = CustomData()
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        return iv
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        addSubview(imageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x:0,y:0,width:(attributes.size.width),height:attributes.size.height)
        imageView.layer.insertSublayer(customData.getGradient(color1: UIColor.clear, color2: UIColor.black.withAlphaComponent(0.3), view: imageView), at: 2)
        imageView.layer.cornerRadius = 12
    }
}

extension IGRoundedView {
    func enableBorder(enabled: Bool = true) {
        if enabled {
            imageView.layer.insertSublayer(customData.getGradient(color1: UIColor.clear, color2: UIColor.black.withAlphaComponent(0.3), view: imageView), at: 2)
        }else {
            imageView.layer.insertSublayer(customData.getGradient(color1: UIColor.clear, color2: UIColor.black.withAlphaComponent(0.3), view: imageView), at: 2)
        }
    }
}
