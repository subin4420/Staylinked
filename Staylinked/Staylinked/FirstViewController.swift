//
//  MainViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/04/28.
//

import UIKit

class FirstViewController: UIViewController{
    
    @IBOutlet weak var emailLoginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailLoginButton.layer.borderWidth = 1
        emailLoginButton.layer.borderColor = UIColor.white.cgColor
        emailLoginButton.layer.cornerRadius = 30
        
    }
    

}
