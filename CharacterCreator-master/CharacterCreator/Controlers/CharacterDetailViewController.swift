//
//  CharacterDetailViewController.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 23/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var index: Int?

    
    @IBOutlet var closeGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var animeLabel: UILabel!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        characterName.text = CoreDataManager.sharedInstance.characters[index!].name
        characterText.text = CoreDataManager.sharedInstance.characters[index!].about
        animeLabel.text = CoreDataManager.sharedInstance.characters[index!].anime
        let data = Storage.retrieve(CoreDataManager.sharedInstance.characters[index!].imageURL!, from: .documents, as: CharacterImage.self)
        characterImage.image = UIImage(data: data.image)

        characterText.isEditable = false
        
        
        // Do any additional setup after loading the view.
        closeGesture.edges = .left
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func dismissGesture(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
        
        
    }

    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension CharacterDetailViewController: UIGestureRecognizerDelegate{
    
}
