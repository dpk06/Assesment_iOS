//
//  ApiCallManagerTest.swift
//  Assesment_iOSTests
//
//  Created by Developer on 27/01/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import XCTest
@testable import Assesment_iOS

class customError : Error {
    
}

class MockURLSession: URLSession {
    var cachedUrl: URL?
    
    private var mockTask: MockTask!
    public var timeout = 0
    
    
    
    override init() {
        super.init()
    }
    
    
    func data(data: Data?, urlResponse: URLResponse?, error: Error?) {
        
        let httpResponse = urlResponse as? HTTPURLResponse
        let error1 = customError()
        
        
        
        if(httpResponse?.statusCode != 200) {
            mockTask = MockTask(data: data, urlResponse: urlResponse, error:
                error1)
        }
            
        else {
            mockTask = MockTask(data: data, urlResponse: urlResponse, error:
                error)
        }
        
        
    }
     
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockTask {
        if(self.timeout == 1) {
            sleep(5);
            print("after sleep")
        }
        mockTask.completionHandler = completionHandler
        return mockTask
    }
    
}

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let error1: Error?
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.error1 = error
        super .init()
    }
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler(self.data, self.urlResponse, self.error1)
        }
    }
}


extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}

class ViewControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testApicall() {
        let jsonData = "{\n\"title\":\"About Canada\",\n\"rows\":[\n\t{\n\t\"title\":\"Beavers\",\n\t\"description\":\"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony\",\n\t\"imageHref\":\"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg\"\n\t},\n\t{\n\t\"title\":\"Flag\",\n\t\"description\":null,\n\t\"imageHref\":\"http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png\"\n\t}\n]\n}".data(using: .utf8)
        
        guard let url = URL(string: "http://testUrl") else { return }
        let httpResponse: HTTPURLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1.0", headerFields: [:])!
        
        
        let apiCallMn : ApicallManager = ApicallManager()
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 2
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.httpAdditionalHeaders = ["Cache-Control" : "no-cache"]
        
        let mockURLSession  = MockURLSession();
        //mockURLSession.timeout = 1
        mockURLSession.data(data: jsonData, urlResponse: httpResponse, error: nil)
        apiCallMn.checkSession(urlsession: mockURLSession)
        
        wait(for: 3)
        XCTAssert(true)
        
    }

}
