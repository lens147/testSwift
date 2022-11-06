//
//  apiGif.swift
//  testViewGif
//
//  Created by Leny Bonaton on 30/09/2022.
//
/*
import UIKit
import WebKit

class ApiGif{
    
    /**
     Apikey = "AIzaSyAwp89d_YVks_jV_Ha8z96eqdJ0DHmDPIE"
     */
//    @IBOutlet weak var webview: UIWebView!
    let apikey = "LIVDSRZULELA"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        requestData()

        return true
      }

      /**
       Execute web request to retrieve the top GIFs returned(in batches of 8) for the given search term.
       */
      func requestData()
      {
        // the test search term

        // Define the results upper limit

        // make initial search request for the first 8 items
/**          webview.loadRequest(NSURLRequest(url: URL(string: (format: "https://g.tenor.com/v1/search?q=%@&key=%@&limit=%d",
                                                             searchTerm,
                                                             apikey,
                                                             limit))!) */
        let searchRequest = URLRequest(url: URL(string: String(format: "https://g.tenor.com/v1/trending?q=%@&key=",
                                                                 apikey))!)
          
        makeWebRequest(urlRequest: searchRequest, callback: tenorSearchHandler)

        // Data will be loaded by each request's callback
      }

      /**
       Async URL requesting function.
       */
      func makeWebRequest(urlRequest: URLRequest, callback: @escaping ([String:AnyObject]) -> ())
      {
        // Make the async request and pass the resulting json object to the callback
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
          do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] {
              // Push the results to our callback
                
                for gif in jsonResult {
                    let gif2 = gif as! NSDictionary
                    print(gif2["url"]!)
                }
                
              callback(jsonResult)
            }
          } catch let error as NSError {
            print(error.localizedDescription)
          }
        }
        task.resume()
      }

      /**
       Web response handler for search requests.
       */
      func tenorSearchHandler(response: [String:AnyObject])
      {
        // Parse the json response
        let responseGifs = response["url"]!

        // Load the GIFs into your view
        print("Result GIFS: (responseGifs)")

      }
}

*/


//
//  BeerApi.swift
//  ApiPractice

import Alamofire
import SwiftyJSON
import PromiseKit

class ApiGif {
   
   //Fonction static pour ne pas a avoir a l'instancier a chaque fois qu'on veux la call
   static func getGifs() -> Promise<[Gif]> {
       var gifs: [Gif] = []
       
       // Gestion de l'asynchrone, on retourne une promesse
       return Promise { seal in
           
           // On fait l'appel dans la promesse
           AF.request("https://g.tenor.com/v1/trending?key=LIVDSRZULELA").response { response in
               
               
               let json = try? JSON(response.data)
               
               if let gifsJSON = json?.dictionary?["results"]?.arrayValue {
                   for itemGif in gifsJSON {
                       
                       if let dims = itemGif.dictionaryValue["media"]?.arrayValue[0].dictionaryValue["gif"]?.dictionaryValue["dims"]?.arrayValue {
                           var dimension: [Int] = []
                           for item in dims {
                               dimension.append(item.intValue)
                           }
                           gifs.append(Gif(url: itemGif["itemUrl"].stringValue, dims: dimension))
                       }
                      
                   }
               }
               
               seal.fulfill(gifs)
           }
       }
   }
}
