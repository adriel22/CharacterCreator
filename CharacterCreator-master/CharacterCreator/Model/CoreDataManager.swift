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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    private init(){
        
    }
    
    func saveCharacter(character: Character) {
        let context = appDelegate.persistentContainer.viewContext
        let characterManegedObject = NSEntityDescription.insertNewObject(forEntityName: "Character", into: context) as! Character
        characterManegedObject.name = character.name
        characterManegedObject.anime = character.anime
        characterManegedObject.about = character.about
        characterManegedObject.id = character.id
        characterManegedObject.imageURL = character.imageURL
        
        do{
            try context.save()
        } catch{
            fatalError("Failure to get context\(error)")
        }
    }
    
    func fetchCharacters(){
        let context = appDelegate.persistentContainer.viewContext
        let charactersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        
        do{
            let fetchedCharacters = try context.fetch(charactersFetch) as! [Character]
            print(fetchedCharacters.count)
            self.characters = fetchedCharacters.sorted(by: { return $0.id < $1.id})
        }catch{
            fatalError("Failed to fetch character: \(error)")
        }
    }
    
    func resetCoreData() {
        let context = appDelegate.persistentContainer.viewContext
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
    
    func updateImageURL(fromCharacter character: Character, withURL url: String) {
        let context = appDelegate.persistentContainer.viewContext
        character.imageURL = url
        do{
            try context.save()
        }catch{
            fatalError("Failed to save context: \(error)")
        }
    }
}
