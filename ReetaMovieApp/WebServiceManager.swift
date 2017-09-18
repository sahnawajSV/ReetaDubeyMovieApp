//
//  WebServiceManager.swift
//  ReetaMovieApp
//
//  Created by APPLE on 15/09/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation

class WebServiceManager {
    
    static let shared = WebServiceManager()
    let session = URLSession(configuration: .default)
    
    func getData(urlString: String, completion: @escaping(Dictionary<String, Any>?,Error?) -> Void) {
        
        if let url = URL.init(string: urlString) {
            
            let urlRequest = URLRequest(url: url)
            let task = session.dataTask(with: urlRequest, completionHandler: {
                (data, response, error) in
                
                if let _ = error {
                    completion (nil, nil)
                }
                
                if let data = data {
                    
                    do {
                        if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            completion(jsonData, error)
                        }
                    }catch {}
                }
            })
            task.resume()
        }
    }
    
    func downloadImage(urlString: String, completion: @escaping(Data?,Error?) -> Void) {
        
        if let url = URL.init(string: urlString) {
            
            let urlRequest = URLRequest(url: url)
            let task = session.dataTask(with: urlRequest, completionHandler: {
                (data, response, error) in
                
                if let _ = error {
                    completion (nil, nil)
                }
                
                if let data = data {
                    completion(data, error)
                }
            })
            task.resume()
        }
    }
    
}
