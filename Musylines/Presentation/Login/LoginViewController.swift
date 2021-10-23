//
//  ViewController.swift
//  Musylines
//
//  Created by Mikhail Chukhvantsev on 23.10.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var musylinesLabel: UILocalizedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMusylinesLabel()
    }
    
    func configureMusylinesLabel() {
        musylinesLabel.layer.shadowColor = UIColor.black.cgColor
        musylinesLabel.layer.shadowRadius = 2.0
        musylinesLabel.layer.shadowOpacity = 0.35
        musylinesLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
//        musylinesLabel.layer.masksToBounds = false
    }

}

