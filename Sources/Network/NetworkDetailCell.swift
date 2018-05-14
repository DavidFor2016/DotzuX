//
//  DotzuX.swift
//  demo
//
//  Created by liman on 26/11/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class NetworkDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var middleLine: UIView!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var toJSONImageView: UIImageView!
    
    @IBOutlet weak var titleViewBottomSpaceToMiddleLine: NSLayoutConstraint!
    //-12.5
    
    
    var tapTitleViewCallback:((NetworkDetailModel?) -> Void)?
    var tapEditViewCallback:((NetworkDetailModel?) -> Void)?
    
    var detailModel: NetworkDetailModel? {
        didSet {
            
            titleLabel.text = detailModel?.title
            contentTextView.text = detailModel?.content
            
            //图片
            if detailModel?.image == nil {
                imgView.isHidden = true
            }else{
                imgView.isHidden = false
                imgView.image = detailModel?.image
            }
            
            //自动隐藏内容
            if detailModel?.blankContent == "..." {
                middleLine.isHidden = true
                imgView.isHidden = true
                titleViewBottomSpaceToMiddleLine.constant = -12.5 + 2
            }else{
                middleLine.isHidden = false
                if detailModel?.image != nil {
                    imgView.isHidden = false
                }
                titleViewBottomSpaceToMiddleLine.constant = 0
            }
            
            //底部分割线
            if detailModel?.isLast == true {
                bottomLine.isHidden = false
            }else{
                bottomLine.isHidden = true
            }
            
            //to JSON
            if detailModel?.title == "HEADER" {
                editView.isHidden = false
            }else{
                if detailModel?.title == "REQUEST" {
                    if let content = detailModel?.content {
                        if let _ = content.stringToDictionary() {
                            //JSON格式
                            editView.isHidden = true
                        }else{
                            //Form格式
                            editView.isHidden = false
                        }
                    }else{
                        editView.isHidden = true
                    }
                }else{
                    editView.isHidden = true
                }
            }
        }
    }
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentTextView.textContainer.lineFragmentPadding = 0
        contentTextView.textContainerInset = .zero
        
        
        //自动隐藏内容
        let tap = UITapGestureRecognizer()
        titleView.addGestureRecognizer(tap)
        tap.rx
            .event
            .subscribe(onNext: { [weak self] (_) in
                
                if let tapTitleViewCallback = self?.tapTitleViewCallback {
                    tapTitleViewCallback(self?.detailModel)
                }
            })
            .disposed(by: rx.disposeBag)
        
        
        //编辑
        let tap2 = UITapGestureRecognizer()
        editView.addGestureRecognizer(tap2)
        tap2.rx
            .event
            .subscribe(onNext: { [weak self] (_) in
                
                if let tapEditViewCallback = self?.tapEditViewCallback {
                    tapEditViewCallback(self?.detailModel)
                }
            })
            .disposed(by: rx.disposeBag)
    }
}
