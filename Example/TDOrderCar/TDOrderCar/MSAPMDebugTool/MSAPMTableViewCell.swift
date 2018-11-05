//
//  MSAPMTableViewCell.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import SnapKit
class MSAPMTableViewCell: UITableViewCell {
    typealias SwitchChangeBlock = (Bool) -> ()
    
    var switchChangeBlock: SwitchChangeBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    lazy var nameLabel: UILabel = {
        var nameL = UILabel()
        nameL.font = UIFont.systemFont(ofSize: 14)
        nameL.textColor = .black
        return nameL
    }()
    lazy var control: UISwitch = {
        var control11 = UISwitch()
        control11.addTarget(self, action: #selector(switchChanged(sender:)), for: .valueChanged)
        return control11
    }()
    @objc func switchChanged(sender: UISwitch) {
       switchChangeBlock?(sender.isOn)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initSubView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(control)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.centerY.equalToSuperview()
        }
        control.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-15)
            make.centerY.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right).offset(15)
        }
    }
    func setupData(_ model: MSAPMListModel){

        nameLabel.text = model.title
        control.isOn = model.isOn
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
