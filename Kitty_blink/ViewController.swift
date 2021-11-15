//
//  ViewController.swift
//  Kitty_blink
//
//  Created by Ł.B Morapel on 12/11/2021.
//

import UIKit

class ViewController: UIViewController {
 
    var kittyArray = [Kitty]()
    var errorJSON = ""
    
    @IBOutlet weak var kittyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kittyTable.dataSource = self
        fireLoadJSON()
        // Time Delay for next data package
        DispatchQueue.main.asyncAfter(deadline: .now() + 19 , execute: updateJSON)
    }
    
 // FUNCIONS :
    
    //Timer
    func updateJSON() {
        let timer = Timer.scheduledTimer(
            timeInterval: 19,
            target: self,
            selector: #selector(fireLoadJSON),
            userInfo: nil,
            repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
            timer.fire()
        })
    }
    
@ objc func fireLoadJSON(){
    loadJSON {
            self.kittyTable.reloadData()
    }
}
    
     
func loadJSON (completed: @escaping () -> ()) {
  
      let urlString = "https://api.thecatapi.com/v1/images/search?limit=5"
      
      let url = URL(string: urlString)
      guard url != nil else {
              return
      }
      
      let session = URLSession.shared
      let dataTask = session.dataTask(with: url!) { [self] data, response, error in
          
          if error == nil && data != nil {
              
              // Parse JSON
              
              let decoder = JSONDecoder()
              
              do {
                  
                  self.kittyArray = try decoder.decode([Kitty].self, from: data!)
                  print(self.kittyArray)
                  DispatchQueue.main.async{
                      completed()
                  }
              }
              catch {
                
            // Information for error and when it is a case, reloaded JSON.
                self.errorJSON = "Error JSON"
                print(self.errorJSON)
                errorJSON = ""
                fireLoadJSON()
              }
          }
      }
      dataTask.resume()
   
    }
    }

//MARK: Extension of ViewControler to make custom cell.


extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kittyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = kittyTable.dequeueReusableCell(withIdentifier: "kittyCell") as! CustomTableViewCell
        let mykitty = kittyArray[indexPath.row]
        
        cell.kittyLbl.text = mykitty.id
        cell.kittyImgView.loadIMG(url: mykitty.url)
        
        return cell
    }
    }


    
    
