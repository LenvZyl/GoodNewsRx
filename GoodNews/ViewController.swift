//
//  ViewController.swift
//  GoodNews
//
//  Created by Len van Zyl on 2021/07/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "GoodNews"
    }


}

