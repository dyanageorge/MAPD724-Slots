//
//  ViewController.swift
//  AssignmentOne
//
//  Created by Dyana George on 1/23/19.
//  Copyright © 2019 Dyana George. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var bodyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyImage.layer.cornerRadius = 20
        bodyImage.clipsToBounds = true
//        bodyImage.layer.borderColor = UIColor.gray.cgColor
//        bodyImage.layer.borderWidth = 20
    }
    



}

