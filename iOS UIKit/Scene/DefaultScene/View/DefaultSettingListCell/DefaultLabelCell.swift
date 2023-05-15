//
//  DefaultLabelCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import UIKit
import RxSwift
import RxCocoa

class DefaultLabelCell: DefaultCell {
    
    class override var cellId: String {
        get { DefaultLabelCellConstants.cellId }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = DefaultViewControllerConstants.defaultFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

private extension DefaultLabelCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -DefaultViewControllerConstants.defaultOffset),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultViewControllerConstants.defaultOffset)
        ])
    }
    
}
