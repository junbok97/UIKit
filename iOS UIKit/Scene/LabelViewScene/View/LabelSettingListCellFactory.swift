//
//  LabelSettingListCellFactory.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/08.
//

import UIKit

final class LabelSettingListCellFactory {
    
    static func createCell(
        tableView: UITableView,
        section: LabelListSectionType,
        indexPath: IndexPath,
        viewModel: LabelViewModel
    ) -> UITableViewCell {
        let row = indexPath.row
        switch section {
        case .code:
            let cell = CodeLabelCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.bind(viewModel)
            return cell
        case .text:
            let cell = LabelTextCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.bind(viewModel)
            return cell
        case .color:
            let cell = LabelColorCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.setup(title: LabelColorType(rawValue: row)?.title ?? "")
            cell.bind(viewModel.getColorRelay(row))
            return cell
        case .font:
            let cell = LabelFontCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.setup(UISystemFontWeightType(rawValue: row) ?? .regular)
            return cell
        case .fontSize:
            let cell = LabelFontSizeCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.bind(viewModel)
            return cell
        case .alignment:
            let cell = LabelAlignmentCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.setup(AlignmentType(rawValue: row) ?? .natural)
            return cell
        case .numberOfLines:
            let cell = LabelNumberOfLinesCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.bind(viewModel)
            return cell
        }
    }
}
