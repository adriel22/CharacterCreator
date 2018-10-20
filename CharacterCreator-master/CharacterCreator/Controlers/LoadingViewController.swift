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
    var delegate: LoadingScreenDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
//        let dispachQueue = DispatchQueue(label: "requestQueue", qos: .background)
//        dispachQueue.async {
//            while true {
//                print(CoreDataManager.sharedInstance.characters.count)
//                CoreDataManager.sharedInstance.fetchCharacters()
//                    if(CoreDataManager.sharedInstance.characters.count > 10){
//                        print("sim")
//                        //self.dismiss(animated: true) {
//                        self.delegate?.didDismiss()
//                        self.dismiss(animated: true, completion: nil)
//                        break
//                }
//            }
//
//        }
        
        
        }
    

    override func viewDidAppear(_ animated: Bool) {
        while true {
            print(CoreDataManager.sharedInstance.characters.count)
            CoreDataManager.sharedInstance.fetchCharacters()
            if(CoreDataManager.sharedInstance.characters.count > 10){
                
                //self.dismiss(animated: true) {
                self.delegate?.didDismiss()
                self.dismiss(animated: false, completion: nil)
                break
            }
        }
    }

}
