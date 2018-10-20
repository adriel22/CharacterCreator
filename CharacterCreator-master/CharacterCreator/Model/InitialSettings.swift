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
        
        let appDelegate = UIApplication.shared.delegate as!AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        CoreDataManager.sharedInstance.fetchCharacters()
        
        if(CoreDataManager.sharedInstance.characters.count == 0){
            let character = Character(context: context)
            
            let dispachQueue = DispatchQueue(label: "requestQueue", qos: .background)
            dispachQueue.async {
                for i in 1...50{
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
                    })
                    
                    APIManager.sharedInstance.getCharacterWithId(characterID: i) { (json) in
                        if let name = (json["name"]){
                            
                            character.name = (name as! String)
                            character.anime = "Narutis"
                            character.about = "sdfsdf"
                            character.id = Int16(i)
                            character.imageURL = "picture\(i)"
                            
                            CoreDataManager.sharedInstance.saveCharacter(character: character)
                        }
                    }
                }
            }
        }
    }
}
