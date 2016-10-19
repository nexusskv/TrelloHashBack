//
//  StartViewController.swift
//  TrelloTestTask
//
//  Created by Rost on 18.10.16.
//  Copyright © 2016 Rost Gress. All rights reserved.
//

import UIKit

enum ViewsTypes: Int {
    case baseview = 0
    case label
    case button
}



class StartViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var lettersTextFields: UITextField! // TEST VALUE: "leepadg" @ RESULT -> 680131659347
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var lettersLabel: UILabel!
    @IBOutlet weak var hashCalcButton: UIButton!
    @IBOutlet weak var lettersCalcButton: UIButton!

    
    // ---> View life cycle <--- //

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardByTouch()
        
        var customizedViews: Array<UIView> = [resultsView, lettersTextFields]
        customizeViews(views: customizedViews, type: ViewsTypes.baseview.rawValue)
        
        customizedViews = [hashLabel, lettersLabel]
        customizeViews(views: customizedViews, type: ViewsTypes.label.rawValue)
        
        customizedViews = [hashCalcButton, lettersCalcButton]
        customizeViews(views: customizedViews, type: ViewsTypes.button.rawValue)
    }
    
    
    // ---> Button action functions <--- //
    
    @IBAction func hashButtonTapped(sender: AnyObject) {
        let hashCC: HashCalculationController = HashCalculationController()
        
        if (lettersTextFields.text?.characters.count)! > 0 {
            let fieldString = lettersTextFields.text
            
            let charactersArray: Array<Character> = Array(fieldString!.characters)
            
            if hashCC.isRightCharacters(characters: charactersArray) {
                let numberResult = hashCC.createHash(s: lettersTextFields.text!.lowercased())
                
                if !String(numberResult).isEmpty {
                    hashLabel.text = String(numberResult)
                }
            } else {
                showAlert(message: "Your input string contains not acceptable character! Please remove him for success calculation.")
            }
        } else {
            showAlert(message: "Please enter a valid characters or some hash.")
        }
    }
    
    @IBAction func lettersButtonTapped(sender: AnyObject) {
        let lettersCC: LettersCalculationController = LettersCalculationController()
        var reverseResult = ""
        
        if (hashLabel.text?.characters.count)! > 0 && hashLabel.text != "Hash" {
            if isValidHash(hash: hashLabel.text!) {
                reverseResult = lettersCC.reverseHash(number: Int64(hashLabel.text!)!)
            }
        } else if (lettersTextFields.text?.characters.count)! > 0 {
            if isValidHash(hash: lettersTextFields.text!) {
                reverseResult = lettersCC.reverseHash(number: Int64(lettersTextFields.text!)!)
            }
        } else {
            showAlert(message: "Please enter a valid characters or valid hash.")
            return
        }
        
        if !reverseResult.isEmpty {
            lettersLabel.text = String(reverseResult)
        } else {
            showAlert(message: "Please enter a valid characters or calculated a valid hash.")
        }
    }
    
    
    // ---> TextField delegate functions <--- //
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
    // ---> Help functions <--- //
    
    func customizeViews(views: Array<UIView>, type: Int) {
        for view in views {
            switch type {
                case ViewsTypes.baseview.rawValue:
                    view.layer.borderWidth   = 1.5
                    view.layer.cornerRadius  = 10
                    view.layer.borderColor   = UIColor.darkGray.cgColor
                    view.layer.masksToBounds = true
                
                case ViewsTypes.label.rawValue:
                    view.layer.borderWidth   = 0.5
                    view.layer.cornerRadius  = 10
                    view.layer.borderColor   = UIColor.darkGray.cgColor
                    view.layer.masksToBounds = true
                
                case ViewsTypes.button.rawValue:
                    view.layer.borderWidth   = 0.7
                    view.layer.cornerRadius  = 20
                    view.layer.borderColor   = UIColor.darkGray.cgColor
                    view.layer.masksToBounds = true
                
                default:
                    break
            }
            
        }
    }
    
    func isValidHash(hash: String) -> Bool {
        var resultFlag = true
        
        let numbersCharacters = NSCharacterSet.decimalDigits.inverted
        
        if hash.rangeOfCharacter(from: numbersCharacters) != nil {
            showAlert(message: "Source string contained non-digit characters.")
            
            resultFlag = false
        }
        
        return resultFlag
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController {
    func hideKeyboardByTouch() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error message.",
                                                message: message,
                                                preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: UIAlertActionStyle.default,
                                                handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
