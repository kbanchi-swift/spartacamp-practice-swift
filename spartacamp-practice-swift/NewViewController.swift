//
//  NewViewController.swift
//  spartacamp-practice-swift
//
//  Created by 伴地慶介 on 2021/08/15.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var newItem: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAction(_ sender: Any) {
                
        let url = URL(string: "http://127.0.0.1:8000/api/items")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "name=\(newItem.text!)".data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                try JSONSerialization.jsonObject(with: data, options: [])
            } catch let error {
                print(error)
            }
        }
        task.resume()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
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
