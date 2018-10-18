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
            self.characters.append(contentsOf: fetchedCharacters)
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
        }catch{
            fatalError("Failed to fetch character: \(error)")
        }
    }
}
