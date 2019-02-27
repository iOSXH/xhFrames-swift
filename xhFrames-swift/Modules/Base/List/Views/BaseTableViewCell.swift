//
//  BaseTableViewCell.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/27.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, BaseTableCellProtocol {
    
    // MARK: UITableViewCell协议
    weak var baseDelegate: BaseCellDelegate?
    
    var indexPath: IndexPath?
    
    var colorViews: [UIView] = []
    
    func initSubViews() {
        textLabel?.theme_textColor = ThemeColorKey.Global_TXTC.rawValue
    }
    
    func updateViews(_ model: Any?) {
        textLabel?.text = kGetString(model)
    }
    
    static func cellReuseIdentifier() -> String {
        let cellId = "ID\(NSStringFromClass(self.self))"
        return cellId
    }
    
    static func cellHeight() -> CGFloat {
        return 44.0
    }
    
    static func estimatedCellHeight() -> CGFloat {
        return 0
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubViews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    deinit {
        log.info("\(NSStringFromClass(type(of: self).self)) 已销毁")
    }
}
