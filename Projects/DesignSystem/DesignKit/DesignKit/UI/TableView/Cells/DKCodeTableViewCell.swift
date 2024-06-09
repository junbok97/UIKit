//
//  DKCodeTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 6/4/24.
//

import UIKit

import RxSwift
import PinLayout
import Then

import CoreKit

public protocol DKCodeTableViewCellListener: AnyObject {
    var codeObservable: Observable<String> { get }
}

public final class DKCodeTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()

    // MARK: - UI
    private let codeLabel = UILabel().then { label in
        label.text = Constants.CodeLabel.defaultText
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.numberOfLines = Constants.CodeLabel.numberOfLines
    }
    
    // MARK: - View Methods
    override func setupLayout() {
        super.setupLayout()
        
        contentView.flex.padding(DKDefaultConstants.padding).define { flex in
            flex.addItem(codeLabel).grow(1)
        }
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        codeLabel.text = Constants.CodeLabel.defaultText
    }
    
    private func layout() {
        contentView.pin.all()
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    // MARK: - View Drawing Cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }

    // MARK: - Bind
    public func bind(_ listener: DKCodeTableViewCellListener) {
        listener.codeObservable
            .bind(with: self, onNext: { object, code in
                object.codeLabel.text = code
                object.codeLabel.flex.markDirty()
                object.sizeToFit()
            })
            .disposed(by: disposeBag)
    }
    
    public func setupCode(_ code: String) {
        codeLabel.text = code
        setNeedsLayout()
    }
    
}

// MARK: - Constants
private extension DKCodeTableViewCell {

    enum Constants {
        enum CodeLabel {
            static var numberOfLines: Int { 0 }
            static var defaultText: String { """
                private let codeView = UITextView().then { textView in
                    textView.isEditable = false
                    textView.font = DKDefaultConstants.font
                }
            """}
        }
        
        enum CopyButton {
            static var title: String { "Copy" }
        }
    }
    
}
