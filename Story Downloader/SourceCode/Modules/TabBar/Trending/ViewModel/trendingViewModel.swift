//
//  trendingViewModel.swift
//  Story Downloader
//
//  Created by Christina Santana on 4/11/22.
//

//import Foundation
//import UIKit
//struct trendingViewModel{
//    
//    func getTrending(query: String, comp:@escaping(TrendingModel)->()){
//        let headers = [
//            "X-RapidAPI-Key": "e9a9788f52msh4c925f222a786e6p1ec230jsnfad6eceba839",
//            "X-RapidAPI-Host": "instagram188.p.rapidapi.com"
//        ]
//        
//        let request = NSMutableURLRequest(url: NSURL(string: "https://instagram188.p.rapidapi.com/searchuser/\(query)")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//        
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                do{
//                    let result = try JSONSerialization.jsonObject(with: data!, options:[])
//                    print("JSON: ", result)
//                   
//            }catch{
//                print(error)
//            }
//                //                let httpResponse = response as? HTTPURLResponse
//                //                print(httpResponse)
//            }
//        })
//        
//        dataTask.resume()
//        
//    }
//

//
//func getTopUser(query: String, comp:@escaping(TrendingModel)->()){
//
//    let url = URL(string: "https://instagram188.p.rapidapi.com/searchuser/\(query)")!
//    let task = URLSession.shared.dataTask(with: url){ data, response, error in
//        if let error = error { print(error); return }
//        if (error != nil) {
//            print(error)
//        } else {
//            do{
//                let userData = try JSONDecoder().decode(TrendingModel.self, from: data!)
//                let profilePic = userData.data.map(\.user.profilePicURL)
//                let group = DispatchGroup()
//                for pic in profilePic {
//                    group.enter()
//                    URLSession.shared.dataTask(with: pic)
//                    { data, response, error in defer {group.leave()}
//                        if let error = error {print(error); return}
//                        if let image = UIImage(data: data!){
//                            self.images.append(image)
//                        }
//                    }  .resume()
//                    
//                };group.notify(queue: .main) {
//                    self.collectionView.reloadData()}
//               
//        }catch{
//            print(error)
//        }
//            //                let httpResponse = response as? HTTPURLResponse
//            //                print(httpResponse)
//        }
//    })
//    
//    dataTask.resume()
//    
//}




