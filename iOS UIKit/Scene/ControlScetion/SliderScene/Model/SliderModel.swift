//
//  SliderModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import UIKit

final class SliderModel {
    static func makeCell(
        _ sectionType: SliderSettingListSectionType,
        _ viewModel: SliderViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: SliderSettingListSectionModel.Item
    ) -> DefaultCell {
        
        switch sectionType {
        case .code:
            let cell = SliderCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .value:
            let cell = SliderValueCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .color:
            let cell = SliderColorCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        }
    }
    
    deinit {
        print("SliderModel Deinit")
    }
}
