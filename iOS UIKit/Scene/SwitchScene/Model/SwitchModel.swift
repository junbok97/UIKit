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
            let cell = SwitchCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        case .color:
            let cell = SwitchColorCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        }
    }
    
    func codeLabelText(
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
