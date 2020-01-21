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
//        config.timeoutIntervalForRequest = 60
//        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
//        config.httpAdditionalHeaders = ["Cache-Control" : "no-cache"]
        return URLSession(configuration: config)
    }
    
    class func getStringFromData(data: Data) -> String? {
        guard let str = String(data: data, encoding: .utf8) else { return nil }
        return str
    }
    
    
    
    func apiCall(url : String){
        
//        var semaphore = DispatchSemaphore (value: 0)
//
//        var request = URLRequest(url: URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!,timeoutInterval: Double.infinity)
//        request.httpMethod = "POST"
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          guard let data = data else {
//            print(String(describing: error))
//            return
//          }
//          print(String(data: data, encoding: .utf8)!)
//             semaphore.signal()
//        }
//
//        task.resume()
//
//        semaphore.wait()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let url = URL(string: url)!

        var request = URLRequest(url: url)
                   request.httpMethod = "GET"
//                   request.httpBody = data
                   request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                //   request.addValue("application//plain", forHTTPHeaderField: "Accept")



        let task = session.dataTask(with: request) { data, response, error in

            // ensure there is no error for this HTTP response


            guard error == nil else {
                print ("error: \(error!)")
                return
            }

            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            print("Mime type",content.base64EncodedString())
//            let decodedData = NSData(base64EncodedString: content.base64EncodedString(), options: )
//            let decodedString = NSString(data: decodedData, encoding: NSUTF8StringEncoding)
//            print(decodedString) // my plain data
            print("Response ---",CommonData.getStringFromData(data: content))
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }

            print("gotten json response dictionary is \n \(json)")
            // update UI using the response here
        }

//         execute the HTTP request
        task.resume()
    }
    
    
    
//    func apiCall(serviceURL : String, completionBlock : @escaping (_ successful:Bool,_ response:Any?) -> ()) {
//
//        guard let url = URL(string: "\(serviceURL)") else { return }
//        print("url is-->> \(url)")
//        let dataTask = sharedSession.dataTask(with: url,
//                                              completionHandler: { (data, response, error) in
//
//
//                                                if error == nil {
//                                                    print("completion block done")
//                                                    //                                                    if AppCommonData.getJSONObject(data: data!) != nil
//                                                    print("\(String(describing: response))")
//
//
//                                                    print(" \(#function) : Success \n \(String(describing: CommonData.getStringFromData(data: data!)))")
//
//                                                    //                                                        print("\(#function) : Success \n \(AppCommonData.getJSONObject(data: data!)!)")
//                                                    DispatchQueue.main.async {
//                                                        //                                                        completionBlock(true,(Apicall.getJSONObject(data: data!)))
//                                                        completionBlock(true,(CommonData.getStringFromData(data: data!)))
//                                                    }
//                                                    //                                                    }else
//                                                    //                                                    {
//                                                    //                                                        completionBlock(false,"Somethig went wrong")
//                                                    //                                                    }
//
//                                                } else {
//
//                                                    print("\(#function) : failed (\(error?.localizedDescription ?? "No error"))")
//                                                    DispatchQueue.main.async {
//
//                                                        completionBlock(false,(error?.localizedDescription ?? "No error"))
//                                                    }
//                                                }
//        })
//        dataTask.resume()
//    }
    
    
//    func makeGetCall(url:String) {
//      // Set up the URL request
//      let todoEndpoint: String = url
//      guard let url = URL(string: todoEndpoint) else {
//        print("Error: cannot create URL")
//        return
//      }
//      let urlRequest = URLRequest(url: url)
//      // set up the session
//      let config = URLSessionConfiguration.default
//      let session = URLSession(configuration: config)
//      // make the request
//      let task = session.dataTask(with: urlRequest) {
//        (data, response, error) in
//        // check for any errors
//        guard error == nil else {
//          print("error calling GET on /todos/1")
//          print(error!)
//          return
//        }
//        // make sure we got data
//        guard let responseData = data else {
//          print("Error: did not receive data")
//          return
//        }
//        // parse the result as JSON, since that's what the API provides
//        do {
//          guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
//            as? [String: Any] else {
//              print("error trying to convert data to JSON")
//              return
//          }
//          // now we have the todo
//          // let's just print it to prove we can access it
////          print("The todo is: " + todo.description)
////          // the todo object is a dictionary
////          // so we just access the title using the "title" key
////          // so check for a title and print it if we have one
////          guard let todoTitle = todo["title"] as? String else {
////            print("Could not get todo title from JSON")
////            return
////          }
////          print("The title is: " + todoTitle)
//        } catch  {
//          print("error trying to convert data to JSON")
//          return
//        }
//      }
//      task.resume()
//    }

}
