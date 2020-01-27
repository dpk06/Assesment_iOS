//
//  CommonDataFile.swift
//  Assesment_iOS
//
//  Created by Developer on 21/01/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import Foundation
import UIKit

class ApicallManager: NSObject {
    
     private var sharedSession: URLSession!
     static let sharedInstance = ApicallManager ()
     var activityIndicator = UIActivityIndicatorView()
   
    
       override init() {
        
      
       let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.timeoutIntervalForResource = 60
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.httpAdditionalHeaders = ["Cache-Control" : "no-cache"]
        self.sharedSession = URLSession(configuration: config)
        
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = UIActivityIndicatorView.Style.large
        super .init()
    }
    
    public func checkSession(urlsession: URLSession){
        self.sharedSession = urlsession
    }
    
    //----- Add / remove Activity indicators method

    func showActivityIndicatorOnView (view : UIView) {
        self.activityIndicator.center = view.center
                activityIndicator.startAnimating()
//                UIApplication.shared.beginIgnoringInteractionEvents()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator () {
        DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                   self.activityIndicator.removeFromSuperview()
            
        }
    }
 
//----  Get Api call request
    
    func apiCall(serviceURL : String, completionBlock : @escaping (_ successful:Bool, _ responseData : Any) -> ()) {
        guard let url = URL(string: "\(serviceURL)") else { return }
        print("url is-->> \(url)")
        let dataTask = sharedSession.dataTask(with: url,
                                              completionHandler: { (data, response, error) in
                                                guard error == nil else {
                                                    print ("error: \(error!)")
                                                    completionBlock(false,error ?? "error")
                                                    return
                                                }
                                                
                                                guard let content = data else {
                                                    completionBlock(false,"error no data")
                                                    return
                                                }
                                  // Convert Data to string using isoLatin2
                                                
                                                let strData = String(data: content, encoding: .isoLatin2)
                                                
                                                guard let decodedData = strData?.data(using: .utf8) else {
                                                    completionBlock(false,"error no data")
                                                    return
                                                }
                                                completionBlock(true,decodedData)
        })
        dataTask.resume()
    }
    
}




