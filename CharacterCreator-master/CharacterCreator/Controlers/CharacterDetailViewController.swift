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

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        characterName.text = CoreDataManager.sharedInstance.characters[index!].name
        characterText.text = CoreDataManager.sharedInstance.characters[index!].about
        let data = Storage.retrieve(CoreDataManager.sharedInstance.characters[index!].imageURL!, from: .documents, as: CharacterImage.self)
        characterImage.image = UIImage(data: data.image)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
