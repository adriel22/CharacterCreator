//
//  GetInspirationsViewController.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 16/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class GetInspirationsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = UIScreen.main.bounds.width
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        let cellWidth = (screenWidth-60) / 2
        layout.itemSize = CGSize(width: cellWidth, height: 200)
        
        CoreDataManager.sharedInstance.fetchCharacters()
        print("Is requesting? \(APIManager.sharedInstance.isRequesting)")
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gotoLoading"){
            let screen = segue.destination as! LoadingViewController
            screen.delegate = self
        }
    }
}

extension GetInspirationsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CoreDataManager.sharedInstance.fetchCharacters()
        
        if(APIManager.sharedInstance.isRequesting){
            performSegue(withIdentifier: "gotoLoading", sender: self)
            //print("ok")
        }
        return CoreDataManager.sharedInstance.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        CoreDataManager.sharedInstance.fetchCharacters()
        cell.characterImage.image = UIImage(named: "user")
        
        if(!APIManager.sharedInstance.isRequesting){
            let character = CoreDataManager.sharedInstance.characters[indexPath.row]
            cell.characterName.text = character.name
            
            DispatchQueue.main.async {
                let data = Storage.retrieve(character.imageURL!, from: .documents, as: CharacterImage.self)
                cell.characterImage.image = UIImage(data: data.image)
                
            }
            
        }
        
        cell.layer.borderWidth = 1
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if(indexPath.row == numberOfCells - 2){
//            if(numberOfCells <= CoreDataManager.sharedInstance.characters.count - 10){
//                numberOfCells = numberOfCells + 10
//                while(APIManager.sharedInstance.isRequesting){
//                    print("Waiting requests to be fisinhed")
//                }
//
//                collectionView.reloadData()
//
//            }else{
//                while(APIManager.sharedInstance.isRequesting){
//                    print("Wating to requests be finished")
//                }
//                let myGroup = DispatchGroup()
//                APIManager.sharedInstance.isRequesting = true
//
//                let appDelegate = UIApplication.shared.delegate as!AppDelegate
//                let context = appDelegate.persistentContainer.viewContext
//                CoreDataManager.sharedInstance.fetchCharacters()
//
//                let character = Character(context: context)
//                CoreDataManager.sharedInstance.fetchCharacters()
//                let lastId = Int(CoreDataManager.sharedInstance.characters.last!.id)
//
//                DispatchQueue.main.async {
//                    for i in lastId+1...lastId+11{
//                        myGroup.enter()
//                        APIManager.sharedInstance.getCharacterWithId(characterID: i, orImage: true, complition: { (json) in
//
//                            if let pictures = (json["pictures"] as? [[String:Any]]){
//                                if(pictures.count > 0){
//                                    let pictureURL = pictures[0]["small"] as! String
//                                    let url = URL(string: pictureURL)
//                                    do{
//                                        let data = try Data(contentsOf: url!)
//                                        let characterImage = CharacterImage(image: data)
//                                        Storage.store(characterImage, to: .documents, as: "picture\(i)")
//                                    }catch{
//                                        print("Error saving pictures in file manager")
//                                    }
//                                }
//                            }
//                        })
//
//                        APIManager.sharedInstance.getCharacterWithId(characterID: i) { (json) in
//                            if let name = (json["name"]){
//
//                                character.name = (name as! String)
//                                character.anime = "Narutis"
//                                character.about = "sdfsdf"
//                                character.id = Int16(i)
//                                character.imageURL = "picture\(i)"
//
//                                CoreDataManager.sharedInstance.saveCharacter(character: character)
//                            }
//                        }
//                    }
//                    myGroup.notify(queue: .main){
//                        collectionView.reloadData()
//                        APIManager.sharedInstance.isRequesting = false
//                    }
//
//                }
//            }
//
//
//        }
//    }

}


extension GetInspirationsViewController: LoadingScreenDelegate{
    func didDismiss() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        
        
    }
    

}


