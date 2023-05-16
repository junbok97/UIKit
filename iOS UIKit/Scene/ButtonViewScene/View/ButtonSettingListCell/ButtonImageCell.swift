//
//  ButtonImageCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import UIKit

final class ButtonImageCell: DefaultLabelCell, ButtonSettingListCellProtocol {
    static override var cellId: String {
        ButtonImageCellConstants.cellId
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: ButtonSettingListItemType) {
        guard case let .image(text: text) = item else { return }
        setupLabelText(text)
    }
    
    func bind(_ viewModel: ButtonViewModel) { }
}

extension ButtonImageCell {
    func attribute() {
        setupLabelText(ButtonImageCellConstants.labelText)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }

}
