//
//  MSBaseViewController.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

class MSBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.forceToSetBackItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.setupNavigationBarBackgroundImage()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    func forceToSetBackItem() {
        
        let leftBarButton = UIButton(type: UIButton.ButtonType.custom)
        leftBarButton.setImage(UIImage(named: "invitation_back"), for: UIControl.State.normal)
        leftBarButton.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
        leftBarButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        leftBarButton.frame = CGRect(x: 0, y: 0, width: 24, height: 41)
        leftBarButton.addTarget(self, action: #selector(self.popWithAnimate), for: UIControl.Event.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
    }
    
    @objc  func popWithAnimate() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: 设置导航条的颜色
    private func setupNavigationBarBackgroundImage() {
        guard let nav = self.navigationController else {
            return
        }
        nav.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        if nav.viewControllers.count == 1 {
            nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            //nav.navigationBar.shadowImage = UIImage(color: UIColor.white)
            nav.navigationBar.barTintColor = UIColor.white
        }else{
            nav.navigationBar.barTintColor = UIColor.white
        }
       
    }

}
