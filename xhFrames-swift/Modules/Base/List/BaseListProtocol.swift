//
//  BaseListProtocol.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/26.
//  Copyright © 2019 xianghui. All rights reserved.
//

import Foundation

/// 下拉刷新方式
///
/// - none: 无
/// - normal: 默认下拉刷新方式
enum HeaderRefreshType : Int {
    case none = 0, normal
}

/// 上拉刷新方式
///
/// - none: 无
/// - normal: 默认上拉刷新方式
enum FooterRefreshType : Int {
    case none = 0, normal
}

/// 列表类型
///
/// - none: 无
/// - table: tableView类型
/// - collection: collectionView类型
enum ListType : Int {
    case none = 0, table, collection
}

/// 成功回调
typealias successBlock = (_ datas: [Any]?, _ offset: String?) -> Void
/// 失败回调
typealias failureBlock = (_ error: Error?, _ data: Any?) -> Void

/// 列表协议
protocol BaseListProtocol: NSObjectProtocol {
    
    /// 列表类型
    var listType:ListType {get set}
    /// cell类
    var cellClass:BaseCellProtocol.Type {get set}
    /// 下拉刷新类型
    var headerType:HeaderRefreshType {get set}
    /// 上拉刷新类型
    var footerType:FooterRefreshType {get set}
    
    /// 分页偏移
    var offset:String? {get set}
    /// 分页大小
    var limit:Int {get set}
    /// 列表数据
    var datas:[Any] {get set}
    /// 错误信息
    var error:Error? {get set}
    /// 是否正在刷新
    var refreshing:Bool {get set}
    
    /// 刷新后是否移除之前数据
    var removeAllDatas:Bool {get set}
    /// 页面出现时是否自动刷新
    var appearRefresh:Bool {get set}
    

    /// 创建刷新组件
    func setupRefresh()
    
    /// 开始刷新
    ///
    /// - Parameter animated: 是否有动画
    func startRefresh(_ animated:Bool)
    
    ///  刷新当前页面所有数据
    func startRefreshAll()
    
    ///  刷新数据
    func headerRefresh()
    
    /// 异步刷新
    ///
    /// - Parameters:
    ///   - offset: 分页偏移
    ///   - limit: 分页大小
    ///   - success: 成功回调
    ///   - failure: 失败回调
    func refresh(offset:String?, limit:Int, success:successBlock?, failure:failureBlock?)
    
    ///  刷新结束回调
    func refreshDidEnd()
}
