//
//  IFIntroductionViewController.swift
//  IconFont
//
//  Created by qiang yu on 2019/3/22.
//  Copyright © 2019 yuqiang. All rights reserved.
//

import UIKit

class IFIntroductionViewController: IFBaseViewController {
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        
        return scroll
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "简介"
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.width.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
