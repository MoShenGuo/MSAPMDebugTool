//
//  MSSandboxDetailViewController.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/11/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import HLAppMonitor
class MSSandboxDetailViewController: MSBaseViewController {

    var filePath: String?
    
    lazy var imageView: UIImageView = {
        var imageV = UIImageView(frame: .zero)
        imageV.isUserInteractionEnabled = true
        view.addSubview(imageV)
        return imageV
    }()
    lazy var textView: UITextView = {
       
        var textV = UITextView(frame: view.bounds)
        textV.font = UIFont.systemFont(ofSize: 12.0)
        textV.textColor = .black
        textV.textAlignment = .left
        textV.isEditable = false
        textV.dataDetectorTypes = .link
        textV.isScrollEnabled = true
        textV.backgroundColor = .white
        textV.layer.borderColor = UIColor.gray.cgColor
        textV.layer.borderWidth = 2.0
        view.addSubview(textV)
        return textV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "文件预览"
        setRightNavigationBar()
        loadData(filePath)

    }
 
    func setRightNavigationBar() {
        guard let path = filePath, path.isEmpty == false else {
            
            return
        }
        if path.hasSuffix("appLogIOS.txt") {
            let rightItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(emptyPerformanceData))
            self.navigationItem.rightBarButtonItem = rightItem
        }
    }
    @objc private func emptyPerformanceData() {
        
        //清空txt文件
        TDPerformanceDataManager.sharedInstance().clearTxt()
        loadData(filePath)
    }
    func loadData(_ filePath: String?) {
        guard let path = filePath, path.isEmpty == false else {
            print("文件不存在")
            return
        }
        if path.hasSuffix(".png") || path.hasSuffix(".PNG") || path.hasSuffix(".jpg") || path.hasSuffix(".JPG") || path.hasSuffix(".jpeg") || path.hasSuffix(".JPEG") || path.hasSuffix(".gif") || path.hasSuffix(".GIF"){
            if let image = UIImage(contentsOfFile: path) {
                setOriginalImage(image)
            }
        }else if  path.hasSuffix(".strings") || path.hasSuffix(".plist") || path.hasSuffix(".txt") || path.hasSuffix(".log") || path.hasSuffix(".csv") {
            
            if path.hasSuffix(".plist") || path.hasSuffix(".strings") {
                if let path1 = NSDictionary(contentsOfFile: path)?.description {
                    setContent(path1)
                }
            }else{
                let data = NSData(contentsOfFile: path)
                if let data1 = data as Data? {
                    if let text = String.init(data: data1, encoding: .utf8) {
                        setContent(text)
                    }
                }
            }
        }else{
            let str = String.init(format: "Not support %@ file!", (path as NSString).pathExtension )
            setContent(str)
        }
        
    }
    func setContent(_ text: String) {
        textView.text = text
    }
    func setOriginalImage(_ originalImage: UIImage) {
        let viewWidth: CGFloat = view.bounds.width
        let viewHeight: CGFloat = view.bounds.height
        let imageWidth: CGFloat = originalImage.size.width
        let imageHeight: CGFloat = originalImage.size.height
        var isPortrait: Bool = false
        if ((imageHeight / viewHeight) > (imageWidth / viewWidth)) {
            isPortrait = true
        }else{
            isPortrait = false
        }
        var scaledImageWidth: CGFloat = 0 
        var scaledImageHeight: CGFloat = 0
        var x: CGFloat = 0 
        var y: CGFloat = 0
        var imageScale: CGFloat = 0 

        if isPortrait {//图片竖屏分量比较大
            imageScale = imageHeight / viewHeight
            scaledImageHeight = viewHeight
            scaledImageWidth = imageWidth / imageScale
            x = (viewWidth - scaledImageWidth) / 2
            y = 0
        }else{//图片横屏分量比较大
            imageScale = imageWidth / viewWidth
            scaledImageWidth = viewWidth
            scaledImageHeight = imageHeight / imageScale
            x = 0
            y = (viewHeight - scaledImageHeight) / 2
        }
        imageView.frame = CGRect(x: x, y: y, width: scaledImageWidth, height: scaledImageHeight)
        imageView.image = originalImage
    }

}
