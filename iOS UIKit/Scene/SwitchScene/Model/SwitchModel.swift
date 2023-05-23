//
//  SwitchModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation
import RxSwift

final class SwitchModel {
    
    static func makecell(
        _ sectionType: SwitchSettingListSectionType,
        _ viewModel: SwitchViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: SwitchSettingListSectionModel.Item
    ) -> DefaultCell {
        switch sectionType {
        case .code:
            guard case let .code(codeType: codeType) =  sectionModelItem else { return DefaultCell() }
            switch codeType {
            case .codeLabel:
                let cell = SwitchCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(viewModel)
                return cell

            case .reloadButton:
                let cell = DefaultReloadCodeButtonCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setTableViewAndSection(tableView, indexPath.section)
                return cell
            }

        case .color:
            let cell = SwitchColorCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        }
    }
    
    static func codeLabelText(
        _ isOn: Bool,
        _ onTintColor: UIColor,
        _ thumbColor: UIColor,
        _ backgroundColor: UIColor
    ) -> String {
    """
    let toggle = UISwitch()
    
    toggle.isOn = \(isOn)
    toggle.onTintColor = \(onTintColor.cgColor.getRGBCode)
    toggle.thumbTintColor = \(thumbColor.cgColor.getRGBCode)
    toggle.backgroundColor = \(backgroundColor.cgColor.getRGBCode)
    """
    }
    
    deinit {
        print("SwitchModel Deinit")
    }
    
}
