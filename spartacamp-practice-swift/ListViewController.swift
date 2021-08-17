//
//  ListViewController.swift
//  spartacamp-practice-swift
//
//  Created by 伴地慶介 on 2021/08/15.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray: [[String:Any]] = []
    
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
        let id = self.nameArray[indexPath.row]["id"] as? Int
        let name = self.nameArray[indexPath.row]["name"] as? String
        cell.textLabel!.text = "\(id!) : \(name!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "EditViewController", sender: self.nameArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditViewController" {
            let editVC = segue.destination as! EditViewController
            let item = sender as? [String : Any]
            editVC.id = item!["id"] as! Int
            editVC.name = item!["name"] as! String
        }
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
                    let id = items[i]["id"] as! Int
                    let name = items[i]["name"] as! String
                    self.nameArray.append([
                        "id": id,
                        "name": name
                    ])
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
