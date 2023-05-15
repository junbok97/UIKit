//
//  ButtonModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation
import RxSwift

final class ButtonModel {
    
    lazy var buttonSettingListCellDatas = Observable.just(buttonSettingListModels)
    
    private let buttonSettingListModels: [ButtonSettingListSectionModel] = [
        ButtonSettingListSectionModel(
            sectionHeader: .code,
            items: [
                .code
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .buttonType,
            items: [
                .buttonType(buttonType: .custom),
                .buttonType(buttonType: .system),
                .buttonType(buttonType: .detailDisclosure),
                .buttonType(buttonType: .infoLight),
                .buttonType(buttonType: .infoDark),
                .buttonType(buttonType: .contactAdd),
                .buttonType(buttonType: .close)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .buttonStyle,
            items: [
                .buttonStyle(buttonStyle: .plain),
                .buttonStyle(buttonStyle: .gray),
                .buttonStyle(buttonStyle: .tinted),
                .buttonStyle(buttonStyle: .filled)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .textConfigure,
            items: [
                .textConfigure
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .text,
            items: [
                .text
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .textAlignment,
            items: [
                .buttonTitleAlignment(aligmentType: .automatic),
                .buttonTitleAlignment(aligmentType: .leading),
                .buttonTitleAlignment(aligmentType: .center),
                .buttonTitleAlignment(aligmentType: .trailing)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .textFont,
            items: [
                .font(fontType: .ultraLight),
                .font(fontType: .thin),
                .font(fontType: .light),
                .font(fontType: .regular),
                .font(fontType: .medium),
                .font(fontType: .semibold),
                .font(fontType: .bold),
                .font(fontType: .heavy),
                .font(fontType: .black)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .textFontSize,
            items: [
                .fontSize
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .image,
            items: [
                .image(text: ButtonViewControllerConstants.imageCellText)
            ]),
        ButtonSettingListSectionModel(
            sectionHeader: .color,
            items: [
                .color(colorType: .tintColor),
                .color(colorType: .foregroundColor),
                .color(colorType: .backgroundColor)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .cornerStyle,
            items: [
                .corner(cornerStyleType: .fixed),
                .corner(cornerStyleType: .dynamic),
                .corner(cornerStyleType: .small),
                .corner(cornerStyleType: .medium),
                .corner(cornerStyleType: .large),
                .corner(cornerStyleType: .capsule)
            ]
        )
    ]
    
    static func makeCell(
        _ sectionType: ButtonSettingListSectionType,
        _ viewModel: ButtonViewModel,
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ sectionModelItem: ButtonSettingListSectionModel.Item
    ) -> DefaultCell {
        switch sectionType {
        case .code:
            let cell = ButtonCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .textConfigure:
            let cell = ButtonTextConfigureCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .text:
            let cell = ButtonTextCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .textFont:
            let cell = ButtonFontCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .textFontSize:
            let cell = ButtonFontSizeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .image:
            let cell = ButtonImageCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(sectionModelItem)
            cell.bind(viewModel)
            return cell
            
        case .color:
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
}
