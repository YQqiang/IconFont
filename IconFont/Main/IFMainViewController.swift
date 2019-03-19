//
//  IFMainViewController.swift
//  IconFont
//
//  Created by sungrow on 2019/3/18.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFMainViewController: IFBaseViewController {
    
    fileprivate lazy var overviewVC: IFOverviewViewController = {
        let vc = IFOverviewViewController()
        return vc
    }()
    
    fileprivate lazy var editVC: IFEditViewController = {
        let vc = IFEditViewController()
        return vc
    }()
    
    fileprivate lazy var listVC: IFListViewController = {
        let vc = IFListViewController()
        return vc
    }()

    fileprivate lazy var tabBar: IFMainTabBar = {
        let tab = IFMainTabBar()
        let image1 = IconFontType.nodeManage.image(background: UIColor.clear, tint: UIColor.red, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        let item1 = UITabBarItem(title: "预览", image: image1, selectedImage: nil)
        
        let image2 = IconFontType.appManage.image(background: UIColor.clear, tint: UIColor.red, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        let item2 = UITabBarItem(title: "列表", image: image2, selectedImage: nil)
        
        let image3 = IconFontType.editHexagon.image(background: UIColor.clear, tint: UIColor.red, size: CGSize(width: 24, height: 24), insets: UIEdgeInsets.zero, orientation: .up)
        let item3 = UITabBarItem(title: "编辑", image: image3, selectedImage: nil)
        tab.items = [item1, item2, item3]
        tab.didSelectItem = { [weak self] (tabB, selectItem) in
            let index = tabB.items?.index {$0 == selectItem}
            guard let idx = index else {
                return
            }
            guard let curNavVC = self?.pageViewController.viewControllers?.first as? IFBaseNavigationController else {
                return
            }
            guard let curIdx = self?.index(for: curNavVC) else {
                return
            }
            self?.handleShowViewController(index: idx, forward: idx > curIdx)
        }
        return tab
    }()
    
    fileprivate lazy var dataSource: [IFBaseNavigationController] = {
        var vcs = [IFBaseNavigationController]()
        vcs.append(IFBaseNavigationController(rootViewController: overviewVC))
        vcs.append(IFBaseNavigationController(rootViewController: listVC))
        vcs.append(IFBaseNavigationController(rootViewController: editVC))
        return vcs
    }()
    
    fileprivate lazy var pageViewController: UIPageViewController = {
        let options = [UIPageViewController.OptionsKey: Any]()
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        pageVC.dataSource = self
        pageVC.delegate = self
        return pageVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-22)
        }
        tabBar.tabBar.selectedItem = tabBar.tabBar.items?.first
        handleShowViewController(index: 0, forward: true)
    }
}

extension IFMainViewController {
    
    fileprivate func handleSelectItem(index: Int) {
        if index >= 0, index < tabBar.items?.count ?? 0 {
            tabBar.selectItem = tabBar.items?[index]
        }
    }
    
    fileprivate func handleShowViewController(index: Int, forward: Bool) {
        guard let navVC = navVc(for: index) else {
            return
        }
        let direction: UIPageViewController.NavigationDirection = forward ? .forward : .reverse
        pageViewController.setViewControllers([navVC], direction: direction, animated: true, completion: nil)
    }
    
    fileprivate func index(for navVc: IFBaseNavigationController) -> Int? {
        if dataSource.contains(navVc) {
            return dataSource.index {$0 == navVc}
        }
        return nil
    }
    
    fileprivate func navVc(for index: Int) -> IFBaseNavigationController? {
        if index >= 0, index < dataSource.count {
            return dataSource[index]
        }
        return nil
    }
}

extension IFMainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let navVC = viewController as? IFBaseNavigationController else {
            return nil
        }
        guard var index = index(for: navVC) else {
            return nil
        }
        if index == (dataSource.count - 1) {
            return navVc(for: 0)
        }
        index += 1
        return navVc(for: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let navVC = viewController as? IFBaseNavigationController else {
            return nil
        }
        guard var index = index(for: navVC) else {
            return nil
        }
        if index == 0 {
            return navVc(for: dataSource.count - 1)
        }
        index -= 1
        return navVc(for: index)
    }
}

extension IFMainViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let curNavVC = pageViewController.viewControllers?.first as? IFBaseNavigationController else {
            return
        }
        guard let curIdx = index(for: curNavVC) else {
            return
        }
        handleSelectItem(index: curIdx)
    }
}
