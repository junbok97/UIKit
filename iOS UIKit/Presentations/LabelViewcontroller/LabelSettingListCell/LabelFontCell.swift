//
//  LabelFontCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift

final class LabelFontCell: UITableViewCell, UITableViewCellReigster {
    
    static var cellId: String = LabelFontCellConstants.cellId
    static var isFromNib: Bool = false
    
    private let disposeBag = DisposeBag()
    private let wegiht: UISystemFontWeightCase = .regular
    
    private lazy var fontLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = LabelFontCellConstants.title
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

    func setup(_ weightCase: UISystemFontWeightCase) {
        DispatchQueue.main.async { [weak self] in
            self?.fontLabel.text = weightCase.title
            self?.fontLabel.font = weightCase.font(ofSize: LabelViewConstants.defaultFontSize)
        }
    }
}

private extension LabelFontCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(fontLabel)
        
        NSLayoutConstraint.activate([
            fontLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: LabelViewConstants.defaultOffset),
            fontLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: LabelViewConstants.defaultOffset),
            fontLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -LabelViewConstants.defaultOffset),
            fontLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -LabelViewConstants.defaultOffset)
        ])
    }
    
}
