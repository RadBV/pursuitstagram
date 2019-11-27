//
//  ViewController.swift
//  pursuitstagram
//
//  Created by Radharani Ribas-Valongo on 11/22/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Properties
    
    //MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStuff()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    @IBAction func loginPressed(_ sender: UIButton) {
        let maybeData = validateFields()
        
        if maybeData.count == 1 {
            showError(maybeData[Constants.Fields.error.rawValue]!!)
        } else {
            FirebaseAuthService.manager.loginUser(email: maybeData[Constants.Fields.email.rawValue]!!, password: maybeData[Constants.Fields.password.rawValue]!!) { (result) in
                self.handleLoginResponse(with: result)
            }
        }
        
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
    }
    
    private func handleLoginResponse(with result: Result<(), Error>) {
        switch result {
        case .success:
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    showError("ERROR: COULD NOT SWAP VIEW CONTROLLERS. AS A USER, YOU HAVE ABSOLUTELY NO IDEA WHAT THAT MEANS. AS A DEV, YOU ARE SCOFFING AT THE UTTER ATROCITY OF THIS ERROR. RIGHTLY SO BUT GUESS WHAT I DON'T CARE WHAT YOU THINK EVERY DISAPPROVING HEAD SHAKE FROM YOUR GENERAL DIRECTION DISSIPATES INTO SINGULAR METAPHORICAL ATOMS THE MOMENT THEY GRAZE MY IMPENETRABLE DOME OF ABSOLUTE INDIFFERENCE TO YOUR OPINION OF ME THE STORAGE CAPACITY OF THE CONTAINER THAT IS FILLED WITH MY APATHY TO THE THOUGHTS YOU HAVE OF THIS ERROR HAS REACHED ABSOLUTE MAXIMUM BEFORE YOU EVEN REALIZED SOMETHING WAS WRONG THE SHEER TENSION OF THIS MEASLEY SCALE IS ENOUGH TO SNAP THE STICK YOU THOUGHT WOULD BREAK MY BONES YOU MIGHT AS WELL THROW REAL ROCKS AT ME CHUMP.")
                    return
            }
            
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                window.rootViewController = homeTabBar()
            }, completion: nil)
            
        case .failure(let error):
            showError("COULD NOT LOG IN: \(error.localizedDescription.uppercased())")
        }
    }
    
    func validateFields() -> [String:String?] {
        let email = emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let error = Constants.Fields.error.rawValue
        
        guard email != "", password != "" else {
            let error = [error: error]
            return error
        }
        
        guard email!.isValidEmail else {
            let error = [error: "THAT IS NOT A VALID EMAIL. TRY AGAIN."]
            return error
        }
        
        guard password!.isValidPassword else {
            let error = [error:"DON'T LET HACKERS WIN. YOUR PASSWORD MUST CONTAIN MORE THAN 6 CHARACTERS AND AT LEAST 1 NUMBER."]
            return error
        }
        
        let data = [Constants.Fields.email.rawValue: email, Constants.Fields.password.rawValue: password]
        return data
        
    }
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        errorLabel.numberOfLines = 0
    }
    
    private func setUpStuff() {
        errorLabel.alpha = 0
        loginButton.isEnabled = false
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard emailTextfield.hasText, passwordTextfield.hasText else {
                loginButton.isEnabled = false
                return
            }
            loginButton.isEnabled = true
        }
}

