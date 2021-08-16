//
//  ViewController.swift
//  spartacamp-practice-swift
//
//  Created by 伴地慶介 on 2021/08/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topImageView.image = UIImage(named: "top")
        // Do any additional setup after loading the view.
    }


}

