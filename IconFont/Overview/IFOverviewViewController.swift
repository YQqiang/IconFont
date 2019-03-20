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
        let htmlPath = Bundle.main.path(forResource: "index_dingding.html", ofType: nil) ?? ""
        let htmlPathUrl = URL(fileURLWithPath: htmlPath)
        
        let fontPath = Bundle.main.path(forResource: "iconfont_dingding.ttf", ofType: nil) ?? ""
        let fontPathUrl = URL(fileURLWithPath: fontPath)
        
        let group = IFGroupItem(fontName: "dingding_iconfont", fontPath: fontPathUrl, htmlPath: htmlPathUrl)
        group.register()
        return [group]
    }()

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 48, height: 48)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.IFBg
        collection.register(IFOverviewCell.self, forCellWithReuseIdentifier: IFOverviewCell.description())
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "预览"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
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
