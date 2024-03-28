//
//  DefaultSwitchCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/20.
//

import UIKit
import RxSwift
import RxCocoa

class DefaultSwitchCell: DefaultCell {
    
    class override var cellId: String {
        get { DefaultSwitchCellConstants.cellId }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = DefaultViewControllerConstants.defaultFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var switchToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, switchToggle])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = DefaultSwitchCellConstants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func setupLabelText(_ text: String) {
        label.text = text
    }
    
    override func layout() {
        super.layout()
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -DefaultViewControllerConstants.defaultOffset),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultViewControllerConstants.defaultOffset)
        ])

    }
}
