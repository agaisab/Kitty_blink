//
//  ViewController.swift
//  Kitty_blink
//
//  Created by Ł.B Morapel on 12/11/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var kittyTable: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    var kittyArray = [Kitty]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJSON {
            self.kittyTable.reloadData()
        }
        
        kittyTable.delegate = self
        kittyTable.dataSource = self
    
    }
        
    
    func loadJSON (completed: @escaping () -> ()) {
    
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
                    
                    self.kittyArray = try decoder.decode([Kitty].self, from: data!)
                    
                    print(self.kittyArray)
                    DispatchQueue.main.async{
                        completed()
                    }
                }
                catch {
                    print("Error JSON")
                }
            }
        }
        
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kittyArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = kittyArray[indexPath.row].id.capitalized
        return cell
    }
    
}
