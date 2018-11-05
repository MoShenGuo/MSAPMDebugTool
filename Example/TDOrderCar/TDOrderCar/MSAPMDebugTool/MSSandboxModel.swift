//
//  MSSandboxModel.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

import Foundation
enum MSSandboxFileType {
    case MSSandboxFileTypeDirectory//目录
    case MSSandboxFileTypeFile//文件
    case MSSandboxFileTypeBack//返回
    case MSSandboxFileTypeRoot//根目录
}
class MSSandboxModel {
    var name: String
    var path: String
    var type: MSSandboxFileType?
    init(name: String,path: String,_ type: MSSandboxFileType? = nil) {
        self.name = name
        self.path = path
        self.type = type
    }
}
