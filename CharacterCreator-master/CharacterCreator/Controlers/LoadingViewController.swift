//
//  LoadingViewController.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 18/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var loadingImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        while true {
            if(CoreDataManager.sharedInstance.characters.count > 10){
                self.dismiss(animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
