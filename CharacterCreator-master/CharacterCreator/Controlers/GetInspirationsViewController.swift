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
    var numberOfCells = 10
    var minimunCharacters = false
    
    
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

        
        if(CoreDataManager.sharedInstance.characters.count < 10){
            performSegue(withIdentifier: "gotoLoading", sender: self)
            //print("ok")
        }
        else{
            minimunCharacters = true
        }
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
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        
        cell.characterImage.image = UIImage(named: "user")
        
        if(minimunCharacters){
            let character = CoreDataManager.sharedInstance.characters[indexPath.row]
            cell.characterName.text = character.name
            
            DispatchQueue.main.async {
                let data = Storage.retrieve(character.imageURL!, from: .documents, as: CharacterImage.self)
                cell.characterImage.image = UIImage(data: data.image)
                
            }
            
        }
        print(indexPath.row)
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == numberOfCells - 2){
            numberOfCells = numberOfCells + 10
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }

//        let character = Character(context: context)
//        let dispachQueue = DispatchQueue(label: "requestQueue", qos: .background)
//        dispachQueue.async {
//            <#code#>
//        }
    }

}


extension GetInspirationsViewController: LoadingScreenDelegate{
    func didDismiss() {
        collectionView.reloadData()
        minimunCharacters = true
        
    }
    

}


