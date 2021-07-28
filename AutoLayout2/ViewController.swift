//
//  ViewController.swift
//  AutoLayout2
//
//  Created by Yash on 20/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView1.layer.cornerRadius = 10
        imgView1.clipsToBounds = true
        
        imgView2.layer.cornerRadius = 10
        imgView2.clipsToBounds = true
        
        imgView3.layer.cornerRadius = 10
        imgView3.clipsToBounds = true
        
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
        
    }


}

