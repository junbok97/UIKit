//
//  Object.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/03/15.
//

import UIKit

enum ObjectType: String {
    case label = "Label"
    case button = "Button"
    case sfSymbols = "SF Symbols"
}

struct Object {
    let title: String
    let type: ObjectType
    let image: UIImage?
    
    init(type: ObjectType) {
        self.type = type
        self.title = type.rawValue
        self.image = UIImage(named: type.rawValue)
    }
}
