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
    
    private let buttonConfigurationViewModel = ButtonConfigurationViewModel()
    
    // View -> ViewModel
    let buttonSettingListCellDatas: Driver<[ButtonSettingListSectionModel]>
    let targetButtonConfiguration: Driver<UIButton.Configuration>
    let targetTintColor: Driver<UIColor>
    let codeCellCodeLabelText: Driver<String>
    
    init() {
        buttonSettingListCellDatas = Observable.just(ButtonSettingListData.settingListDatas)
            .asDriver(onErrorDriveWith: .empty())
       
        targetButtonConfiguration = buttonConfigurationViewModel.buttonConfigurationDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetTintColor = buttonConfigurationViewModel.tintColorSelected
            .asDriver(onErrorDriveWith: .empty())
        
        codeCellCodeLabelText = buttonConfigurationViewModel.buttonSettingCodeText
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func buttonSettingListDataSource() -> RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> {
        RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> {  dataSource, tableView, indexPath, sectionModelItem in
            ButtonModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        } // RxTableViewSectionedReloadDataSource
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
    
    func colorCellDidSelected(_ buttonColor: ButtonColor) {
        buttonConfigurationViewModel.colorCellDidSelected(buttonColor)
    }
    
    func buttonSettingListItemSelected(_ itemType: ButtonSettingListItemType) {
        buttonConfigurationViewModel.buttonSettingListItemSelected(itemType)
    }

}
