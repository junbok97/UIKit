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
    case view = "View"
    case bar = "Bar"
    case picker = "Picker"
    case system = "System"
}

struct ObjectSectionModel {
    var sectionHeader: ObjectSectionType
    var items: [Item]
}

extension ObjectSectionModel: SectionModelType {
    typealias Item = Object
    init(original: ObjectSectionModel, items: [Object]) {
        self = original
        self.items = items
    }
}
