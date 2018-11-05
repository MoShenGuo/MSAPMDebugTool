//
//  MSAPMListModel.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

import Foundation

class MSAPMListModel {
    var title:String = ""
    var isOn: Bool = false
    init(title: String,isOn: Bool) {
        self.title = title
        self.isOn = isOn
    }
}
