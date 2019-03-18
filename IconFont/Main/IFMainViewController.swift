//
//  IFMainViewController.swift
//  IconFont
//
//  Created by sungrow on 2019/3/18.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFMainViewController: IFBaseViewController {

    fileprivate lazy var tabBar: IFMainTabBar = {
        let tab = IFMainTabBar()
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-22)
        }
        
        tabBar.tabBar.selectedItem = tabBar.tabBar.items?.first
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
