//
//  APIManager.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 17/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit


class APIManager: NSObject {

    
    let baseURL = "https://api.jikan.moe/v3"
    static let sharedInstance = APIManager()
    static let getCharacterEndPoint = "/character/"
    
    func getCharacterWithId(characterID: Int, orImage getImage: Bool? = false, complition: @escaping([String:Any]) -> ()){
        
        var url: String = baseURL + APIManager.getCharacterEndPoint + String(characterID)
        if(getImage!){
            url = url + "/pictures"
            
        }
        let request : NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                
                complition(json)
                
                
            } catch let error as NSError {
                print(error)
            }
        })
        task.resume()
    }
    
    
}
