//
//  TestListViewController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/27.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class TestListViewController: BaseListViewController {
    

    override func viewDidLoad() {
        listType = .table
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "列表"
        
        setupRefresh()
        
        startRefresh(true)
    }
    
    override func refresh(offset: String?, limit: Int, success: successBlock?, failure: failureBlock?) {
        let datas:[String] = ["asfasfasdf"]
        
        if success != nil {
            success!(datas, nil)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        
        let test2:TestListViewController = TestListViewController()
        test2.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(test2, animated: true)
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
