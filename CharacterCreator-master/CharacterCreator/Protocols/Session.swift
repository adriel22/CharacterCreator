//
//  Session.swift
//  CharacterCreator
//
//  Created by Adriel Freire on 28/10/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit
protocol Session {
    var itens: [SessionIten]{get}
    var sessionIcon: UIImage{get}
}
