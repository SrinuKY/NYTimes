//
//  HeadlinesViewModel.swift
//  SrinuNYTimes
//
//  Created by Srinu K on 23/09/23.
//

import Foundation

class HeadlinesViewModel {
    typealias CompletionHandler = (_ success:Bool,_ headlines : NYTopHeadlines?) -> Void
    init() {
    }    
    /**
     Get data from URl and Reload Tableview
     **Discussion**
     Get the resluts from service and mapping with model
     1. Use JSONSerialization class to convert JSON to Foundation objects and convert Foundation objects to JSON. to assaign the data in jsonResult
     2. Parse into model
     3. Reloading the table view with that data. Call this method to reload all the data that is used to construct the table, including cells, section headers and footers, index arrays, and so on. For efficiency, the table view redisplays only those rows that are visible. It adjusts offsets if the table shrinks
     */
    func getDataFromUrl(urlStr : String,completionHandler: @escaping  CompletionHandler)  {
        
        let url = URL(string: urlStr)
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            data,response,error in
          
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    do {
                        let jsonDecoder = JSONDecoder()
                        if let jsonData = data {
                            if let headlines = try? jsonDecoder.decode(NYTopHeadlines.self, from: jsonData) {
                            
                     //Use GCD to invoke the completion handler on the main thread
                                completionHandler(true,headlines)
                            }
                            
                        }
                    }
                }else{
                    completionHandler(false,nil)
                }
            }
            
        }
        dataTask.resume()
        
    }
}
