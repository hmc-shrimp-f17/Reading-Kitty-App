//
//  TeacherLoginViewController.swift
//  Reading Kitty
//
//  Created by cssummer18 on 6/8/18.
//  Copyright © 2018 cssummer18. All rights reserved.
//

import UIKit

class TeacherLoginViewController: UIViewController, UITextFieldDelegate { 
    /********** LOCAL VARIABLES **********/
    // The text field that the user inputs their password
    @IBOutlet weak var passwordBox: UITextField!
    
    // Reference to levels, books, and devices
    var modelController = ModelController()
    
    
    /********** VIEW FUNCTIONS **********/
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordBox.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /********** SEGUE FUNCTIONS **********/
    // When user clicks the back button, it send them to the Welcome scene
    @IBAction func backButton(_ sender: UIButton) {
        // Go to Welcome
        self.performSegue(withIdentifier: "Welcome", sender: self)
    }
    
    // If user inputs the correct password, it sends them to the TeacherWelcome scene
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // submit password
        textField.resignFirstResponder()
        
        return true
    }
    
    // When text field is going inactive (through tabbing or returning)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Check if password is correct
        if modelController.checkPassword(attemptedPassword: textField.text!) {
            //Go to TeacherWelcome
            self.performSegue(withIdentifier: "TeacherWelcome", sender: self)
        }
        
        return true
    }
    
    // If user clicks on the forgot password button, it send them to the SecurityQuestion scene
    @IBAction func forgotPassword(_ sender: Any) {
        // Go to SecurityQuestion
        self.performSegue(withIdentifier: "SecurityQuestion", sender: self)
    }
    
    // Passing data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Update the modelController in Welcome
        if segue.destination is ViewController {
            let Destination = segue.destination as? ViewController
            Destination?.modelController = modelController
        }
        
        // Update the modelController in TeacherWelcome
        if segue.destination is TeacherWelcomeViewController {
            let Destination = segue.destination as? TeacherWelcomeViewController
            Destination?.modelController = modelController
        }
        
        // Update the modelController in SecurityQuestion
        if segue.destination is SecurityQuestionViewController {
            let Destination = segue.destination as? SecurityQuestionViewController
            Destination?.modelController = modelController
        }
    }
}
