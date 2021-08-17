//
//  EditViewController.swift
//  spartacamp-practice-swift
//
//  Created by 伴地慶介 on 2021/08/16.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var editItemId: UILabel!
    
    @IBOutlet weak var editItem: UITextField!
    
    var id = 0
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editItemId.text = String(id)
        editItem.text = name
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editAction(_ sender: Any) {
        
        let jsonObject = ["name": editItem.text!]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            var request = URLRequest(url: URL(string: "http://127.0.0.1:8000/api/items/\(id)")!)
            request.httpMethod = "PUT"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request){ data, response, error in
                if let error = error {
                    print("Error 55 -> \(error)")
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data!)
                    print("Result 34 -> \(result)")
                } catch {
                    print("Error  43-> \(error)")
                }
            }
            task.resume()
        } catch {
            print(error)
        }
                
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        do {
            var request = URLRequest(url: URL(string: "http://127.0.0.1:8000/api/items/\(id)")!)
            request.httpMethod = "DELETE"
            let task = URLSession.shared.dataTask(with: request){ data, response, error in
                if let error = error {
                    print("Error 55 -> \(error)")
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data!)
                    print("Result 35 -> \(result)")
                } catch {
                    print("Error  43-> \(error)")
                }
            }
            task.resume()
        }
                
        dismiss(animated: true, completion: nil)
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
