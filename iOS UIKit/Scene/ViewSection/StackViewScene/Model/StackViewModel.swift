//
//  StackViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation
import RxSwift

protocol StackViewModelProtocol: ModelProtocol {
    static func makeCell(
        _ sectionType: StackViewSettingListSectionType,
        _ viewModel: StackViewViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: StackViewSettingListSectionModel.Item
    ) -> DefaultCell
}

final class StackViewModel: StackViewModelProtocol {
    static func makeCell(
        _ sectionType: StackViewSettingListSectionType,
        _ viewModel: StackViewViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: StackViewSettingListSectionModel.Item
    ) -> DefaultCell {
        switch sectionType {
        case .code:
            guard case let .code(type: codeType) =  sectionModelItem else { return DefaultCell() }
            switch codeType {
            case .codeLabel:
                let cell = StackViewCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(viewModel)
                return cell

            case .reloadButton:
                let cell = DefaultReloadCodeButtonCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setTableViewAndSection(tableView, indexPath.section)
                return cell
            }
        case .axis, .alignment, .distribution:
            let cell = StackViewLabelCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .spacing:
            let cell = StackViewSpacingCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .color:
            let cell = StackViewColorCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        }
    }
}
