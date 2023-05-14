//
//  DefaultCodeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift

final class DefaultCodeCell: DefaultLabelSettingListCell {
    
    static override var cellId: String { LabelCodeCellConstants.cellId }
    
    lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textColor = .label
        label.font = LabelCodeCellConstants.defaultFont
        label.numberOfLines = 0
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
    
    override func bind(_ viewModel: LabelViewModel) {
        viewModel.codeCellCodeLabelText
            .drive(self.rx.codeText)
            .disposed(by: disposeBag)
    }
    
}

private extension LabelCodeCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(codeLabel)
        
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: LabelCodeCellConstants.defaultOffset),
            codeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: LabelCodeCellConstants.defaultOffset),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -LabelCodeCellConstants.defaultOffset),
            codeLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -LabelCodeCellConstants.defaultOffset)
        ])
    }
}

extension Reactive where Base: LabelCodeCell {
    var codeText: Binder<String> {
        return Binder(base) { base, code in
            base.codeLabel.text = code
        }
    }
}

