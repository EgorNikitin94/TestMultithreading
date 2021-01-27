//
//  ViewController.swift
//  TestMultithreading
//
//  Created by Егор Никитин on 27.01.2021.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var myButton: UIButton! {
        didSet{
            myButton.layer.cornerRadius = 5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}



