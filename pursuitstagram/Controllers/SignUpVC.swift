//
//  SignUpVC.swift
//  pursuitstagram
//
//  Created by Radharani Ribas-Valongo on 11/25/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Properties
    var imageURL: URL? = nil
    var username: String = "it didn't work"
    
    //MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    @IBAction func signUpPressed(_ sender: UIButton) {
        let maybeData = validateFields()
        if maybeData.count == 1 {
            showError(maybeData[Constants.Fields.error.rawValue]!!)
        } else {
            FirebaseAuthService.manager.createNewUser(email: maybeData[Constants.Fields.email.rawValue]!!, password: maybeData[Constants.Fields.password.rawValue]!!) { [weak self] (result) in
                self?.handleCreateAccountResponse(with: result)
                self?.username = maybeData[Constants.Fields.username.rawValue]!!
            }
        }
    }
    
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let user):
                FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                    self?.handleCreatedUserInFirestore(result: newResult)
                    
                    //MARK: TODO - Figure out how to add the username to the database. The code below definitely does not do it.
                    FirebaseAuthService.manager.updateUserFields(userName: self?.username, photoURL: self?.imageURL) { (newNewResult) in
                        switch newNewResult {
                        case .success(()):
                            print(self?.username)
                        case .failure(let error):
                            print("error setting username: \(error.localizedDescription)")
                        }
                    }
                }
            case .failure(let error):
                self?.showError("ERROR CREATING USER. SORRY BUD: \(error.localizedDescription.uppercased())")
                print(error.localizedDescription)
            }
        }
    }
    
    private func handleCreatedUserInFirestore(result: Result<(), Error>) {
        switch result {
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    showError("ERROR: COULD NOT SWAP VIEW CONTROLLERS. AS A  USER, YOU HAVE ABSOLUTELY NO IDEA WHAT THAT MEANS. AS A DEV, YOU ARE SCOFFING AT THE UTTER ATROCITY OF THIS ERROR. RIGHTLY SO BUT GUESS WHAT I DON'T CARE WHAT YOU THINK EVERY DISAPPROVING HEAD SHAKE FROM YOUR GENERAL DIRECTION DISSIPATES INTO SINGULAR METAPHORICAL ATOMS THE MOMENT THEY GRAZE MY IMPENETRABLE DOME OF ABSOLUTE INDIFFERENCE TO YOUR OPINION OF ME THE STORAGE CAPACITY OF THE CONTAINER THAT IS FILLED WITH MY APATHY TO THE THOUGHTS YOU HAVE OF THIS ERROR HAS REACHED ABSOLUTE MAXIMUM BEFORE YOU EVEN REALIZED SOMETHING WAS WRONG THE SHEER TENSION OF THIS MEASLEY SCALE IS ENOUGH TO SNAP THE STICK YOU THOUGHT WOULD BREAK MY BONES YOU MIGHT AS WELL THROW REAL ROCKS AT ME CHUMP.")
                    return
            }
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                window.rootViewController = HomeVC()
            }, completion: nil)
            
        case .failure(let error):
            showError("AN ERROR OCCURRED WHILE CREATING A NEW ACCOUNT: \(error.localizedDescription)")
        }
    }
    
    
    func validateFields() -> [String:String?] {
        let email = emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let error = Constants.Fields.error.rawValue
        
        guard email != "", password != "", username != "" else {
            let error = [error:"CAN YOU PRETTY PLEASE FILL IN ALL FIELDS."]
            return error
        }
        
        guard email!.isValidEmail else {
            let error = [error:"THAT IS NOT A VALID EMAIL. TRY AGAIN."]
            return error
        }
        
        guard password!.isValidPassword else {
            let error = [error:"DON'T LET HACKERS WIN. YOUR PASSWORD MUST CONTAIN MORE THAN 6 CHARACTERS AND AT2 LEAST 1 NUMBER."]
            return error
        }
        
        let data = [Constants.Fields.email.rawValue :email, Constants.Fields.password.rawValue:password, Constants.Fields.username.rawValue:username]
        return data
        
    }
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        errorLabel.numberOfLines = 0
    }
        
        
}
