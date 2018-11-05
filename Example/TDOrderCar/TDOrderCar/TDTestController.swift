//
//  TDTestController.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/10/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

class TDTestController: UIViewController {

    var startTime:CFAbsoluteTime = 0
    var indext: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startTime = CFAbsoluteTimeGetCurrent()
        view.backgroundColor = .red

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let endTime = CFAbsoluteTimeGetCurrent()
        print("ss=%d",endTime - startTime)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        while indext < 120000000 {//1
//            //  print("----\(index)")
//            indext += 1
//        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        while indext < 200000000 {//2
//            //  print("----\(index)")
//            indext += 1
//        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.popViewController(animated: false)
       // self.dismiss(animated: true, completion: nil)
//        while indext < 200000000 {
//            //  print("----\(index)")
//            indext += 1
//        }
//        print("--------------------")
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
