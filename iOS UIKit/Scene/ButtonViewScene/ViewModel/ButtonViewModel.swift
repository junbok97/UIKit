//
//  ButtonViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ButtonViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let buttonModel = ButtonModel()
    private let buttonConfigurationViewModel = ButtonConfigurationViewModel()
    
    // View -> ViewModel
    
    let tintColorSelected = PublishRelay<UIColor>()
    let buttonSettingListCellDatas: Driver<[ButtonSettingListSectionModel]>
    let targetButtonConfiguration: Driver<UIButton.Configuration>
    let targetTintColor: Driver<UIColor>
    let codeCellCodeLabelText: Driver<String>
    
    init() {
        buttonSettingListCellDatas = Observable.just(ButtonSettingListData.settingListDatas)
            .asDriver(onErrorDriveWith: .empty())
       
        targetButtonConfiguration = buttonConfigurationViewModel.buttonConfigurationDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetTintColor = tintColorSelected
            .asDriver(onErrorDriveWith: .empty())
        
        codeCellCodeLabelText = buttonConfigurationViewModel.buttonConfigurationCode
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func buttonSettingListDataSource() -> RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> { [weak self] dataSource, tableView, indexPath, sectionModelItem in
            guard let self = self else { fatalError("ButtonViewModel Nil") }
            return self.buttonModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        } // RxTableViewSectionedReloadDataSource
        
        return dataSource
    }
    
    deinit {
        print("ButtonViewModel Deinit")
    }
}

// ButtonConfigurationViewModel
extension ButtonViewModel {
    func sfSymbolSeleted(_ sfSymbolName: String) {
        buttonConfigurationViewModel.sfSymbolDidSeleted(sfSymbolName)
    }
    
    func textDidChanged(_ buttonText: ButtonText) {
        buttonConfigurationViewModel.textDidChanged(buttonText)
    }
    
    func fontSizeDidChanged(_ buttonFontSize: ButtonFontSize) {
        buttonConfigurationViewModel.fontSizeDidChanged(buttonFontSize)
    }
    
    func colorCellDidSelected(_ objectColor: ObjectColor) {
        switch objectColor.colorType {
        case .tintColor:
            tintColorSelected.accept(objectColor.color)
        case .titleColor:
            buttonConfigurationViewModel.titleColorDidSelected(objectColor.color)
        case .subTitleColor:
            buttonConfigurationViewModel.subTitleColorDidSelected(objectColor.color)
        case .foregroundColor:
            buttonConfigurationViewModel.baseForegroundColorSelected(objectColor.color)
        case .backgroundColor:
            buttonConfigurationViewModel.basebackgroundColorSelected(objectColor.color)
        }
    }
    
    func buttonSettingListItemSelected(_ itemType: ButtonSettingListItemType) {
        switch itemType {
        case let .buttonStyle(buttonStyle: buttonStyle):
            buttonConfigurationViewModel.buttonStyleDidSelected(buttonStyle)
        case let .corner(cornerStyleType: cornerStyle):
            buttonConfigurationViewModel.buttonCornerStyleDidSelected(cornerStyle)
        case let .buttonTitleAlignment(aligmentType: alignmentType):
            buttonConfigurationViewModel.titleAlignmentDidSelected(alignmentType)
        case let .font(titleType: titleType, fontType: fontType):
            buttonConfigurationViewModel.fontDidSeleted(titleType, fontType)
        case let .imagePlacement(placement: placement):
            buttonConfigurationViewModel.imagePlacementDidSelected(placement)
        default:
            return
        }
    }

}
