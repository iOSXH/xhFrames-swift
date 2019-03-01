//
//  BaseListViewController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/26.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit
import MJRefresh
import StatefulViewController

class BaseListViewController: BaseViewController, StatefulViewController, BaseListProtocol, BaseCellDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    // MARK: - 公有变量/方法Public
    /// 内边距
    var contentInsets: UIEdgeInsets = UIEdgeInsets.zero
    var contentListView: UIScrollView?
    
    var tableViewStyle: UITableView.Style = UITableView.Style.plain
    var tableView: UITableView?

    var collectionLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var collectionView:UICollectionView?
    
    // MARK: - 私有变量/方法Private
    private var refreshed:Bool = false
    // MARK: - 协议BaseListProtocol
    var listType: ListType = .none
    
    var cellClass: BaseCellProtocol.Type = BaseTableViewCell.self
    
    var headerType: HeaderRefreshType = .normal
    
    var footerType: FooterRefreshType = .normal
    
    var offset: String?
    
    var limit: Int = 20
    
    var datas: [Any] = []
    
    var error: Error?
    
    var refreshing:Bool = false
    
    var removeAllDatas: Bool = false
    
    var appearRefresh: Bool = false
    
    func setupRefresh() {
        if headerType == .normal {
            let refreshHeader: BaseRefreshHeader = BaseRefreshHeader {
                self.headerRefresh()
            }
            contentListView?.mj_header = refreshHeader
        }
        
        if footerType == .normal {
            
            let refreshFooter:MJRefreshBackNormalFooter = MJRefreshBackNormalFooter {
                self.refreshData()
            }
            refreshFooter.setTitle("暂无更多数据了", for: .noMoreData)
//            refreshFooter.isAutomaticallyChangeAlpha = true
            contentListView?.mj_footer = refreshFooter
        }

    }
    
    func startRefresh(_ animated: Bool) {
        
        if animated && (contentListView?.mj_header) != nil {
            contentListView?.mj_header.beginRefreshing()
        }else{
           headerRefresh()
        }
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
    
    
    @objc private func refreshData() {
        refreshed = true
        refreshing = true
        error = nil
        reloadEmptyData()
        refresh(offset: offset, limit: limit, success: {(rDatas:[Any]?, rOffset:String?) in
            if self.offset == nil || self.removeAllDatas == true {
                self.datas.removeAll()
                self.removeAllDatas = false
            }
            if rDatas != nil && rDatas!.count > 0 {
                self.datas.append(contentsOf: rDatas!)
            }
            
            let hasMore: Bool = self.offset != nil && self.offset != "-1"
            if hasMore {
                //nextId = nextId    // Skipping redundant initializing to itself
            }
            self.endRefresh(nil, hasMore)
            
        }) {(rError:Error?, rData:Any?) in
            self.endRefresh(rError, true)
        }
    }
    
    private func endRefresh(_ rError:Error?, _ more:Bool) {
        error = rError
        refreshing = false
        reloadEmptyData()
        
        if listType == .table {
            tableView?.reloadData()
        }else if listType == .collection {
            collectionView?.reloadData()
        }
        
        if headerType == .normal {
            if contentListView?.mj_header.isRefreshing ?? false {
                contentListView?.mj_header.endRefreshing()
            }
        }
        
        if footerType == .normal {
            if datas.count == 0 || more == false {
                contentListView?.mj_footer.endRefreshingWithNoMoreData()
            }else {
                contentListView?.mj_footer.endRefreshing()
            }
        }
        
        refreshDidEnd()
    }
    
    
    private func reloadEmptyData() {
        if refreshing {
            if (lastState == .Loading || datas.count > 0 ) { return }
            startLoading()
        }else {
            endLoading(animated: true, error: error, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSubViews()
        
        loadingView = LoadingView(frame: view.frame)
        emptyView = EmptyView(frame: view.frame)
        let failureView = ErrorView(frame: view.frame)
        failureView.tapGestureRecognizer.addTarget(self, action: #selector(refreshData))
        errorView = failureView
        
        setupInitialViewState()
        
    }
    
    func initSubViews() {
        if listType == .table {
            tableView = UITableView(frame: view.bounds, style: tableViewStyle)
            tableView?.backgroundColor = UIColor.clear
            tableView?.tableFooterView = UIView()
//            tableView?.separatorStyle = .singleLine
            tableView?.theme_separatorColor = ThemeColorKey.Global_GrayC.rawValue
            tableView?.delegate = self
            tableView?.dataSource = self
            view.addSubview(tableView!)
            tableView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview().inset(contentInsets)
            })
            
            tableView?.register(cellClass, forCellReuseIdentifier: cellClass.cellReuseIdentifier())
            let cellHeight = (cellClass as! BaseTableCellProtocol.Type).cellHeight()
            if cellHeight > 0 {
                tableView?.rowHeight = cellHeight
            }
            let estimatedCellHeight = (cellClass as! BaseTableCellProtocol.Type).estimatedCellHeight()
            if estimatedCellHeight > 0 {
                tableView?.estimatedRowHeight = estimatedCellHeight
            }
            
            contentListView = tableView
        }else if listType == .collection {
            let a = cellClass is BaseCollectionCellProtocol.Type
            if !a {
                cellClass = BaseCollectionViewCell.self
            }
            
            collectionLayout.sectionInset = (cellClass as! BaseCollectionCellProtocol.Type).collectionInsets()
            collectionLayout.itemSize = (cellClass as! BaseCollectionCellProtocol.Type).itemSize()
            collectionLayout.minimumLineSpacing = (cellClass as! BaseCollectionCellProtocol.Type).itemMinLineSpacing()
            collectionLayout.minimumInteritemSpacing = (cellClass as! BaseCollectionCellProtocol.Type).itemMinInterSpacing()
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionLayout)
            collectionView?.delegate = self
            collectionView?.dataSource = self
            collectionView?.backgroundColor = UIColor.clear
            collectionView?.alwaysBounceVertical = true
            view.addSubview(collectionView!)
            collectionView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview().inset(contentInsets)
            })
            
            collectionView?.register(cellClass, forCellWithReuseIdentifier: cellClass.cellReuseIdentifier())
            
            
            contentListView = collectionView
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
        
        let cell:BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellClass.cellReuseIdentifier()) as! BaseTableViewCell
        cell.indexPath = indexPath
        cell.baseDelegate = self
        cell.updateViews(datas[indexPath.row])
        
        return cell
    }
    // MARK: - 代理UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - 代理UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BaseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClass.cellReuseIdentifier(), for: indexPath) as! BaseCollectionViewCell
        cell.indexPath = indexPath
        cell.baseDelegate = self
        cell.updateViews(datas[indexPath.row])
        
        return cell
    }
    
    // MARK: - 代理UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension BaseListViewController {
    
    func hasContent() -> Bool {
        if !refreshed {
            return true;
        }
        return datas.count > 0
    }
    
    func handleErrorWhenContentAvailable(_ error: Error) {
        //TODO: 错误提示 - 需要修改
        let alertController = UIAlertController(title: "Ooops", message: "Something went wrong.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
