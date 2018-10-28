//
//  Heads.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 28/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit
class Heads: Session {
    var sessionIcon: UIImage = UIImage(named: "head1Color1")!
    
    var itens: [SessionIten]  = [
        SessionIten(withName: "Head", andImage: UIImage(named: "head1Color1")!),
        SessionIten(withName: "Head", andImage: UIImage(named: "head1Color2")!),
        SessionIten(withName: "Head", andImage: UIImage(named: "head1Color3")!)
    ]
    
}
