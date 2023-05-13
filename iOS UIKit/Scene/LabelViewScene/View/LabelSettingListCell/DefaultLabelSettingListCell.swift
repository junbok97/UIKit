//
//  DefaultLabelSettingListCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/13.
//

import UIKit
import RxSwift

class DefaultLabelSettingListCell: UITableViewCell, UITableViewCellReigster {
    class var cellId: String {
        get { "DefaultLabelSettingListCell" }
    }
    
    static var isFromNib: Bool = false
    
    let disposeBag = DisposeBag()
    
    func setup(_ item: LabelSettingListSectionItemType) {}
    func bind(_ viewModel: LabelViewModel) {}
}
