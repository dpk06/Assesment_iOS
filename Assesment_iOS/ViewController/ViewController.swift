//
//  ViewController.swift
//  Assesment_iOS
//
//  Created by Developer on 21/01/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var data_TableView: UITableView!
    var rowsArray = [Rows]()
    override func viewDidLoad() {
        super.viewDidLoad()
        data_TableView.dataSource = self
        
        callApi()
    }
    
    
}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataTableViewCell
        cell.description_Label.text = rowsArray[indexPath.row].description
        cell.tittle_Label.text = rowsArray[indexPath.row].title
        
        
        return cell
    }
    
    func callApi()  {
        let url =  "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        CommonData.sharedInstance.apiCall(serviceURL: url) { (isSuccesfull, response) in
            
            if isSuccesfull {
                do {
                    //                let serilization = try JSONSerialization.jsonObject(with: decodedData ?? Data(), options: .mutableLeaves)
                    //                print("serilization----",serilization)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Json_Data.self, from: response as! Data)
                    
                    DispatchQueue.main.async {
                        self.rowsArray = jsonData.rows ?? []
                        self.data_TableView.reloadData()
                    }
                } catch {
                    print("error")
                }
            }
        }
    }
    
}
