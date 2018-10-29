//
//  Heads.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 28/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit
class Heads: Section {
    var sessionIcon: UIImage = UIImage(named: "head1Color1")!
    
    var itens: [SectionItem]  = [
        SectionItem(withName: "Head", andImage: UIImage(named: "head1Color1")!),
        SectionItem(withName: "Head", andImage: UIImage(named: "head1Color2")!),
        SectionItem(withName: "Head", andImage: UIImage(named: "head1Color3")!),
        SectionItem(withName: "Back", andImage: UIImage(named: "back")!)
    ]
    
}
