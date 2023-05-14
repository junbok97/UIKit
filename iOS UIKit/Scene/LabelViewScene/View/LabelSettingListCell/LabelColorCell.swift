//
//  LabelColorCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelColorCell: DefaultLabelSettingListCell {
    
    static override var cellId: String { LabelColorCellConstants.cellId }
    
    private let selectedColorSubject = ReplaySubject<UIColor>.create(bufferSize: 1)
    fileprivate var colorType: LabelColorType = .textColor {
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
        label.font = LabelViewControllerConstants.defaultFont
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
    
    override func setup(_ item: LabelSettingListSectionItemType) {
        guard case let .colorSectionItem(colorType: colorType) = item else { return }
        self.colorType = colorType
    }
    
    override func bind(_ viewModel: LabelViewModel) {
        selectedColorSubject
            .map { color in
                LabelColor(colorType: self.colorType, color: color)
            }
            .bind(to: viewModel.colorCellDidSelected)
            .disposed(by: disposeBag)
    }
    
}

private extension LabelColorCell {
    func attribute() {
        selectionStyle = .none
        backgroundColor = .systemBackground
    }
    
    func layout() {
        [titleLabel, colorWell].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: LabelColorCellConstants.topBottomOffset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: LabelColorCellConstants.topBottomOffset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -LabelColorCellConstants.topBottomOffset),
            
            colorWell.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: LabelColorCellConstants.topBottomOffset),
            colorWell.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -LabelColorCellConstants.topBottomOffset),
            colorWell.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -LabelColorCellConstants.topBottomOffset)
        ])
    }
    
}

extension Reactive where Base: LabelColorCell {
    var colorType: Binder<LabelColorType> {
        return Binder(base) { base, colorType in
            base.colorType = colorType
        }
    }
}
