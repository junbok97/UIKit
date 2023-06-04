//
//  StepperModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import UIKit

protocol StepperModelProtocol: ModelProtocol {
    static func codeLabelText(
        _ autorepeat: Bool,
        _ wrap: Bool,
        _ stepValue: Double,
        _ minimum: Double,
        _ maximum: Double
    ) -> String
    
    static func makeCell(
        _ sectionType: StepperSettingListSectionType,
        _ viewModel: StepperViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: StepperSettingListSectionModel.Item
    ) -> DefaultCell
}

final class StepperModel {
    
    static func codeLabelText(
        _ autorepeat: Bool,
        _ wrap: Bool,
        _ stepValue: Double,
        _ minimum: Double,
        _ maximum: Double
    ) -> String {
        """
        lazy var stepper: UIStepper = {
            let stepper = UIStepper()
        
            stepper.autorepeat = \(autorepeat)
            stepper.wraps = \(wrap)
        
            stepper.stepValue = \(String(format: "%lf", stepValue))
            stepper.maximumValue = \(String(format: "%lf", maximum))
            stepper.minimumValue = \(String(format: "%lf", minimum))
            
            return stepper
        }()
        """
    }
    
    static func makeCell(
        _ sectionType: StepperSettingListSectionType,
        _ viewModel: StepperViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: StepperSettingListSectionModel.Item
    ) -> DefaultCell {
        switch sectionType {
        case .code:
            guard case let .code(type: type) =  sectionModelItem else { return DefaultCell() }
            switch type {
            case .codeLabel:
                let cell = StepperCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.bind(viewModel)
                return cell
            case .reloadButton:
                let cell = DefaultReloadCodeButtonCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setTableViewAndSection(tableView, indexPath.section)
                return cell
            }
        case .autorepeat, .wrap:
            let cell = StepperToggleCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        default:
            let cell = StepperValueCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
        }
    }
    
    deinit {
        print("StepperModel Deinit")
    }
}
