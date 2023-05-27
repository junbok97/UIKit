//
//  SliderModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import UIKit

final class SliderModel {
    
    static func codeLabelText(
        _ maximumValue: Float,
        _ minimumValue: Float,
        _ tintColor: UIColor,
        _ backgroundColor: UIColor?,
        _ thumbTintColor: UIColor?,
        _ maximumTrackTintColor: UIColor?,
        _ minimumTrackTintColor: UIColor?
    ) -> String {
    """
    lazy var slider: UISlider = {
        let slider = UISlider()
    
        slider.maximumValue = \(String(format: "%lf", maximumValue))
        slider.minimumValue = \(String(format: "%lf", minimumValue))
        
        slider.tintColor = \(tintColor.cgColor.getRGBCode)
        slider.backgroundColor = \(backgroundColor == nil ? "nil" : backgroundColor!.cgColor.getRGBCode)
        slider.thumbTintColor = \(thumbTintColor == nil ? "nil" : thumbTintColor!.cgColor.getRGBCode)
        slider.maximumTrackTintColor = \(maximumTrackTintColor == nil ? "nil" : maximumTrackTintColor!.cgColor.getRGBCode)
        slider.minimumTrackTintColor = \(minimumTrackTintColor == nil ? "nil" : minimumTrackTintColor!.cgColor.getRGBCode)
    
        return slider
    }()
    """
    }
    
    static func makeCell(
        _ sectionType: SliderSettingListSectionType,
        _ viewModel: SliderViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: SliderSettingListSectionModel.Item
    ) -> DefaultCell {
        
        switch sectionType {
        case .code:
            guard case let .code(codeType: codeType) =  sectionModelItem else { return DefaultCell() }
            switch codeType {
            case .codeLabel:
                let cell = SliderCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(viewModel)
                return cell
            case .reloadButton:
                let cell = DefaultReloadCodeButtonCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setTableViewAndSection(tableView, indexPath.section)
                return cell
            }
            
        case .minimum, .maximum:
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
