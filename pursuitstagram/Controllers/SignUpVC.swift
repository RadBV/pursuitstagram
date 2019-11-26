//
//  SignUpVC.swift
//  pursuitstagram
//
//  Created by Radharani Ribas-Valongo on 11/25/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Properties
    
    //MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    @IBAction func signUpPressed(_ sender: UIButton) {
       
    }
}
