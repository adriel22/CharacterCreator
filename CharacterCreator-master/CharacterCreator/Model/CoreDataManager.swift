//
//  CoreDataManager.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 17/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let sharedInstance = CoreDataManager()
    var characters: [Character] = []
    let context: NSManagedObjectContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    private init(){
        context  = appDelegate.persistentContainer.viewContext
    }
    
    func saveCharacter(withName name:String = "", fromAnime anime:String  = "", withImage imageURL: String = "", withHistory about: String = "", andID id: Int16 = 0) {
        let character = Character(context: context)
        
        character.name = name
        character.about = about
        character.id = id
        character.imageURL = imageURL
        character.anime = anime
        
        do{
            try context.save()
        } catch{
            fatalError("Failure to get context\(error)")
        }
    }
    
    func fetchCharacters(){
        
        let charactersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        
        do{
            let fetchedCharacters = try context.fetch(charactersFetch) as! [Character]
            
            self.characters = fetchedCharacters.sorted(by: { return $0.id < $1.id})
        }catch{
            fatalError("Failed to fetch character: \(error)")
        }
    }
    
    func resetCoreData() {
        
        let charactersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        
        do{
            let fetchedCharacters = try context.fetch(charactersFetch) as! [Character]
            for character in fetchedCharacters{
                context.delete(character)
            }
            try context.save()
            self.characters = []
        }catch{
            fatalError("Failed to fetch character: \(error)")
        }
    }
    
    //keep just the first 30 in the core data
    func clearCoreDataCache() {
        if(characters.count > 30){
            
            
            for character in characters[30 ... characters.count-1]{
                context.delete(character)
            }
            do{
                try context.save()
            }catch{
                fatalError("Failed to delete characters: \(error)")
            }
        }
    }
}


