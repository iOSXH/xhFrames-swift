//
//  BaseListViewController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/26.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class BaseListViewController: BaseViewController, BaseListProtocol, BaseCellDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - 公有变量/方法Public
    /// 内边距
    var contentInsets: UIEdgeInsets = UIEdgeInsets.zero
    var contentListView: UIScrollView?
    
    var tableViewStyle: UITableView.Style = UITableView.Style.plain
    
    var tableView: UITableView?

    
    // MARK: - 私有变量/方法Private
    
    // MARK: - 协议BaseListProtocol
    var listType: ListType = .none
    
    var cellClass: AnyClass = BaseTableViewCell.self
    
    var headerType: HeaderRefreshType = .none
    
    var footerType: FooterRefreshType = .none
    
    var offset: String?
    
    var limit: Int = 20
    
    var datas: [Any] = []
    
    var error: Error?
    
    var refreshing:Bool = false
    
    var removeAllDatas: Bool = false
    
    var appearRefresh: Bool = false
    
    func setupRefresh() {
        
    }
    
    func startRefresh(_ animated: Bool) {
        headerRefresh()
    }
    
    func startRefreshAll() {
        
    }
    
    func headerRefresh() {
        offset = nil
        refreshData()
    }
    
    func refresh(offset: String?, limit: Int, success: successBlock?, failure: failureBlock?) {
        
    }
    
    func refreshDidEnd() {
        
    }
    
    
    private func refreshData() {
        refreshing = true
        error = nil
        reloadEmptyData()
        weak var weakSelf = self
        refresh(offset: offset, limit: limit, success: {(rDatas:[Any]?, rOffset:String?) in
            if weakSelf?.offset != nil || weakSelf?.removeAllDatas == true {
                weakSelf?.datas.removeAll()
                weakSelf?.removeAllDatas = false
            }
            if rDatas != nil && rDatas!.count > 0 {
                weakSelf?.datas.append(contentsOf: rDatas!)
            }
            
            let hasMore: Bool = weakSelf?.offset != nil && weakSelf?.offset != "-1"
            if hasMore {
                //nextId = nextId    // Skipping redundant initializing to itself
            }
//            weakSelf?.endRefresh(nil, hasMore)
            if weakSelf?.listType == .table {
                weakSelf?.tableView?.reloadData()
            }
        }) {(rError:Error?, rData:Any?) in
//            weakSelf?.endRefresh(rError, true)
        }
    }
    
    private func endRefresh(_ rError:Error?, _ more:Bool) {
        error = rError
        refreshing = false
        reloadEmptyData()
        
        if listType == .table {
            tableView?.reloadData()
        }
        
        refreshDidEnd()
    }
    
    
    private func reloadEmptyData() {
        
    }
    
    
    deinit {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSubViews()
    }
    
    func initSubViews() {
        if listType == .table {
            tableView = UITableView(frame: view.bounds, style: tableViewStyle)
            tableView?.backgroundColor = UIColor.clear
            tableView?.tableFooterView = UIView()
            tableView?.separatorStyle = .none
            tableView?.delegate = self
            tableView?.dataSource = self
            view.addSubview(tableView!)
            weak var weakSelf = self
            tableView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview().inset(weakSelf?.contentInsets ?? UIEdgeInsets.zero)
            })
            
            tableView?.register(cellClass, forCellReuseIdentifier: (cellClass as! BaseCellProtocol.Type).cellReuseIdentifier())
            let cellHeight = (cellClass as! BaseTableCellProtocol.Type).cellHeight()
            if cellHeight > 0 {
                tableView?.rowHeight = cellHeight
            }
            let estimatedCellHeight = (cellClass as! BaseTableCellProtocol.Type).estimatedCellHeight()
            if estimatedCellHeight > 0 {
                tableView?.estimatedRowHeight = estimatedCellHeight
            }
            
            contentListView = tableView
        }
    }
    
    // MARK:- 代理BaseCellDelegate
    func baseCellAction(_ cell: BaseCellProtocol?, _ sender: Any?, type: Int, data: Any?) {
        
    }
    func baseCellAction(_ cell: BaseCellProtocol?, _ sender: Any?, type: Int, data: Any?, complete: (Any?, Error?) -> Void) {
        
    }
    
    
    // MARK: - 代理UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: (cellClass as! BaseCellProtocol.Type).cellReuseIdentifier()) as! BaseTableViewCell
        cell.indexPath = indexPath
        cell.baseDelegate = self
        cell.updateViews(datas[indexPath.row])
        
        return cell
    }
    // MARK: - 代理UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - 代理
    // MARK: - 代理
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
