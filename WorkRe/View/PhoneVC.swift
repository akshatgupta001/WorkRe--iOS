//
//  PhoneVC.swift
//  WorkRe
//
//  Created by Akshat Gupta on 21/05/20.
//  Copyright © 2020 coded. All rights reserved.
//

import UIKit

class PhoneVC: ViewController {
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tel_number: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = loginBtn.bounds.height/6
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        // Do any additional setup after loading the view.
    }
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -250 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
            
        performSegue(withIdentifier: "showLogin", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showLogin"){
            let destinationVC = segue.destination as! LoginVC
            destinationVC.number = tel_number.text
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
