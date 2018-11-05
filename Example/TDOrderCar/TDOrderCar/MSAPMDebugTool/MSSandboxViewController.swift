//
//  MSSandboxViewController.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit

class MSSandboxViewController: MSBaseViewController  {

    let TableViewCellIdentifier: String = "SandboxTableViewCellIdentifier"
    lazy var dataSource: [MSSandboxModel] = [MSSandboxModel]()
    var currentDirModel: MSSandboxModel?
    
    let rootPath: String = NSHomeDirectory()
    lazy var tableView: UITableView = {
        var tb = UITableView.init(frame: self.view.bounds, style: .plain)
        tb.register(MSSandboxTableViewCell.classForCoder(), forCellReuseIdentifier: self.TableViewCellIdentifier)
        tb.dataSource = self
        tb.delegate = self
        tb.tableFooterView = UIView()
        return tb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "沙盒浏览器"
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        initData()
    }
    func initData() {
        loadPath(nil)
    }
    override func popWithAnimate() {
        if currentDirModel?.type == .MSSandboxFileTypeRoot {
            super.popWithAnimate()
        }else{
            if let path = (currentDirModel?.path as NSString?)?.deletingLastPathComponent {
                loadPath(path)
            }
            
        }
    }
    func loadPath(_ filePath: String?) {
        let fm = FileManager.default
        let model = MSSandboxModel(name: "", path: "")

        var targetPath: String = ""
        if let targetPath1 = filePath {
            if targetPath1 == rootPath {
                model.name = "根目录"
                targetPath = rootPath
                model.type = .MSSandboxFileTypeRoot
            }else{
                 targetPath = targetPath1
            }
            model.path = targetPath1
        }else{
            model.name = "根目录"
            targetPath = rootPath
            model.type = .MSSandboxFileTypeRoot
        }
       currentDirModel = model
        //该目录下面的内容信息
        var files:[MSSandboxModel] = [MSSandboxModel]()
        do {
            let paths =   try fm.contentsOfDirectory(atPath: targetPath)
            for path in paths {
                let fullPath = (targetPath as NSString).appendingPathComponent(path)
                let isDirPointer = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
                isDirPointer.initialize(to: false)
                
                fm.fileExists(atPath: fullPath, isDirectory: isDirPointer)
                let pointee = isDirPointer.pointee
                let model1 = MSSandboxModel(name: "", path: "")
                model1.path = fullPath
                if pointee.boolValue {
                    model1.type = .MSSandboxFileTypeDirectory
                }else{
                     model1.type = .MSSandboxFileTypeFile
                }
                model1.name = path
                 files.append(model1)
            }
           
        } catch  {//失败了
            
            
        }
       dataSource = files
        
        tableView.reloadData()
    
    }
    func handleFileWithPath(_ filePath: String?) {
        let alertVc = UIAlertController(title: "请选择操作方式", message: nil, preferredStyle: .actionSheet)
        let previewAction = UIAlertAction(title: "本地预览", style: .default) { [weak  self] (action) in
            self?.previewLocalFile(filePath)
        }
        let shareAction = UIAlertAction(title: "分享", style: .default) { [weak  self] (action) in
            self?.shareFileWithPath(filePath)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) {  (action) in

        }
        alertVc.addAction(previewAction)
        alertVc.addAction(shareAction)
        alertVc.addAction(cancelAction)
        self.present(alertVc, animated: true, completion: nil)
    }
    //本地预览
    func previewLocalFile(_ filePath: String?) {
        
        let detalVc = MSSandboxDetailViewController()
        detalVc.filePath = filePath
        self.navigationController?.pushViewController(detalVc, animated: true)
    }
    func shareFileWithPath(_ filePath: String?) {
        guard let path = filePath else {
            return
        }
        let url = URL.init(fileURLWithPath: path)
        let objectsToShare:[URL] = [url]
        let controller = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        let excludedActivities:[UIActivity.ActivityType] = [UIActivity.ActivityType.postToTwitter,
                                                            UIActivity.ActivityType.postToFacebook,
                                                            UIActivity.ActivityType.postToWeibo,
                                                            UIActivity.ActivityType.message,
                                                            UIActivity.ActivityType.mail,
                                                            UIActivity.ActivityType.print,
                                                            UIActivity.ActivityType.copyToPasteboard,
                                                            UIActivity.ActivityType.assignToContact,
                                                            UIActivity.ActivityType.saveToCameraRoll,
                                                            UIActivity.ActivityType.addToReadingList,
                                                            UIActivity.ActivityType.postToFlickr,
                                                            UIActivity.ActivityType.postToVimeo,
                                                            UIActivity.ActivityType.postToTencentWeibo]
        controller.excludedActivityTypes = excludedActivities
        self.present(controller, animated: true, completion: nil)
        
    }
}
// MARK: - UITableViewDataSource,UITableViewDelegate
extension MSSandboxViewController: UITableViewDataSource,UITableViewDelegate {
    
    ///UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier) as! MSSandboxTableViewCell
        let model = dataSource[indexPath.row]
        cell.renderUIWithData(model)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    /// UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        let model = dataSource[indexPath.row]
        if model.type == .MSSandboxFileTypeFile {
            handleFileWithPath(model.path)
            
        }else if model.type == .MSSandboxFileTypeDirectory {
            loadPath(model.path)
        }
    }

}
