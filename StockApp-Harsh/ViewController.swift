//
//  ViewController.swift
//  StockApp-Harsh
//
//  Created by Harshvardhan Sharma on 15/11/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let vc = HomeViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        })
    }
}

