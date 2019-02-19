//
//  BaseTabBtn.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class BaseTabBtn: UIButton {
    
    let imageLab:UILabel = UILabel()
    let titleLab:UILabel = UILabel()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageLab.font = UIFont(name: kFont_Icon, size: 25)
        self.addSubview(imageLab)
        imageLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        titleLab.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
    }
    
    func setData(config: Dictionary<String, String>) -> Void {
        let imageText:String? = config["imageText"]
        let titleText:String? = config["titleText"]
        
        imageLab.text = imageText
        titleLab.text = titleText
    }
    
    override var isSelected: Bool{
        willSet {
            
        }
        
        didSet {
            if isSelected {
                imageLab.theme_textColor = ThememColorKey.Global_TXTC.rawValue
                titleLab.theme_textColor = ThememColorKey.Global_TXTC.rawValue
            }else{
                imageLab.theme_textColor = ThememColorKey.Global_GrayC.rawValue
                titleLab.theme_textColor = ThememColorKey.Global_GrayC.rawValue
            }
        }
        
    }
}
