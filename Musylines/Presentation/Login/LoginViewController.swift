//
//  ViewController.swift
//  Musylines
//
//  Created by Mikhail Chukhvantsev on 23.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var musylinesLabel: UILocalizedLabel!
    @IBOutlet weak var emailTextField: UILocalizedTextField!
    @IBOutlet weak var passwordTextField: UILocalizedTextField!
    
    
    @IBAction func goToRegistrationScreen(_ sender: UIButton) {
        let registrationVC = UIStoryboard(name: "Main",bundle: nil)
            .instantiateViewController(withIdentifier: "RegistrationViewController")
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        musylinesLabel.configureMusylinesLabelShadows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
        }

        return true
    }
}
