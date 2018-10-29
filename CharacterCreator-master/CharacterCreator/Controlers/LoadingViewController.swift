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
    var images = [
        UIImage(named: "cblinho1")!, UIImage(named: "cblinho2")!,UIImage(named: "cblinho3")!,UIImage(named: "cblinho4")!, UIImage(named: "cblinho5")!, UIImage(named: "cblinho6")!, UIImage(named: "cblinho7")!, UIImage(named: "cblinho8")!,
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingImageView.contentMode = .scaleAspectFit
        loadingImageView.animationImages = images
        loadingImageView.animationDuration = 2
        loadingImageView.startAnimating()
        
        APIManager.sharedInstance.dispatchGroup.notify(queue: .main) {
            self.delegate?.didDismiss()
            self.dismiss(animated: false, completion: nil)
        }
    }
    

    
}
