//
//  ViewController.swift
//  EntryKit
//
//  Created by winterrain5 on 05/10/2021.
//  Copyright (c) 2021 winterrain5. All rights reserved.
//

import UIKit
import EntryKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alertView = UIView()
        alertView.backgroundColor = .red
        let size = CGSize(width: 200, height: 300)
        EntryKit.display(view: alertView, size: size, style: .alert, touchDismiss: true)
    }

}



