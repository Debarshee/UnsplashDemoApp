//
//  SignUpViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/18/21.
//

import Firebase
import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet private weak var backToLoginButton: UIButton!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var signUpContainerView: UIView!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        signUpContainerView.layer.cornerRadius = 20
        signUpContainerView.clipsToBounds = true
    }
    
    @IBAction private func backToLoginButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func signUpButtonClicked(_ sender: UIButton) {
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let username = usernameTextField.text {
            if !firstName.isEmpty && !lastName.isEmpty && !username.isEmpty {
                Auth.auth().createUser(withEmail: (emailTextField.text ?? ""), password: (passwordTextField.text ?? "")) { [weak self] result, error in
                    guard let self = self else { return }
                    if let finalError = error {
                        print(finalError)
                        let alert = UIAlertController(title: "Alert", message: "Invalid Email or Password", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        guard let finalResult = result else { return }
                        var ref: DocumentReference?
                        ref = self.db.collection("users").addDocument(data: [
                            "first name": firstName,
                            "last name": lastName,
                            "username": username,
                            "email": self.emailTextField.text ?? "",
                            "password": self.passwordTextField.text ?? "",
                            "uid": finalResult.user.uid
                        ]) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                guard let reference = ref else { return }
                                print("Document added with ID: \(reference.documentID)")
                            }
                        }
                    }
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: "User Info Missing", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            print("Error")
        }
    }
}
