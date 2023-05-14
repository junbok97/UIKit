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
    
    let selectedColorSubject = ReplaySubject<UIColor>.create(bufferSize: 1)
    
    var colorType: ObjectColorType = .textColor {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.titleLabel.text = colorType.rawValue
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
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
        selectedColorSubject.onNext(colorWell.selectedColor ?? UIColor())
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
        [titleLabel, colorWell].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultColorCellConstants.defaultOffset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: DefaultColorCellConstants.defaultOffset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultColorCellConstants.defaultOffset),
            
            colorWell.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: DefaultColorCellConstants.defaultOffset),
            colorWell.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -DefaultColorCellConstants.defaultOffset),
            colorWell.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -DefaultColorCellConstants.defaultOffset)
        ])
    }
    
}

extension Reactive where Base: DefaultColorCell {
    var colorType: Binder<ObjectColorType> {
        return Binder(base) { base, colorType in
            base.colorType = colorType
        }
    }
}



