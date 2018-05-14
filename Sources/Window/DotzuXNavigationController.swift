//
//  DotzuX.swift
//  demo
//
//  Created by liman on 26/11/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class DotzuXNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false //add by liman
        
        navigationBar.tintColor = Color.mainGreen
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20),
                                             NSAttributedStringKey.foregroundColor: Color.mainGreen]

        let image = UIImage(named: "DotzuX_close", in: Bundle(for: DotzuXNavigationController.self), compatibleWith: nil)
        let item = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        item.tintColor = Color.mainGreen
        topViewController?.navigationItem.leftBarButtonItem = item
        
        item.rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
    }
}
