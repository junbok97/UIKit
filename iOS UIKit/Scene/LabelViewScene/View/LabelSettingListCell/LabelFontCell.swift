//
//  LabelFontCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelFontCell: DefaultLabelSettingListCell {
    
    static override var cellId: String { LabelFontCellConstants.cellId }
    
    fileprivate var fontType: LabelFontType = .regular {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.fontLabel.text = fontType.rawValue
                self.fontLabel.font = fontType.font(ofSize: LabelViewControllerConstants.defaultFontSize)
            }
        }
    }
    
    private lazy var fontLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = LabelFontCellConstants.title
        label.font = LabelViewControllerConstants.defaultFont
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
    
    override func setup(_ item: LabelSettingListSectionItemType) {
        guard case let .fontSectionItem(fontType: fontType) = item else { return }
        self.fontType = fontType
    }
    
//    override func bind(_ viewModel: LabelViewModel) {
//        self.rx.isSelected
//            .startWith(.regular)
//            .bind(to: viewModel.fontCellDidSelected)
//            .disposed(by: disposeBag)
//    }
    
}

private extension LabelFontCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(fontLabel)
        
        NSLayoutConstraint.activate([
            fontLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: LabelViewControllerConstants.defaultOffset),
            fontLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: LabelViewControllerConstants.defaultOffset),
            fontLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -LabelViewControllerConstants.defaultOffset),
            fontLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -LabelViewControllerConstants.defaultOffset)
        ])
    }
    
}

extension Reactive where Base: LabelFontCell {
    var isSelected: ControlEvent<LabelFontType> {
        let source = self.methodInvoked(#selector(setter: Base.isSelected))
            .map { _ in base.fontType }
        return ControlEvent(events: source)
    }
}
