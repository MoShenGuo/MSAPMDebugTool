//
//  MSAPMListViewController.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import HLAppMonitor
class MSAPMListViewController: MSBaseViewController {

    let TableViewCellIdentifier: String = "APMTableViewCellIdentifier"
    let sandboxTableViewCellIdentifier: String = "sandboxTableViewCellIdentifier"
    lazy var tableView: UITableView = {
        var tb = UITableView.init(frame: self.view.bounds, style: .plain)
        tb.register(MSAPMTableViewCell.classForCoder(), forCellReuseIdentifier: self.TableViewCellIdentifier)
         tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.sandboxTableViewCellIdentifier)
        tb.dataSource = self
        tb.delegate = self
        tb.tableFooterView = UIView()
        return tb
    }()
    var dataSource: [MSAPMListModel] = [
                                  MSAPMListModel(title:"1.总开关",isOn:true),
                                        MSAPMListModel(title:"2.基本性能数据",isOn:true),MSAPMListModel(title:"3.帧率FPS",isOn:true),MSAPMListModel(title:"4,网络数据",isOn:true),MSAPMListModel(title:"5.卡顿信息",isOn:true),MSAPMListModel(title:"6.崩溃信息",isOn:true)]
    var sandboxDataSource:[String] = ["沙盒详情","清空性能数据txt文件","存入沙盒"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "APM"
        view.addSubview(tableView)
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
   override func forceToSetBackItem() {
      
    }
    /// MARK-:Action
    //选中开关  isOn是否打开,selectRowAtIndexPath:表示行列数
    fileprivate func switchTransaction(_ isOn: Bool,_ selectRowAtIndexPath: IndexPath) {
        if selectRowAtIndexPath.section == 0 {
            switch selectRowAtIndexPath.row {
            case 0://总开关
                for model in dataSource {
                    model.isOn = isOn
                }
                TDPerformanceDataManager.sharedInstance()?.didChange(_TDMonitoringIndicatorsALL, withChangeStatus: isOn)
                tableView.reloadData()
                break
            case 1://基本数据开关
                let model = dataSource[selectRowAtIndexPath.row]
                model.isOn = isOn
                tableView.reloadRows(at: [selectRowAtIndexPath], with: .bottom)
                TDPerformanceDataManager.sharedInstance()?.didChange(_TDMonitoringIndicatorsBase, withChangeStatus: isOn)
                break
            case 2://帧率FPS
                let model = dataSource[selectRowAtIndexPath.row]
                model.isOn = isOn
                tableView.reloadRows(at: [selectRowAtIndexPath], with: .bottom)
                TDPerformanceDataManager.sharedInstance()?.didChange(_TDMonitoringIndicatorsFPS, withChangeStatus: isOn)
                break
            case 3://网络数据
                let model = dataSource[selectRowAtIndexPath.row]
                model.isOn = isOn
                tableView.reloadRows(at: [selectRowAtIndexPath], with: .bottom)
                TDPerformanceDataManager.sharedInstance()?.didChange(_TDMonitoringIndicatorsNetwork, withChangeStatus: isOn)
                break
            case 4://卡顿信息
                let model = dataSource[selectRowAtIndexPath.row]
                model.isOn = isOn
                tableView.reloadRows(at: [selectRowAtIndexPath], with: .bottom)
                TDPerformanceDataManager.sharedInstance()?.didChange(_TDMonitoringIndicatorsCaton, withChangeStatus: isOn)
                break
            case 5://崩溃信息
                let model = dataSource[selectRowAtIndexPath.row]
                model.isOn = isOn
                tableView.reloadRows(at: [selectRowAtIndexPath], with: .bottom)
                TDPerformanceDataManager.sharedInstance()?.didChange(_TDMonitoringIndicatorsCrash, withChangeStatus: isOn)
                break
            case 6://沙盒
                break
            default:
                break
            }
        }
    }
}
// MARK: - UITableViewDataSource,UITableViewDelegate
extension MSAPMListViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return dataSource.count
        }else{
            return sandboxDataSource.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier) as! MSAPMTableViewCell
            let model = dataSource[indexPath.row]
            
            cell.setupData(model)
            cell.switchChangeBlock = {[weak self] isOn in
                //self?.switchTransaction(isOn)
                print("ison=\(isOn)")
                self?.switchTransaction(isOn, indexPath)
            }
            cell.selectionStyle = .none
            return cell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: sandboxTableViewCellIdentifier)
            if (cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: sandboxTableViewCellIdentifier)
            } 
            let text = sandboxDataSource[indexPath.row]
            cell?.textLabel?.text = text
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            return cell!
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //            let domainSwitchCtrl = TDWDomainSwitchController()
                //            navigationController?.pushViewController(domainSwitchCtrl, animated: true)
            }else if (indexPath.row == 1) {
                //            let domainLogCtrl = TDWDomainLogViewController()
                //            navigationController?.pushViewController(domainLogCtrl, animated: true)
            }else if (indexPath.row == 2){
                //            let biaoController = TDWDevBiaoDetailController()
                //            navigationController?.pushViewController(biaoController, animated: true)
            }else if (indexPath.row == 3) {
                //            let controller = TDWJavaHostViewController()
                //            navigationController?.pushViewController(controller, animated: true)
            }else if (indexPath.row == 4) {
                
            }
        }else{
            
            if indexPath.row == 0 {
                let controller = MSSandboxViewController()
                navigationController?.pushViewController(controller, animated: true)
            }else if indexPath.row == 1 {
                
                let alertController = UIAlertController.init(title: "", message: "是否确定清空性能数据txt文件", preferredStyle: .alert)
                alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
                    
                }))
                
                alertController.addAction(UIAlertAction.init(title: "确认", style: .default, handler: {  (action) in
                    //清空txt文件
                    TDPerformanceDataManager.sharedInstance().clearTxt()
                }))
                
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }else if indexPath.row == 2 {//存入沙盒
                //写入沙盒
                TDPerformanceDataManager.sharedInstance().writeSandbox()
            }
        }
        
    }
}
