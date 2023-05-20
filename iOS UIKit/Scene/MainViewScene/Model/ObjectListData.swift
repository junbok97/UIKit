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
            sectionHeader: .label,
            items: [
                .label
            ]
        ),
        ObjectSectionModel(
            sectionHeader: .button,
            items: [
                .button
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
