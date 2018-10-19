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
    
    var minimunCharacters = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: 130, height: 200)
        
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        
        cell.characterImage.image = UIImage(named: "user")
        
        if(minimunCharacters){
            let character = CoreDataManager.sharedInstance.characters[indexPath.row]
            cell.characterName.text = character.name
            
            DispatchQueue.main.async {
                
                let url = URL(string: character.imageURL!)
                
                do{
                    let imageData = try Data(contentsOf: url!)
                    cell.characterImage.image = UIImage(data: imageData)
                }catch{
                    print(error)
                }
            }
            
            
            
        }
        cell.layer.borderWidth = 1
        //cell.frame.size.width = 130
        //cell.frame.size.height = 200
        return cell
    }
    
    
        

    
}
extension GetInspirationsViewController: LoadingScreenDelegate{
    func didDismiss() {
        collectionView.reloadData()
        minimunCharacters = true
        
    }
    

}


