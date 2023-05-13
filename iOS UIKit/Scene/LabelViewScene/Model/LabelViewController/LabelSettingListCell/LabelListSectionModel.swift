//
//  LabelListSectionModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/13.
//

import Foundation
import RxDataSources

enum LabelSectionType: String {
    case code = "Code"
    case text = "Text"
    case color = "Color"
    case font = "Font"
    case fontSize = "Font Size"
    case alignment = "Alignment"
    case numberOfLines = "Number Of Lines"
}

enum LabelListItemType {
    case CodeSection
}
