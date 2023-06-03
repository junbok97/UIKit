//
//  ButtonModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation
import RxSwift

protocol ButtonModelProtocol: ModelProtocol {
    static func makeCell(
        _ sectionType: ButtonSettingListSectionType,
        _ viewModel: ButtonViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: ButtonSettingListSectionModel.Item
    ) -> DefaultCell
}

final class ButtonModel {
    
    static func makeCell(
        _ sectionType: ButtonSettingListSectionType,
        _ viewModel: ButtonViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: ButtonSettingListSectionModel.Item
    ) -> DefaultCell {
        switch sectionType {
        case .code:
            guard case let .code(codeType: codeType) =  sectionModelItem else { return DefaultCell() }
            switch codeType {
            case .codeLabel:
                let cell = ButtonCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(viewModel)
                return cell

            case .reloadButton:
                let cell = DefaultReloadCodeButtonCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setTableViewAndSection(tableView, indexPath.section)
                return cell
            }
        case .titleText, .subTitleText:
            let cell = ButtonTextCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .titleFont, .subTitleFont:
            let cell = ButtonFontCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .titleFontSize, .subTitleFontSize:
            let cell = ButtonFontSizeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
  
        case .image:
            let cell = ButtonImageCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .color, .titleForegroundColor, .subTitleForegroundColor:
            let cell = ButtonColorCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        default:
            let cell = ButtonLabelCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        } // Switch
    } // makeCell
    
    deinit {
        print("ButtonModel Deinit")
    }
}
