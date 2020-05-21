//
//  workplaceCV.swift
//  WorkRe
//
//  Created by Akshat Gupta on 21/05/20.
//  Copyright © 2020 coded. All rights reserved.
//

import UIKit

class workplaceCV: ViewController, UITableViewDelegate, UITableViewDataSource{
    
    let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4ODc5MTE2NzQwIiwiaXNzIjoid29ya3JlLnRycm9oaXRoLmNvbSIsInJvbGUiOiJ1c2VyIiwidWlkIjo3MSwiY29udGFjdCI6IjEyMzQ1Njc4OTAiLCJpYXQiOjE1OTAwODAzMTUsImV4cCI6MTU5MDI1MzExNX0.jOTe7GhJYOnxeEUbDTHTdxXxQcVa7H7pCCeKijTNuyU"
    
    var cafes :[String] = []
    var addresses: [String] = []
    
    @IBOutlet weak var workplaceTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ncell = workplaceTableView.dequeueReusableCell(withIdentifier: "workplace", for: indexPath) as! workplaceTableViewCell
               ncell.cafe_name.text = cafes[indexPath.row]
        
               return ncell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        workplaceTableView.delegate = self
        workplaceTableView.dataSource = self
        
        workplaceTableView.register(workplaceTableViewCell.self, forCellReuseIdentifier: "workplace")
        workplaceTableView.register(UINib(nibName: "workplaceTableViewCell", bundle: nil), forCellReuseIdentifier: "workplace")
        getData()
        
        // Do any additional setup after loading the view.
    }
    

    func getData(){
        let url = URL(string: "https://demoapi.workre.co/workplace")!
        let req = NSMutableURLRequest(url: url)
        let request:URLRequest
        req.httpMethod = "GET"
        //req.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        // req.setValue("application/json", forHTTPHeaderField: "Accept")
        //let configuration = URLSessionConfiguration.default
        req.setValue(token, forHTTPHeaderField: "Authorization")
        request = req as URLRequest
        
        URLSession.shared.dataTask(with: request) { (data, response, err) -> Void  in
            
            
            if(err == nil){
                do{
                    let data: Data = data! // received from a network request, for example
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    var i = 0
                    if let places = json?["arrayWorkplace"] as? [Any]{
                        for place in places{
                            i = i+1
                            if let place = place as? [String:Any]{
                              
                                let name = place["name"]
                                let address = place["address"]
                                self.cafes.append(name! as! String)
                                self.addresses.append(address! as! String)
                                
                                // self.fields.append(record as! [String])
                                
                                
                            }
                        }//end of for user
                        print(self.cafes.count)
                        
                        DispatchQueue.global().async { [weak self] in
                            DispatchQueue.main.async {
                                
                                self?.workplaceTableView.reloadData()
                                
                            }
                        }
                        
                    }//end of if let user
                    
                }
                catch{
                    print("captcha error: \(err.debugDescription)")
                }
            }else{
                print("data not found error : \(err.debugDescription)")
            }
            }.resume()
        
    }

}
