//
//  IFOverviewViewController.swift
//  IconFont
//
//  Created by sungrow on 2019/3/19.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFOverviewViewController: IFBaseViewController {
    
    fileprivate lazy var dataSource: [IFGroupItem] = {
        
        var datas: [(html: String, file: String, icon: String, title: String)] = []
//        datas.append(("weather_index.html",
//                      "weather_iconfont.ttf",
//                      "weather_iconfont",
//                      "天气"))
        datas.append(("beautyMakeup_index.html",
                      "beautyMakeup_iconfont.ttf",
                      "beauty_makeup_iconfont",
                      "美妆"))
        datas.append(("sportMovement_index.html",
                     "sportMovement_iconfont.ttf",
                     "sports_movement_iconfont",
                     "体育运动"))
        datas.append(("sportProject_index.html",
                     "sportProject_iconfont.ttf",
                     "sport_project_iconfont",
                     "体育项目"))
        datas.append(("dingding_index.html",
                     "dingding_iconfont.ttf",
                     "dingding_iconfont",
                     "钉钉"))
        var groups: [IFGroupItem] = []
        for data in datas {
            let htmlPath = Bundle.main.path(forResource: data.html, ofType: nil) ?? ""
            let htmlPathUrl = URL(fileURLWithPath: htmlPath)
            
            let fontPath = Bundle.main.path(forResource: data.file, ofType: nil) ?? ""
            let fontPathUrl = URL(fileURLWithPath: fontPath)
            
            let group = IFGroupItem(title: data.title, fontName: data.icon, fontPath: fontPathUrl, htmlPath: htmlPathUrl)
            group.register()
            groups.append(group)
        }
        return groups
    }()

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 48, height: 48)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: 0, height: 44)
        layout.sectionHeadersPinToVisibleBounds = true
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.IFBg
        collection.register(IFOverviewCell.self, forCellWithReuseIdentifier: IFOverviewCell.description())
        collection.register(IFOverviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IFOverviewHeaderView.description())
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 20 + 44, right: 16)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "预览"
        navigationController?.setNavigationBarHidden(true, animated: true)
        registerForPreviewing(with: self, sourceView: collectionView)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension IFOverviewViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IFOverviewCell.description(), for: indexPath) as! IFOverviewCell
        cell.item = self.dataSource[indexPath.section].items[indexPath.item]
        return cell
    }
}

extension IFOverviewViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IFOverviewHeaderView.description(), for: indexPath) as! IFOverviewHeaderView
            header.titleLabel.text = dataSource[indexPath.section].title
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = IFOverviewDetailController()
        detail.item = dataSource[indexPath.section].items[indexPath.row]
        present(detail, animated: true, completion: nil)
    }
}

extension IFOverviewViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView.indexPathForItem(at: location) else {
            return nil
        }
        let cell = collectionView.cellForItem(at: indexPath)
        previewingContext.sourceRect = cell?.frame ?? CGRect.zero
        let detail = IFOverviewDetailController(isPeek: true)
        detail.item = dataSource[indexPath.section].items[indexPath.row]
        return detail
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }
}
