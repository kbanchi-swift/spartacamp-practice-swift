//
//  ListViewController.swift
//  spartacamp-practice-swift
//
//  Created by 伴地慶介 on 2021/08/15.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllItems()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = self.nameArray[indexPath.row]
        return cell
    }
    
    func getAllItems() {
        
        // init array
        self.nameArray.removeAll()
        
        // request url
        let url: URL = URL(string: "http://127.0.0.1:8000/api/items/all")!
        
        // request by URLSession
        let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                // parse to json
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                // cast to String:Any array
                let items = json.map { (item) -> [String: Any] in
                    return item as! [String: Any]
                }
                // set count
                let count = items.count
                // get name
                for i in 0...count-1 {
                    let name = items[i]["name"] as! String
                    self.nameArray.append(name)
                }
                // reload table view
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
            catch {
                print(error)
            }
        })
        task.resume()
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
