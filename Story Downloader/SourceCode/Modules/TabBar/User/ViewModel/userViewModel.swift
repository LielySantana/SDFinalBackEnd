//
//  userViewModel.swift
//  Story Downloader
//
//  Created by Christina Santana on 8/11/22.


import Foundation
import UIKit
struct UserViewModel{
        
    func getStories(query: Int, comp:@escaping(StoriesModel)->()){
            let headers = [
                "X-RapidAPI-Key": "e9a9788f52msh4c925f222a786e6p1ec230jsnfad6eceba839",
                "X-RapidAPI-Host": "instagram188.p.rapidapi.com"
            ]
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://instagram188.p.rapidapi.com/userstories/\(query)")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            print("https://instagram188.p.rapidapi.com/userstories/\(query)")
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    do{
                        let result = try JSONDecoder().decode(StoriesModel.self, from: data!)
                        print(result)
                        comp(result)
                    }catch{
                        print(error)
                    }
                }
            })
            
            dataTask.resume()
            
        
        }
        
    }
