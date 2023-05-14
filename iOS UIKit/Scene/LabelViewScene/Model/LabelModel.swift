//
//  LabelModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/11.
//

import Foundation
import RxSwift

final class LabelModel {
    private let labelSettingListModels: [LabelSettingListSectionModel] = [
        LabelSettingListSectionModel(
            sectionHeader: .code,
            items: [
                .codeSectionItem
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .text,
            items: [
                .textSectionItem
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .color,
            items: [
                .colorSectionItem(colorType: .textColor),
                .colorSectionItem(colorType: .backgroundColor)
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .font,
            items: [
                .fontSectionItem(fontType: .ultraLight),
                .fontSectionItem(fontType: .thin),
                .fontSectionItem(fontType: .light),
                .fontSectionItem(fontType: .regular),
                .fontSectionItem(fontType: .medium),
                .fontSectionItem(fontType: .semibold),
                .fontSectionItem(fontType: .bold),
                .fontSectionItem(fontType: .heavy),
                .fontSectionItem(fontType: .black)
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .fontSize,
            items: [
                .fontSizeSectionItem
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .alignment,
            items: [
                .alignmentSectionItem(alignmentType: .natural),
                .alignmentSectionItem(alignmentType: .left),
                .alignmentSectionItem(alignmentType: .center),
                .alignmentSectionItem(alignmentType: .right),
                .alignmentSectionItem(alignmentType: .justified)
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .numberOfLines,
            items: [
                .numberOfLinesSectionItem
            ]
        )
    ]
    lazy var labelSettingListCellDatas = Observable.just(labelSettingListModels)
    
    func codeLabelText(
        _ text: String,
        _ textColor: String,
        _ backgroudColor: String,
        _ font: String,
        _ alignment: String,
        _ lines: String
    ) -> String {
        """
        let label = UILabel()
        label.text = \"\(text)\"
        label.textColor = \(textColor)
        label.backgroundColor = \(backgroudColor)
        label.font = \(font)
        label.textAlignment = \(alignment)
        label.numberOfLines = \(lines)
        """
    }
}
