//
//  HTTPClient.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation

protocol HTTPClientProtocol {
    func requestCustomers(completed: @escaping ([CustomerDTO]?, Error?) -> Void)
}

class HTTPClient: NSObject, HTTPClientProtocol {
    
    func requestCustomers(completed: @escaping ([CustomerDTO]?, Error?) -> Void) {
        //We set the authentication field
        let authenticationString = "\(NetworkConstants.username):\(NetworkConstants.password)"
        let authenticationData = authenticationString.data(using: String.Encoding.ascii)
        let authenticationValue = authenticationData!.base64EncodedString()
        
        var request = URLRequest(url: URL(string:NetworkConstants.url)!)
        request.setValue("Basic \(authenticationValue)", forHTTPHeaderField: "Authorization")
        
        //We disable cache
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        let session = URLSession.init(configuration: configuration)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                guard let data = data else {
                    throw SerializationError.missing("Data")
                }
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue: 0))
                guard let dictionary = jsonObject as? [String: Any] else {
                    DispatchQueue.main.async {
                        completed(nil, error)
                    }
                    return
                }
                
                guard let queueDataJSON = dictionary["queueData"] as? [String: Any],
                    let queueJSON = queueDataJSON["queue"] as? [String: Any],
                    let customersTodayJSON = queueJSON["customersToday"] as? [[String:Any]]
                    else {
                        throw SerializationError.missing("customersToday")
                }
                
                var resultsDTO = [CustomerDTO]()
                for customerDict in customersTodayJSON {
                    if let customer = try CustomerDTO(json: customerDict) {
                        resultsDTO.append(customer)
                    }
                }
                
                DispatchQueue.main.async {
                    completed(resultsDTO, error)
                }
                
            }catch let error as NSError {
                DispatchQueue.main.async {
                    completed(nil, error)
                }
            }
        }
        
        task.resume()
    }
}
