//
//  LabelAlignmentCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/13.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelAlignmentCell: DefaultCell, LabelSettingListCellProtocol {
    
    static override var cellId: String { LabelAlignmentCellConstants.cellId }
    
    fileprivate var alignmentType: ObjectAlignmentType = .center {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.alignmentLabel.text = alignmentType.rawValue
                self.alignmentLabel.textAlignment = alignmentType.aligment
            }
        }
    }
    
    private lazy var alignmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = alignmentType.rawValue
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
    
    func setup(_ item: LabelSettingListSectionItemType) {
        guard case let .alignment(alignmentType) = item else {
            return
        }
        self.alignmentType = alignmentType
    }
    
    func bind(_ viewModel: LabelViewModel) { }

}

private extension LabelAlignmentCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(alignmentLabel)
        
        NSLayoutConstraint.activate([
            alignmentLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: LabelViewControllerConstants.defaultOffset),
            alignmentLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: LabelViewControllerConstants.defaultOffset),
            alignmentLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -LabelViewControllerConstants.defaultOffset),
            alignmentLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -LabelViewControllerConstants.defaultOffset)
        ])
    }
    
}
