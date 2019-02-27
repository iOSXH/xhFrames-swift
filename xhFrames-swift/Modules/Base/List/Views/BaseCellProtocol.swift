//
//  BaseCellProtocol.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/27.
//  Copyright © 2019 xianghui. All rights reserved.
//

import Foundation
import UIKit

typealias completeBlock = (_ data:Any?, _ error:Error?) -> Void

protocol BaseCellDelegate: NSObjectProtocol {
//    optional
    func baseCellAction(_ cell: BaseCellProtocol?, _ sender: Any?, type: Int, data: Any?)
    
    func baseCellAction(_ cell: BaseCellProtocol?, _ sender: Any?, type: Int, data: Any?, complete: completeBlock)
    
}

protocol BaseCellProtocol: NSObjectProtocol {
    
    /// 代理
    var baseDelegate: BaseCellDelegate? {get set}
    /// 位置信息
    var indexPath: IndexPath? {get set}
    /// cell高亮或点击状态时需要保持背景颜色的views
    var colorViews: [UIView] {get set}
    
    /// 初始化子视图
    func initSubViews()

    /// 更新界面 数据显示
    ///
    /// - Parameter model: 数据对象
    func updateViews(_ model: Any?)

    
    /// cell重用标识
    ///
    /// - Returns: 标识
    static func cellReuseIdentifier() -> String


}

extension BaseTableViewCell{
    
}

// MARK: UITableViewCell协议
protocol BaseTableCellProtocol: BaseCellProtocol {
    /// cell高度
    ///
    /// - Returns: 高度
    static func cellHeight() -> CGFloat
    
    /// cell动态预估高度
    ///
    /// - Returns: 高度
    static func estimatedCellHeight() -> CGFloat
}

// MARK: UITableViewHeaderFooterView协议
protocol BaseTableHeaderFooterProtocol: BaseCellProtocol{
    /// 头部/尾部高度
    ///
    /// - Returns: 高度
    static func headerFooterHeight() -> CGFloat
}

// MARK: UICollectionViewCell协议
protocol BaseCollectionCellProtocol: BaseCellProtocol{
    /// 内边距
    ///
    /// - Returns: 高度
    static func collectionInsets() -> UIEdgeInsets
    
    /// 行间距
    ///
    /// - Returns: 高度
    static func itemMinLineSpacing() -> CGFloat
    
    /// 列间距
    ///
    /// - Returns: 高度
    static func itemMinInterSpacing() -> CGFloat
    
    /// 大小
    ///
    /// - Returns: size
    static func itemSize() -> CGSize
}
