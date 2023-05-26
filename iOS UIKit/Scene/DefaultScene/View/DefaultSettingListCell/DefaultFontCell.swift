//
//  DefaultFontCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa

class DefaultFontCell: DefaultCell {
    
    class override var cellId: String {
        get { DefaultFontCellConstants.cellId }
    }
    
    var fontType: ObjectFontType = .regular {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.fontLabel.text = fontType.rawValue
                self.fontLabel.font = fontType.font(ofSize: DefaultViewControllerConstants.defaultFontSize)
            }
        }
    }
    
    private lazy var fontLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = DefaultFontCellConstants.title
        label.font = DefaultViewControllerConstants.defaultFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layout() {
        super.layout()
        contentView.addSubview(fontLabel)
        
        NSLayoutConstraint.activate([
            fontLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            fontLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: DefaultViewControllerConstants.defaultOffset),
            fontLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -DefaultViewControllerConstants.defaultOffset),
            fontLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultViewControllerConstants.defaultOffset)
        ])
    }
    
}
