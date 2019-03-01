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
        addRightBarItem(title: "test1", imageName: "")
        
        setupRefresh()

        
        startRefresh(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func rightItemDidClicked(sender: Any) {
        let test2:TestListViewController = TestListViewController()
        test2.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(test2, animated: true)
    }
    
    override func refresh(offset: String?, limit: Int, success: successBlock?, failure: failureBlock?) {
        

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            
            let a = Int.random(between: 0, and: 1)
            
            if a == 0 {
                if failure != nil {
                    failure!(NSError(), nil)
                }
            }else {
                if success != nil {
                    let datas:[String] = ["asfasfasdf"]
                    success!(datas, nil)
                }
            }
        })
        
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
