//
//  LabelAlignmentCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/13.
//

import UIKit
import RxSwift

final class LabelAlignmentCell: UITableViewCell, UITableViewCellReigster {
    
    static var cellId: String = LabelAlignmentCellConstants.cellId
    static var isFromNib: Bool = false
    
    private let disposeBag = DisposeBag()
    
    private lazy var alignmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = LabelAlignmentCellConstants.title
        label.font = LabelViewConstants.defaultFont
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
    
    func setup(_ alignmentCases: AlignmentCase) {
        DispatchQueue.main.async { [weak self] in
            self?.alignmentLabel.text = alignmentCases.title
            self?.alignmentLabel.textAlignment = alignmentCases.aligment
        }
    }
}

private extension LabelAlignmentCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(alignmentLabel)
        
        NSLayoutConstraint.activate([
            alignmentLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: LabelViewConstants.defaultOffset),
            alignmentLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: LabelViewConstants.defaultOffset),
            alignmentLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -LabelViewConstants.defaultOffset),
            alignmentLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -LabelViewConstants.defaultOffset)
        ])
    }
    
}
