//
//  NewCharacterViewController.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 27/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class NewCharacterViewController: UIViewController {

    var sessions: [Section] = [Heads(), Eyes(), Nose()]
    var dataSource: [Any] = []
    var isOnSessions = true
    var element: [String:UIImageView] = [:]
    
    @IBOutlet weak var HeadImage: UIImageView!
    @IBOutlet weak var EyesImage: UIImageView!
    @IBOutlet weak var creationView: UIView!
    @IBOutlet weak var NoseImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creationView.layer.cornerRadius = creationView.frame.width / 2
        creationView.layer.borderWidth = 0.5
        collectionView.delegate = self
        collectionView.dataSource = self
        HeadImage.image = UIImage(named: "head1Color1")
        HeadImage.contentMode = .scaleAspectFit
        EyesImage.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
        dataSource = sessions
        element["Head"] = HeadImage
        element["Eyes"] = EyesImage
        element["Nose"] = NoseImage
        let color = UIColor(red: 120/255, green: 150/255, blue: 210/255, alpha: 1)
        self.view.backgroundColor = color
        
        let color2 = UIColor(red: 120/255, green: 150/255, blue: 240/255, alpha: 1)
        collectionView.backgroundColor = color2
        
        
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
            let itens = dataSource as! [SectionItem]
            if(itens[0].name == "Nose"){
                cell.itemImage.contentMode = .scaleAspectFill
            }
            cell.itemImage.image = itens[indexPath.row].image
        }
        cell.layer.borderWidth = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(isOnSessions){
            let session = dataSource[indexPath.row] as! Section
            dataSource = session.itens
            isOnSessions = false
            collectionView.reloadData()
        }
        else{
            if(indexPath.row == dataSource.count - 1){
                dataSource = sessions
                isOnSessions = true
                collectionView.reloadData()
            }
            else{
                let item = dataSource[indexPath.row] as! SectionItem
                let image = element[item.name]!
                image.image = item.image
            }
            
        }
    }
    
    
}
