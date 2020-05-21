//
//  LoginVC.swift
//  WorkRe
//
//  Created by Akshat Gupta on 21/05/20.
//  Copyright © 2020 coded. All rights reserved.
//

import UIKit

class LoginVC: ViewController {
    @IBOutlet weak var first: UITextField!
    @IBOutlet weak var second: UITextField!
    @IBOutlet weak var third: UITextField!
    @IBOutlet weak var fourth: UITextField!
    @IBOutlet weak var fifth: UITextField!
    @IBOutlet weak var sixth: UITextField!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    
    var number : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyBtn.layer.cornerRadius = verifyBtn.bounds.height/6
        numberLabel.text = number
        
        first.delegate = self as? UITextFieldDelegate
        second.delegate = self as? UITextFieldDelegate
        third.delegate = self as? UITextFieldDelegate
        fourth.delegate = self as? UITextFieldDelegate
        fifth.delegate = self as? UITextFieldDelegate
        sixth.delegate = self as? UITextFieldDelegate


        first.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        second.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        third.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        fourth.addTarget(self, action:#selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        fifth.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        sixth.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }
    @IBAction func verifyBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "showWorkplace", sender: nil)
    }
    @objc func textFieldDidChange(textField: UITextField){

        let text = textField.text

        if (text?.utf16.count)! >= 1{
            switch textField{
            case first:
                second.becomeFirstResponder()
            case second:
                third.becomeFirstResponder()
            case third:
                fourth.becomeFirstResponder()
            case fourth:
                fifth.becomeFirstResponder()
            case fifth:
                sixth.becomeFirstResponder()
            case sixth:
                sixth.resignFirstResponder()
            default:
                break
            }
        }else{

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
extension LoginVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
