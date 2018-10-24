//
//  InitialSettings.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 20/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit
class InitialSettings {
    
    //Called in AppDelegate
    static func firstRequest(){
    
        
        CoreDataManager.sharedInstance.fetchCharacters()
        
        if(CoreDataManager.sharedInstance.characters.count == 0){
            
            APIManager.sharedInstance.isRequesting = true
            
            

            DispatchQueue.main.async {
                for i in 1...30{
                    APIManager.sharedInstance.dispatchGroup.enter()
                    APIManager.sharedInstance.getCharacterWithId(characterID: i, orImage: true, complition: { (json) in
                        
                        if let pictures = (json["pictures"] as? [[String:Any]]){
                            if(pictures.count > 0){
                                let pictureURL = pictures[0]["small"] as! String
                                let url = URL(string: pictureURL)
                                do{
                                    let data = try Data(contentsOf: url!)
                                    let characterImage = CharacterImage(image: data)
                                    Storage.store(characterImage, to: .documents, as: "picture\(i)")
                                }catch{
                                    print("Error saving pictures in file manager")
                                }
                            }
                        }
                        APIManager.sharedInstance.dispatchGroup.leave()
                    })
                    
                    
                    APIManager.sharedInstance.dispatchGroup.enter()
                    APIManager.sharedInstance.getCharacterWithId(characterID: i) { (json) in
                        if let name = (json["name"]){
                            let animeography = json["animeography"] as! [[String:Any]]
                            let anime = animeography[0]["name"] as! String
                            let name = (name as! String)
                            let about = json["about"] as! String
                            let id = Int16(i)
                            let imageURL = "picture\(i)"
                            
                            CoreDataManager.sharedInstance.saveCharacter(withName: name, fromAnime: anime, withImage: imageURL, withHistory: about, andID: id)
                            
                        }
                        APIManager.sharedInstance.dispatchGroup.leave()
                    }
                 
                }
                
                APIManager.sharedInstance.dispatchGroup.notify(queue: .main){
                    print("Finished")
                       APIManager.sharedInstance.isRequesting = false
                }
            }
//            APIManager.sharedInstance.isRequesting = false
        }
    }
}
