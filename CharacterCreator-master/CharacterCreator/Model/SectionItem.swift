//
//  SessionIten.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 28/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit
class SectionItem {
    var image: UIImage
    var name: String
    
    init(withName name: String, andImage image: UIImage) {
        self.name = name
        self.image = image
    }
}
