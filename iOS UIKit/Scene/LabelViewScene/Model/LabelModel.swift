//
//  LabelModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/11.
//

import Foundation
import RxSwift

final class LabelModel {
    
    func codeLabelText(
        _ text: String,
        _ textColor: UIColor,
        _ backgroudColor: UIColor,
        _ fontType: ObjectFontType,
        _ ofSize: Int,
        _ alignment: ObjectAlignmentType,
        _ lines: Int
    ) -> String {
        """
        lazy var label: UIlabel = {
            let label = UILabel()
            
            label.text = \"\(text)\"
            label.textColor = \(textColor.cgColor.getRGBCode)
            label.backgroundColor = \(backgroudColor.cgColor.getRGBCode)
            label.font = \(fontType.code(ofSize: CGFloat(ofSize)))
            label.textAlignment = \(alignment.code)
            label.numberOfLines = \(lines)
        
            return label
        }()
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
            guard case let .code(codeType: codeType) =  sectionModelItem else { return DefaultCell() }
            switch codeType {
            case .codeLabel:
                let cell = LabelCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(viewModel)
                return cell
            case .reloadButton:
                let cell = DefaultReloadCodeButtonCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setTableViewAndSection(tableView, indexPath.section)
                return cell
            }
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
    
    deinit {
        print("LabeModel Deinit")
    }
}
