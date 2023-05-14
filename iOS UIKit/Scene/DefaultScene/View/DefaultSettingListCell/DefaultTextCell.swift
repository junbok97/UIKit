//
//  DefaultTextCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa

class DefaultTextCell: DefaultCell {
    
    class override var cellId: String {
        get { DefaultTextCellConstants.cellId }
    }
    
    lazy var textField: UITextField = {
       let textField = UITextField()
        textField.placeholder = DefaultTextCellConstants.text
        textField.font = DefaultViewControllerConstants.defaultFont
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
}

private extension DefaultTextCell {
    func attribute() {
        selectionStyle = .none
        backgroundColor = .systemBackground
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


extension DefaultTextCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

