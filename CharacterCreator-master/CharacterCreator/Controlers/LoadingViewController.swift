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

        APIManager.sharedInstance.dispatchGroup.notify(queue: .main) {
            self.delegate?.didDismiss()
            self.dismiss(animated: false, completion: nil)
        }
    }
    

    
}
