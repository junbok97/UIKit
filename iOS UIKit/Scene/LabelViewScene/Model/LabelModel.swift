//
//  LabelModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/11.
//

import Foundation
import RxSwift

final class LabelModel {
    
    lazy var labelSettingListCellDatas = Observable.just(LabelSettingListData.settingListDatas)
    
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
        
    static func makeCell(
        _ sectionType: LabelSettingListSectionType,
        _ viewModel: LabelViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: LabelSettingListSectionModel.Item
    ) -> DefaultCell {
        switch sectionType {
        case .code:
            let cell = LabelCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .text:
            let cell = LabelTextCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .color:
            let cell = LabelColorCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .font:
            let cell = LabelFontCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .fontSize:
            let cell = LabelFontSizeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .alignment:
            let cell = LabelAlignmentCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .numberOfLines:
            let cell = LabelNumberOfLinesCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        } // Switch
    }
}
