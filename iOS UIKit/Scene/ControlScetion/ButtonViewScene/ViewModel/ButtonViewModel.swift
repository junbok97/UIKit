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

protocol ButtonViewModelProtocol: ViewModelProtocol {
    
    // View -> ViewModel
    var buttonSettingListCellDatas: Driver<[ButtonSettingListSectionModel]> { get }
    var targetButtonConfiguration: Driver<UIButton.Configuration> { get }
    var targetTintColor: Driver<UIColor> { get }
    var codeCellCodeLabelText: Driver<String> { get }
    
    func buttonSettingListDataSource() -> RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel>
    func sfSymbolSeleted(_ sfSymbolName: String)
    func textDidChanged(_ buttonText: ButtonText)
    func fontSizeDidChanged(_ buttonFontSize: ButtonFontSize)
    func colorCellDidSelected(_ buttonColor: ButtonColor)
    func buttonSettingListItemSelected(_ itemType: ButtonSettingListItemType)
}

final class ButtonViewModel: ButtonViewModelProtocol {
    
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
    
    deinit {
        print("ButtonViewModel Deinit")
    }
}

// ButtonConfigurationViewModel
extension ButtonViewModel {
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
