//
//  CodeTextViewCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/10.
//

import UIKit
import RxSwift

final class CodeLabelCell: UITableViewCell, UITableViewCellReigster {
    static var cellId: String = CodeLabelCellConstants.cellId
    static var isFromNib: Bool = false
    
    private let disposeBag = DisposeBag()
    
    lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textColor = .label
        label.font = CodeLabelCellConstants.defaultFont
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
    
    func bind(_ viewModel: LabelViewModel) {
        viewModel.codeViewCellDriver
            .drive(self.rx.codeText)
            .disposed(by: disposeBag)
    }
    
}

private extension CodeLabelCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(codeLabel)
        
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: CodeLabelCellConstants.defaultOffset),
            codeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: CodeLabelCellConstants.defaultOffset),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -CodeLabelCellConstants.defaultOffset),
            codeLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -CodeLabelCellConstants.defaultOffset)
        ])
    }
}

extension Reactive where Base: CodeLabelCell {
    var codeText: Binder<String> {
        return Binder(base) { base, code in
            base.codeLabel.text = code
        }
    }
}
