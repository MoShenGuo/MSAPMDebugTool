//
//  MSSandboxTableViewCell.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

class MSSandboxTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func renderUIWithData(_ model: MSSandboxModel) {
        textLabel?.text = model.name
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
