//
//  searchViewModel.swift
//  Story Downloader
//
//  Created by Christina Santana on 1/11/22.
//

import Foundation
import UIKit
struct searchViewModel{
    
    func getSearch(query: String, comp:@escaping(SearchModel)->()){
        
        let headers = [
            "X-RapidAPI-Key": "e9a9788f52msh4c925f222a786e6p1ec230jsnfad6eceba839",
            "X-RapidAPI-Host": "instagram-scraper-2022.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://instagram-scraper-2022.p.rapidapi.com/ig/search/?user=\(query)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                do{
                   
                    let results = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers)
//                    print("JSON: ", results)
//                    
                    let result = try JSONDecoder().decode(SearchModel.self, from: data!)
                    
                    
//                    var dataToPrint = result.data[0].user.username
//                    print("JSON: ", dataToPrint)
//                    print("=====================")
                    comp(result)
//                    comp(result as! SearchModel)
                }catch{
                    print(error)
                }
                //                let httpResponse = response as? HTTPURLResponse
                //                print(httpResponse)
            }
        })
        
        dataTask.resume()
        
    }
    
}
