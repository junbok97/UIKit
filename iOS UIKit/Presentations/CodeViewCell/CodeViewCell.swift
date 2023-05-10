//
//  CodeTextViewCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/10.
//

import UIKit
import RxSwift

final class CodeViewCell: UITableViewCell, UITableViewCellReigster {
    static var cellId: String = CodeViewCellConstants.cellId
    static var isFromNib: Bool = false
    
    private let disposeBag = DisposeBag()
    
    lazy var codeTextView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.textColor = .label
        textView.font = CodeViewCellConstants.defaultFont
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
            .drive()
            .disposed(by: disposeBag)
    }
    
}


private extension CodeViewCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(codeTextView)
        
        NSLayoutConstraint.activate([
            codeTextView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: CodeViewCellConstants.defaultOffset),
            codeTextView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: CodeViewCellConstants.defaultOffset),
            codeTextView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -CodeViewCellConstants.defaultOffset),
            codeTextView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -CodeViewCellConstants.defaultOffset)
        ])
    }
}

extension Reactive where Base: CodeViewCell {
    var codeText: Binder<String> {
        return Binder(base) { base, code in
            base.codeTextView.text = code
        }
    }
}
