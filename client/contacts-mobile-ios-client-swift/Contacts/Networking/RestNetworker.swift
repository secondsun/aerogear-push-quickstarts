/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

class RestNetworker: NSObject, NSURLSessionDelegate {
    
    struct RestNetworkerError {
        static let RestNetworkerErrorDomain = "RestNetworkerErrorDomain"
        static let NetworkOperationFailingURLRequestErrorKey = "AGNetworkingOperationFailingURLRequestErrorKey"
        static let NetworkOperationFailingURLResponseErrorKey = "AGNetworkingOperationFailingURLResponseErrorKey"
    }
    
    let serverURL: NSURL
    let session: NSURLSession!
    
    init(serverURL: NSURL) {
        self.serverURL = serverURL;

        super.init()
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.HTTPAdditionalHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
        
        self.session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    }
    
    func GET(resource: String, parameters: AnyObject!, completionHandler: ((NSURLResponse!, AnyObject!, NSError!) -> Void)!) -> NSURLSessionDataTask {
        
        let request = NSMutableURLRequest(URL: serverURL.URLByAppendingPathComponent(resource))
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        
        // serialize request
        if parameters {
            let postData = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted, error:nil)
            request.HTTPBody = postData
        }
        
        let task = dataTaskWithRequest(request, completionHandler);
        task.resume()
        
        return task
    }
    
    func POST(resource: String, parameters: AnyObject!, completionHandler: ((NSURLResponse!, AnyObject!, NSError!) -> Void)!) -> NSURLSessionDataTask {
        
        let request = NSMutableURLRequest(URL: serverURL.URLByAppendingPathComponent(resource))
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        
        // serialize request
        if parameters {
            let postData = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted, error:nil)
            request.HTTPBody = postData
        }
        
        let task = dataTaskWithRequest(request, completionHandler);
        task.resume()
        
        return task
    }
    
    func PUT(resource: String, parameters: AnyObject!, completionHandler: ((NSURLResponse!, AnyObject!, NSError!) -> Void)!) -> NSURLSessionDataTask {
        
        let request = NSMutableURLRequest(URL: serverURL.URLByAppendingPathComponent(resource))
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "PUT"
        
        // serialize request
        if parameters {
            let postData = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted, error:nil)
            request.HTTPBody = postData
        }
        
        let str = NSString(data: request.HTTPBody, encoding: NSUTF8StringEncoding)
        
        let task = dataTaskWithRequest(request, completionHandler);
        task.resume()
        
        return task
    }
    
    func DELETE(resource: String, parameters: AnyObject!, completionHandler: ((NSURLResponse!, AnyObject!, NSError!) -> Void)!) -> NSURLSessionDataTask {
        
        let request = NSMutableURLRequest(URL: serverURL.URLByAppendingPathComponent(resource))
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "DELETE"
        
        // serialize request
        if parameters {
            let postData = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted, error:nil)
            request.HTTPBody = postData
        }
        
        let task = dataTaskWithRequest(request, completionHandler);
        task.resume()
        
        return task
    }

    func dataTaskWithRequest(request: NSURLRequest,
        completionHandler: ((NSURLResponse!, AnyObject!, NSError!) -> Void)!) -> NSURLSessionDataTask! {
            
            let task = session.dataTaskWithRequest(request) {(data, response, error) in
                if !error {
                    let httpResp = response as NSHTTPURLResponse
                    
                    var result: AnyObject?
                    
                    if httpResp.statusCode == 200 || httpResp.statusCode == 204 /* No content */ { // if success
                        if data.length > 0 {  // if there is actual response, try to deserialize from json
                           result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:nil)
                            
                            let json = NSString(data: data, encoding: NSUTF8StringEncoding)
                        }
                        
                        completionHandler(response, result, error);
                        
                    } else { // bad response
                        let userInfo = [NSLocalizedDescriptionKey : NSHTTPURLResponse.localizedStringForStatusCode(httpResp.statusCode),
                            RestNetworkerError.NetworkOperationFailingURLRequestErrorKey: request,
                            RestNetworkerError.NetworkOperationFailingURLResponseErrorKey: response];
                        
                        let error = NSError(domain:RestNetworkerError.RestNetworkerErrorDomain, code: NSURLErrorBadServerResponse, userInfo: userInfo)
                        
                        completionHandler(response, nil, error);
                    }
                    
                } else { // an error has occured
                    completionHandler(response, nil, error);
                }
            }
            
            return task
    }
}