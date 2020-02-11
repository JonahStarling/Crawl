//
//  LaunchViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 1/17/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//
// The Launch View Controller is shown when the app is first launched. It is designed to look
// exactly like the splash screen so we can seamlessly transition to the appropriate location.
// - If the user is logged in then the screen will fade out and navigate to home.
// - If the user is not logged in then a continue with Apple button will fade in.
// - - If they successfully login then the screen will fade out and navigate to home.
// - - If there is a failure/cancellation then an appropriate error message will appear.
//

import UIKit

class LaunchViewController: UIViewController {

    var loggedIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // loggedIn = isUserLoggedIn() todo: uncomment later
        loggedIn = true // todo: remove later
        if (!loggedIn) {
            showLoginView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (loggedIn) {
            navigateToHomeViewController()
        }
    }
    
    func isUserLoggedIn() -> Bool {
        let userLoggedIn: Bool = false
        // todo: check if logged in - this function should simplify to one line (maybe)
        return userLoggedIn
    }
    
    func continueWithAppleClicked() {
        // todo: continue with apple logic
        hideLoginView() // todo: onSuccess
        // todo: show error message onFailure
    }

    func showLoginView() {
        // todo: animate and show login view
    }
    
    func hideLoginView() {
        // todo: animate and hide login view
    }
    
    func hideLogoView() {
        // todo: animate and hide logo view
    }
    
    func navigateToHomeViewController() {
        hideLogoView()
        performSegue(withIdentifier: "launchToHomeSegue", sender: nil)
    }

}

