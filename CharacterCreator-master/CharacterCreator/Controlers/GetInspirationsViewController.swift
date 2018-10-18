//
//  GetInspirationsViewController.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 16/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class GetInspirationsViewController: UIViewController {

    var qtdGetCharacters = 1
    
    @IBOutlet weak var loadingImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingImageView.image = UIImage(named: "user")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        print(CoreDataManager.sharedInstance.characters)
        CoreDataManager.sharedInstance.fetchCharacters()
    }
    

}

extension GetInspirationsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterTableViewCell
        cell.characterImage.image = UIImage(named: "user")
        cell.characterImage.layer.borderWidth = 1
        print(CoreDataManager.sharedInstance.characters.count)
        cell.characterName.text = CoreDataManager.sharedInstance.characters[indexPath.row].name
        
        
//        APIManager.sharedInstance.getCharacterWithId(characterID: indexPath.row+1) { (json) in
//
//            DispatchQueue.main.async {
//                cell.characterName.text = json["name"] as? String
//                self.qtdGetCharacters = self.qtdGetCharacters + 1
//            }
        
            
//        }
        
        return cell
    }
    
    
}
