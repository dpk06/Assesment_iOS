//
//  ViewController.swift
//  Assesment_iOS
//
//  Created by Developer on 21/01/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var data_TableView: UITableView!
    var rowsArray = [Rows]()
    override func viewDidLoad() {
        super.viewDidLoad()
        data_TableView.dataSource = self
        pullDownrefresh()
        callApi()
        
    }
}

//---- extension for UITableViewDataSource 

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataTableViewCell
        
        DispatchQueue.main.async {
            cell.description_Label.text = self.rowsArray[indexPath.row].description
            cell.tittle_Label.text = self.rowsArray[indexPath.row].title
            let imgUrl = self.rowsArray[indexPath.row].imageHref
        
            //---- image downlaoded through sdWeb Image
            cell.cell_ImageView?.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions.refreshCached) { (image, error, type, url) in
                if error != nil {
                    print("failed to download \(String(describing: url))  error \(error)")
                }
            }
        }
        
        return cell
    
    }
    
    
    
// ---- Rest Api Call
    
    func callApi()  {
        let url =  "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        CommonData.sharedInstance.showActivityIndicatorOnView(view: self.view)
        CommonData.sharedInstance.apiCall(serviceURL: url) { (isSuccesfull, response) in
            
            if isSuccesfull {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Json_Data.self, from: response as! Data)
                    
                    DispatchQueue.main.async {
                        self.navigationItem.title = jsonData.title ?? ""
                        //---- get the Data in rows array
                        self.rowsArray = jsonData.rows ?? []
                        self.data_TableView.reloadData()
                    }
                    
            CommonData.sharedInstance.removeActivityIndicator()
                } catch {
                    print("error----",error.localizedDescription)
                }
            }
        }
    }
    
    
// Method is For Pull Down refresh

    func pullDownrefresh(){
    
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action:
               #selector(handleRefresh(_:)),
                                    for: UIControl.Event.valueChanged)
           refreshControl.tintColor = UIColor.lightGray
        self.data_TableView.insertSubview(refreshControl, at: 0)
       }
    
       @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
           print("\(#function) pullDownrefresh ")
           self.callApi()
           refreshControl.endRefreshing()
       }
    
}
