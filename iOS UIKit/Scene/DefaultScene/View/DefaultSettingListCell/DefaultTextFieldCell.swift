//
//  DefaultTextFieldCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import UIKit
import RxSwift

class DefaultTextFieldCell: DefaultCell {
    
    override class var cellId: String {
        DefaultTextFieldCellConstants.cellId
    }
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = DefaultViewControllerConstants.defaultFont
        textField.placeholder = DefaultTextFieldCellConstants.placeHolder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.placeholder = DefaultTextFieldCellConstants.placeHolder
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DefaultTextFieldCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            textField.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            textField.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -DefaultViewControllerConstants.defaultOffset),
            textField.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultViewControllerConstants.defaultOffset)
        ])
    }
}
