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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func setupLabelText(_ text: String) {
        label.text = text
    }
    
    func setupLabelTextAlignment(_ alignment: NSTextAlignment) {
        label.textAlignment = alignment
    }
    
    override func layout() {
        super.layout()
        
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            label.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -DefaultViewControllerConstants.defaultOffset),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultViewControllerConstants.defaultOffset)
        ])

    }
}
