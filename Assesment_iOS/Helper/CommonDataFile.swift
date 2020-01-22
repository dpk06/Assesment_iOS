//
//  CommonDataFile.swift
//  Assesment_iOS
//
//  Created by Developer on 21/01/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import Foundation

class CommonData: NSObject {
    
    static let sharedInstance = CommonData ()
    
    private override init() {
        super .init()
    }
    
    private var sharedSession: URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.httpAdditionalHeaders = ["Cache-Control" : "no-cache"]
        return URLSession(configuration: config)
    }
    
    class func getStringFromData(data: Data) -> String? {
        guard let str = String(data: data, encoding: .utf8) else { return nil }
        return str
    }
    
    
    
    func apiCall(url : String){

        let url = URL(string: url)!

        var request = URLRequest(url: url)
                   request.httpMethod = "GET"
        let task = sharedSession.dataTask(with: url) { data, response, error in

            guard error == nil else {
                print ("error: \(error!)")
                return
            }

            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            let strData = String(data: content, encoding: .isoLatin2)
            let decodedData = strData?.data(using: .utf8)
            do {
//                let serilization = try JSONSerialization.jsonObject(with: decodedData ?? Data(), options: .mutableLeaves)
//                print("serilization----",serilization)
                let decoder = JSONDecoder()
                let json = try decoder.decode(Json_Data.self, from: decodedData!)
                print("json----",json.title ?? "")
            } catch {
                print("error")
            }
        }
        task.resume()
    }
    
    
    
    
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
