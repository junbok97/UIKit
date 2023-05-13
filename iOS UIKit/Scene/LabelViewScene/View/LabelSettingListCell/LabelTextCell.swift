//
//  LabelTextCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/12.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelTextCell: DefaultLabelSettingListCell {
    
    static override var cellId: String { LabelTextCellConstants.cellId }
    
    private lazy var textField: UITextField = {
       let textField = UITextField()
        textField.placeholder = LabelViewConstants.title
        textField.font = LabelViewConstants.defaultFont
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind(_ viewModel: LabelViewModel) {
        textField.rx.text
            .compactMap { $0 == "" ? LabelViewConstants.title : $0 }
            .bind(to: viewModel.textCellDidChangedTextField)
            .disposed(by: disposeBag)
    }
    
}

private extension LabelTextCell {
    func attribute() {
        selectionStyle = .none
        backgroundColor = .systemBackground
    }
    
    func layout() {
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: LabelViewConstants.defaultOffset),
            textField.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: LabelViewConstants.defaultOffset),
            textField.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -LabelViewConstants.defaultOffset),
            textField.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -LabelViewConstants.defaultOffset)
        ])
    }
}

extension LabelTextCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
