//
//  NewCharacterViewController.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 27/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class NewCharacterViewController: UIViewController {

    var sessions: [Session] = [Heads()]
    var dataSource: [Any] = []
    var isOnSessions = true
    var element: [String:UIImageView] = [:]
    
    @IBOutlet weak var HeadImage: UIImageView!
    @IBOutlet weak var creationView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        HeadImage.image = UIImage(named: "head1Color1")
        HeadImage.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
        dataSource = sessions
        element["Head"] = HeadImage
        
        
    }


}

extension NewCharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItenCollectionViewCell
        cell.itemImage.contentMode = .scaleAspectFit
        if(isOnSessions){
            cell.itemImage.image = sessions[indexPath.row].sessionIcon
            
        }
        else{
            let itens = dataSource as! [SessionIten]
            cell.itemImage.image = itens[indexPath.row].image
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(isOnSessions){
            let session = dataSource[indexPath.row] as! Session
            dataSource = session.itens
            isOnSessions = false
            collectionView.reloadData()
        }
        else{
            let item = dataSource[indexPath.row] as! SessionIten
            let image = element[item.name]!
            image.image = item.image
        }
    }
    
    
}
