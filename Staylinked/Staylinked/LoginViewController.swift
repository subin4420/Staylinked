//
//  LoginViewController.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/04/28.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    @IBOutlet weak var IDTextFiled: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var PWTextFiled: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.isEnabled = false
        IDTextFiled.delegate = self
        PWTextFiled.delegate = self

    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {//파이어베이스 이메일/비밀번호 인증
        let ID = IDTextFiled.text ?? ""
        let password = PWTextFiled.text ?? ""
        //loginUser(withEmail: ID, password: password)
        Auth.auth().signIn(withEmail: ID, password: password){[weak self] _, error in guard let self = self else {return}
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            }else{
                self.showMainViewController()
            }
        }
        /**
         Auth.auth().createUser(withEmail: ID, password: password){
             [weak self] authResult, error in guard let self = self else {return}
             if let error = error{
                 let code = (error as NSError).code
                 switch code {
                 case 17007://이미 아이디가 만들어졌을 경우 뜨는 오류 이때는 loginUser로 넘어간다.
                     self.loginUser(withEmail: ID, password: password)
                 default:
                     self.errorMessageLabel.text = error.localizedDescription
                 }
             } else{
                 self.showMainViewController()
             }
          
         }**/
    }
    
    private func showMainViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail ID: String, password: String){
        Auth.auth().signIn(withEmail: ID, password: password){[weak self] _, error in guard let self = self else {return}
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            }else{
                self.showMainViewController()
            }
        }
        

    }
    
}
extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isIDEmpty = IDTextFiled.text == ""
        let isPWEmpty = PWTextFiled.text == ""
        LoginButton.isEnabled = !isIDEmpty && !isPWEmpty
    }
    
    
    
    
    
}
