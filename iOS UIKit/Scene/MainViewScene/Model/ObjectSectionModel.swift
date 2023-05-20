//
//  ObjectSectionModel.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/05/07.
//

import Foundation
import RxDataSources

enum ObjectSectionType: String {
    case label = "Label"
    case button = "Button"
    case system = "System"
    case bars = "Bars"
}

struct ObjectSectionModel {
    var sectionHeader: ObjectSectionType
    var items: [Item]
}

extension ObjectSectionModel: SectionModelType {
    typealias Item = ObjectType
    init(original: ObjectSectionModel, items: [ObjectType]) {
        self = original
        self.items = items
    }
}
