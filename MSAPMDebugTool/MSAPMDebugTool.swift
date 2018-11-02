//
//  MSAPMDebugTool.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
class MSAPMDebugTool: NSObject {
    
    // 单例
    @objc static let shared: MSAPMDebugTool = MSAPMDebugTool()
    private override init() {
        super.init()
        
    }
    // Dev的Button
    private lazy var assistButton: UIButton = {
        let rect = CGRect(x: UIScreen.main.bounds.width*0.5-50, y: 20, width: 44, height: 44)
        let btn = UIButton.init(frame: rect)
        //        btn.setBackgroundImage(UIImage(named: "eye"), for: .normal)
        //        btn.setBackgroundImage(UIImage(named: "eye"), for: .selected)
        btn.backgroundColor = .black
        btn.setTitle("APM", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("APM", for: .selected)
        btn.setTitleColor(.blue, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.isSelected = false
        return btn
    }()
    
    private var originNavController: UINavigationController!
    
    func start() {
        originNavController = UINavigationController.init(rootViewController: MSAPMListViewController())
        UIApplication.shared.delegate!.window??.addSubview(assistButton)
        assistButton.setTitle("APM", for: .normal)
        assistButton.addTarget(self, action:  #selector(apmButtonDidCliced), for: .touchUpInside)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(_:)))
        assistButton.addGestureRecognizer(pan)   
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 1)) { 
            UIApplication.shared.delegate!.window??.bringSubviewToFront(self.assistButton)
        }
    }
    @objc private func handlePan(_ ges: UIPanGestureRecognizer) {
        
        let point = ges.translation(in: ges.view)
        guard let senderView = ges.view else {
            return
        }
        let margin: CGFloat = 0
        var centerX: CGFloat = senderView.center.x + point.x
        var centerY: CGFloat = senderView.center.y + point.y
        let viewW: CGFloat = senderView.frame.size.width * 0.5 + margin
        let viewH: CGFloat = senderView.frame.size.height * 0.5 + margin
        if centerX - viewW < 0 {
            centerX = viewW
        }
        if centerX + viewW > UIScreen.main.bounds.width{
            centerX = UIScreen.main.bounds.width - viewW
        }
        if centerY - viewH < 0 {
            centerY = viewH
        }
        if centerY + viewH > UIScreen.main.bounds.height {
            centerY = UIScreen.main.bounds.height - viewH
        }
        senderView.center = CGPoint(x: centerX , y: centerY)
        ges.setTranslation(.zero, in: assistButton.superview)
    }
    @objc func apmButtonDidCliced() {
        if assistButton.isSelected {
            assistButton.isSelected = false
            originNavController.dismiss(animated: true, completion: nil)
            //            DevButton.setTitle("Dev", for: .normal)
        }else{
            assistButton.isSelected = true
            var topController: UIViewController? = UIApplication.shared.delegate!.window??.rootViewController
            while (topController?.presentedViewController != nil) {
                topController = topController?.presentedViewController
            }
            topController?.present(originNavController, animated: true, completion: {
                UIApplication.shared.delegate!.window??.bringSubviewToFront(self.assistButton)
            })
            //            DevButton.setTitle("Off", for: .normal)
        }
    }
}
