//
//  DefaultColorCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa

class DefaultColorCell: DefaultCell {
    
    class override var cellId: String {
        get { DefaultColorCellConstants.cellId }
    }
    
    let selectedColorSubject = ReplayRelay<UIColor>.create(bufferSize: 1)
    
    lazy var colorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = DefaultViewControllerConstants.defaultFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorWell: UIColorWell = {
        let color = UIColorWell()
        color.addTarget(self, action: #selector(changedColor), for: .valueChanged)
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    @objc private func changedColor() {
        selectedColorSubject.accept(colorWell.selectedColor ?? UIColor())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DefaultColorCell {
    func attribute() {
        selectionStyle = .none
        backgroundColor = .systemBackground
    }
    
    func layout() {
        [colorNameLabel, colorWell].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            colorNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultColorCellConstants.defaultOffset),
            colorNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: DefaultColorCellConstants.defaultOffset),
            colorNameLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultColorCellConstants.defaultOffset),
            
            colorWell.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultColorCellConstants.defaultOffset),
            colorWell.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -DefaultColorCellConstants.defaultOffset),
            colorWell.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultColorCellConstants.defaultOffset)
        ])
    }
    
}

extension Reactive where Base: DefaultColorCell {
    var colorNameLabelText: Binder<String> {
        return Binder(base) { base, text in
            base.colorNameLabel.text = text
        }
    }
}
