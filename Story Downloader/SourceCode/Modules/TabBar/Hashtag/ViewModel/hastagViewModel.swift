//
//  hastagViewModel.swift
//  Story Downloader
//
//  Created by Christina Santana on 1/11/22.
//

import Foundation

import Foundation

struct HashtagViewModel{
    
    
    func getHashtag(query:String, comp:@escaping(HashtagModel)->()){
        let headers = [
            "X-RapidAPI-Key": "e9a9788f52msh4c925f222a786e6p1ec230jsnfad6eceba839",
            "X-RapidAPI-Host": "hashtagy-generate-hashtags.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://hashtagy-generate-hashtags.p.rapidapi.com/v1/custom_1/tags?keyword=\(query)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                do{
                    let result = try JSONDecoder().decode(HashtagModel.self, from: data!)
                    print("JSON: ", result)
                    comp(result)
                    
                } catch {
                    print(error)
                }
                
                
            }
        })
        
        dataTask.resume()
    }

    
    
}
    



