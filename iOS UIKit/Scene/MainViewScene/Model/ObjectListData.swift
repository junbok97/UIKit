//
//  ObjectListData.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/19.
//

import Foundation

struct ObjectListData {
    static let objectListDatas: [ObjectSectionModel] = [
        ObjectSectionModel(
            sectionHeader: .Views,
            items: [
                .uiLabel
            ]
        ),
        ObjectSectionModel(
            sectionHeader: .controls,
            items: [
                .uiButton,
                .uiSwitch
            ]
        ),
        ObjectSectionModel(
            sectionHeader: .system,
            items: [
                .sfSymbols
            ]
        )
    ]
}
