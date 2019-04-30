//
//  IFEditHomeViewController.swift
//  IconFont
//
//  Created by sungrow on 2019/3/19.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFEditHomeViewController: IFBaseViewController {
    
    fileprivate lazy var dataSource: [IFGroupItem] = {
        return IFGlobalManager.shared.items
    }()
    
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.delaysContentTouches = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(IFEditHomeCell.self, forCellReuseIdentifier: IFEditHomeCell.description())
        table.register(IFEditHomeHeaderView.self, forHeaderFooterViewReuseIdentifier: IFEditHomeHeaderView.description())
        table.rowHeight = 120 + 16
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "编辑"
        navigationController?.setNavigationBarHidden(true, animated: true)
        registerForPreviewing(with: self, sourceView: tableView)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension IFEditHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IFEditHomeCell.description()) as! IFEditHomeCell
        cell.item = self.dataSource[indexPath.section].items[indexPath.item]
        return cell
    }
}

extension IFEditHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let haeder = tableView.dequeueReusableHeaderFooterView(withIdentifier: IFEditHomeHeaderView.description()) as! IFEditHomeHeaderView
        haeder.titleLabel.text = dataSource[section].title
        return haeder
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! IFEditHomeCell
        cell.freezeAnimations()
        let detailVC = IFEditDetailViewController(item: dataSource[indexPath.section].items[indexPath.row])
        present(detailVC, animated: true) {
            cell.unfreezeAnimations()
        }
    }
}

extension IFEditHomeViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return nil
        }
        let cell = tableView.cellForRow(at: indexPath)
        previewingContext.sourceRect = cell?.frame ?? CGRect.zero
        let detail = IFEditDetailViewController(item: dataSource[indexPath.section].items[indexPath.row])
        return detail
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }
}
