//
//  ViewController.swift
//  Kitty_blink
//
//  Created by Ł.B Morapel on 12/11/2021.
//

import UIKit

class ViewController: UIViewController {
 
    var kittyArray = [Kitty]()
    
    @IBOutlet weak var kittyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJSON {
            self.kittyTable.reloadData()
        }
        
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
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kittyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = kittyTable.dequeueReusableCell(withIdentifier: "kittyCell") as! CustomTableViewCell
        let mykitty = kittyArray[indexPath.row]
        
        
        cell.kittyLbl.text = mykitty.id
        cell.kittyImgView.image = UIImage(named: mykitty.url)
        
        return cell
    }
    }
    
    
