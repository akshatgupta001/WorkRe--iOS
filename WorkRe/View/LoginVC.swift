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
    var token : String!
    
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

        first.becomeFirstResponder()
        
        first.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        second.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        third.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        fourth.addTarget(self, action:#selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        fifth.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        sixth.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }
    @IBAction func verifyBtnPressed(_ sender: Any) {
        
        var password = "" + first.text! + second.text!
        password = password + third.text! + fourth.text!
        password = password + fifth.text! + sixth.text!
        getData(number: number!, password : password)
        
        
        
        //performSegue(withIdentifier: "showWorkplace", sender: nil)
        // segue performed only if valid login
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if(segue.identifier == "showWorkplace"){
                   let destinationVC = segue.destination as! workplaceCV
                   destinationVC.token = self.token
                   
               }
               
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
    

    func getData(number : String, password : String){
        let url = URL(string: "https://demoapi.workre.co/phone/login")!
        let req = NSMutableURLRequest(url: url)
        let request:URLRequest
        req.httpMethod = "POST"
        
        let params = ["username":number,
                 "password":password]
        //req.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
         req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        //let configuration = URLSessionConfiguration.default
        
        
        do {
               req.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
           } catch let error {
               print(error.localizedDescription)
           }
         request = req as URLRequest
        
        //create the session object
           let session = URLSession.shared
        
        //create dataTask using the session object to send data to the server
           let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

               guard error == nil else {
                   return
               }

               guard let data = data else {
                   return
               }

            if let httpStatus = response as? HTTPURLResponse {
                let status_code = httpStatus.statusCode
                if(status_code == 200){
                    do {
                              //create json object from data
                              if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                                  print(json)
                               let token_value = json["token"] as! String
                               self.token = token_value
                                DispatchQueue.main.async(execute: {
                                    self.performSegue(withIdentifier: "showWorkplace", sender: self)
                               })
                               
                               
                                  // handle json...
                              }
                          } catch let error {
                              print(error.localizedDescription)
                          }
                }
                else{
                    let alert = UIAlertController(title: "Invalid Credentials ", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    }))
                    DispatchQueue.main.async(execute: {
                         self.present(alert, animated: true)
                    })
                    //incorret credentials
                }
            }
              
           })
           task.resume()
        
            
    }

    
}

extension LoginVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
