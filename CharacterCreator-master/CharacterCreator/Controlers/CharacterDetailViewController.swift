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

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var closeGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var animeLabel: UILabel!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(red: 120/255, green: 150/255, blue: 210/255, alpha: 1)
        self.view.backgroundColor = color
        
        characterName.text = CoreDataManager.sharedInstance.characters[index!].name
        characterText.text = CoreDataManager.sharedInstance.characters[index!].about
        animeLabel.text = CoreDataManager.sharedInstance.characters[index!].anime
        let data = Storage.retrieve(CoreDataManager.sharedInstance.characters[index!].imageURL!, from: .documents, as: CharacterImage.self)
        characterImage.image = UIImage(data: data.image)

        characterText.isEditable = false
        
        
        // Do any additional setup after loading the view.
        closeGesture.edges = .left
        
        scrollView.delegate = self
    }
    


    @IBAction func dismissGesture(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
        
        
    }

    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension CharacterDetailViewController: UIGestureRecognizerDelegate{
    
}
extension CharacterDetailViewController: UIScrollViewDelegate{
    
}
