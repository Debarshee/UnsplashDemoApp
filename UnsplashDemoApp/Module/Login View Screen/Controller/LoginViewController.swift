//
//  LoginViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/16/21.
//

import Firebase
import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func passUserData(user: UserDetailViewModel)
}

class LoginViewController: UIViewController {

    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginContainerView: UIView!
    
    var loginViewModel = LoginViewModel()
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        loginViewModel.delegate = self
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        loginContainerView.layer.cornerRadius = 20
        loginContainerView.clipsToBounds = true
    }
    
    @IBAction private func cancelButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func loginButtonClicked(_ sender: UIButton) {
        guard let unwrappedEmail = emailTextField.text else { return }
        guard let unwrappedPassword = passwordTextField.text else { return }
        self.signIn(email: unwrappedEmail, password: unwrappedPassword)
    }
    @IBAction private func forgotPasswordButtonClicked(_ sender: UIButton) {
    }
    @IBAction private func signUpButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        guard let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        signUpViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    private func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let finalError = error {
                print(finalError.localizedDescription)
            } else {
            if let finalResult = result {
                print(finalResult.user.providerID)
            }
            }
        }
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func userDataFetched(user: UserDetailViewModel) {
        self.delegate?.passUserData(user: user)
        self.dismiss(animated: true, completion: nil)
    }
}
