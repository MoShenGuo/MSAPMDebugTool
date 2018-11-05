//
//  ViewController.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/10/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     var index: Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
 
//        let frame = CGRect(x: 0, y: 100, width: 48, height: 48)
//        let btn = AssistiveButton(frame: frame, normalImage: UIImage(named: "eye")!)
//        
//        btn.didTap = { () -> () in
//            print("abc")
//        }
//        self.view.addSubview(btn)
           print("--ViewController--viewDidLoad--")
//        while index < 20000000 {//1/2
//            //  print("----\(index)")
//            index += 1
//        }
      
    }

    override func viewDidAppear(_ animated: Bool) {
          
        super.viewDidAppear(animated)
      
       // let startTime = CFAbsoluteTimeGetCurrent()
//        while index < 60000000 {//1
//            //  print("----\(index)")
//            index += 1
//        }
//        let endTime = CFAbsoluteTimeGetCurrent()
//        debugPrint("代码执行时长：%f 毫秒", (endTime - startTime)*1000)
////         print("----viewDidAppear--")
//        print("home=\(NSHomeDirectory())")
//        print("ViewController-viewDidAppear")
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let vc = TDTestController()
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    func test() {
        let sema = DispatchSemaphore(value: 0)
        let _ = sema.wait(timeout: DispatchTime.distantFuture)  
        print("----------")
        sema.signal();
    }

}

