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
        let htmlPath = Bundle.main.path(forResource: "dingding_index.html", ofType: nil) ?? ""
        let htmlPathUrl = URL(fileURLWithPath: htmlPath)
        
        let fontPath = Bundle.main.path(forResource: "dingding_iconfont.ttf", ofType: nil) ?? ""
        let fontPathUrl = URL(fileURLWithPath: fontPath)
        
        let group = IFGroupItem(title: "钉钉", fontName: "dingding_iconfont", fontPath: fontPathUrl, htmlPath: htmlPathUrl)
        group.register()
        return [group]
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
}
