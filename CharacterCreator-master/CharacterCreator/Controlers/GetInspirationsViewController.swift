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
        
        cell.contentView.accessibilityIdentifier = "\(indexPath.row)"
        registerForPreviewing(with: self, sourceView: cell.contentView)
        cell.layer.borderWidth = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CharacterDetail", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CharacterDetail") as! CharacterDetailViewController
        view.index = indexPath.row
        self.modalTransitionStyle = .flipHorizontal
        self.present(view, animated: true) {
            
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == CoreDataManager.sharedInstance.characters.count - 4){
            //fazer request de mais 10
            let lastID = CoreDataManager.sharedInstance.getLastId()
            DispatchQueue.main.async {
                for i in lastID + 1...lastID + 11{
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
                            
                            let name = (name as! String)
                            let animeography = json["animeography"] as! [[String : Any]]
                            let anime = animeography[0]["name"] as! String
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
                    collectionView.reloadData()
                }
            }
        }
    }

}


extension GetInspirationsViewController: LoadingScreenDelegate{
    func didDismiss() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        
        
    }
    

}

extension GetInspirationsViewController: UIViewControllerPreviewingDelegate{
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        let viewController = UIViewController(
        
        let storyboard = UIStoryboard(name: "CharacterDetail", bundle: nil)
        let content = previewingContext.sourceView
        let index = content.accessibilityIdentifier
        
        let view = storyboard.instantiateViewController(withIdentifier: "CharacterDetail") as! CharacterDetailViewController
        view.index = Int(index!)
        
        
        return view
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.present(viewControllerToCommit, animated: true, completion: nil)
    }
    
    
}


