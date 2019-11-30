//
//  HomeVC.swift
//  pursuitstagram
//
//  Created by Radharani Ribas-Valongo on 11/25/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var postCollectionView: UICollectionView!
    //MARK: - Properties
    var posts = [Post]() {
        didSet {
            self.postCollectionView.reloadData()
        }
    }
    
    //MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStuff()
    }
    
    //MARK: - Functions
    @objc func logOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            showAlert(with: "ERROR, COULD NOT SIGN OUT", and: "SORRY CHUMP, YOU'RE STUCK HERE: \(error.localizedDescription)")
        }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
            else {
                //MARK: TODO - handle could not swap root view controller
                return
        }
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            
            window.rootViewController = loginVC
        }, completion: nil)
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func setUpStuff() {
        view.backgroundColor = .white
        self.navigationItem.title = "Feed"
        let rightBtn: UIBarButtonItem = UIBarButtonItem(title: "Sign Out?", style: .plain, target: self, action: #selector(logOutTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
}
