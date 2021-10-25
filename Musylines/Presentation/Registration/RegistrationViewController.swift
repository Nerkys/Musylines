//
//  RegistrationViewController.swift
//  Musylines
//
//  Created by Mikhail Chukhvantsev on 24.10.2021.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var musylinesLabel: UILocalizedLabel!
    @IBOutlet weak var nameTextField: UILocalizedTextField!
    @IBOutlet weak var surnameTextField: UILocalizedTextField!
    @IBOutlet weak var ageTextField: UILocalizedTextField!
    @IBOutlet weak var phoneNumberTextField: UILocalizedTextField!
    @IBOutlet weak var emailTextField: UILocalizedTextField!
    @IBOutlet weak var passwordTextField: UILocalizedTextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var signUpButton: UILocalizedButton!
    @IBOutlet weak var nameHintLabel: UILabel!
    @IBOutlet weak var surnameHintLabel: UILabel!
    @IBOutlet weak var phoneNumberHintLabel: UILabel!
    
    @IBOutlet var textFields: [UILocalizedTextField]!
    
    @IBAction func goToLoginScreen(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private let viewModel = RegistrationViewModel()

    private var cancellableSet: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindings()
        setupView()
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func bindings() {
        nameTextField.textPublisher
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellableSet)
        
        viewModel.$nameHint
            .sink(receiveValue: { [ weak self ] nameHint in
                self!.nameHintLabel.text = nameHint
            })
            .store(in: &cancellableSet)
        
        surnameTextField.textPublisher
            .assign(to: \.surname, on: viewModel)
            .store(in: &cancellableSet)
        
        viewModel.$surnameHint
            .sink(receiveValue: { [ weak self ] surnameHint in
                self!.surnameHintLabel.text = surnameHint
            })
            .store(in: &cancellableSet)
        
        phoneNumberTextField.textPublisher
            .assign(to: \.phoneNumber, on: viewModel)
            .store(in: &cancellableSet)
        
        viewModel.$phoneNumberHint
            .sink(receiveValue: { [ weak self ] phoneNumberHint in
                self!.phoneNumberHintLabel.text = phoneNumberHint
            })
            .store(in: &cancellableSet)
        
        viewModel.$phoneNumberFormatted
            .sink(receiveValue: { [ weak self ] phoneNumber in
                self!.phoneNumberTextField.text = phoneNumber
            })
            .store(in: &cancellableSet)
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            surnameTextField.becomeFirstResponder()
        case surnameTextField:
            ageTextField.becomeFirstResponder()
        case ageTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    private func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        
        if textField == passwordTextField {
            return (text.count >= 6, Strings.registrationScreen_passwordRequirements_label)
        }
        
        return (text.count > 0, "This field cannot be empty.")
    }
    
    private func setupView() {
        musylinesLabel.configureMusylinesLabelShadows()
        hideKeyboardByTappingOutside()
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func hideKeyboardByTappingOutside() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
}
