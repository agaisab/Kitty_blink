//
//  ViewController.swift
//  Kitty_blink
//
//  Created by Ł.B Morapel on 12/11/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlString = "https://api.thecatapi.com/v1/images/search?limit=5"
        
        let url = URL(string: urlString)
        guard url != nil else {
                return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // Parse JSON
                
                let decoder = JSONDecoder()
                
                do{
                    
                let myKitty = try decoder.decode([Kitty].self, from: data!)
                    
                    print(myKitty)
                    
                }
                catch {
                    print("Error JSON")
                }
            }
        }
        
        dataTask.resume()
    }
}
