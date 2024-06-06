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
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let codeLabel = UILabel().then { label in
        label.text = Constants.CodeLabel.defaultText
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.numberOfLines = Constants.CodeLabel.numberOfLines
    }
    
    // MARK: - View Methods
    override func setupLayout() {
        super.setupLayout()
        
        contentView.flex.direction(.column).define { flex in
            flex.addItem(scrollView)
        }
        
        scrollContentView.flex.direction(.row).define { flex in
            flex.addItem(codeLabel).grow(1)
        }
        
        scrollView.addSubview(scrollContentView)
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        codeLabel.text = Constants.CodeLabel.defaultText
    }
    
    private func layout() {
        contentView.pin.all()
        contentView.flex.layout()
        
        scrollContentView.pin
            .vertically()
            .left()
        
        scrollContentView.flex.layout(mode: .adjustWidth)
        scrollView.contentSize = scrollContentView.frame.size
    }
    
    // MARK: - View Drawing Cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }

    // MARK: - Bind
    public func bind(_ listener: DKCodeTableViewCellListener) {
//        listener.codeObservable
//            .bind(to: codeLabel.rx.text)
//            .disposed(by: disposeBag)
    }
    
    public func setupCode(_ code: String) {
//        codeLabel.text = code
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
