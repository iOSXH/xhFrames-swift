//
//  BaseCollectionViewCell.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/3/1.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, BaseCollectionCellProtocol {
    // MARK: UITableViewCell协议
    weak var baseDelegate: BaseCellDelegate?
    
    var indexPath: IndexPath?
    
    var colorViews: [UIView] = []
    
    func initSubViews() {
        theme_backgroundColor = ThemeColorKey.Global_BGC.rawValue
        contentView.theme_backgroundColor = ThemeColorKey.Global_BGC.rawValue
        
        selectedBackgroundView = UIView();
        selectedBackgroundView?.theme_backgroundColor = ThemeColorKey.Global_GrayC.rawValue
        
    }
    
    func updateViews(_ model: Any?) {
        
    }
    
    static func cellReuseIdentifier() -> String {
        let cellId = "ID\(NSStringFromClass(self.self))"
        return cellId
    }
    
    static func collectionInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    static func itemSize() -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    static func itemMinLineSpacing() -> CGFloat {
        return 10
    }
    
    static func itemMinInterSpacing() -> CGFloat {
        return 10
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubViews()
    }
}
