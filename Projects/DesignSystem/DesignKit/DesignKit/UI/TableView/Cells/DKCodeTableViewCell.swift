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

import Extensions

public protocol DKCodeTableViewCellListener: AnyObject {
    var codeObservable: Observable<String> { get }
}


public final class DKCodeTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let containerView = UIView()
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let codeLabel = UILabel().then { label in
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.numberOfLines = Constants.CodeLabel.numberOfLines
    }
    private let copyButton = UIButton(configuration: .filled()).then { button in
        button.setTitle(Constants.CopyButton.title, for: .normal)
    }
    
    // MARK: - View Methods
    override func setupLayout() {
        super.setupLayout()
        
        scrollContentView.flex.define { flex in
            flex.addItem(codeLabel)
        }
        scrollView.addSubview(scrollContentView)
        contentView.addSubview(scrollView)
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        codeLabel.text = Constants.CodeLabel.defaultText
    }
    
    // MARK: - View Drawing Cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.pin
            .horizontally()
            .vertically(DKDefaultConstants.padding)
        
        scrollContentView.pin
            .vertically()
            .left()
        
        scrollContentView.flex.layout(mode: .adjustWidth)
        scrollView.contentSize = scrollContentView.frame.size
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let availableSize = CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude)
        return CGSize(
            width: size.width,
            height: codeLabel.sizeThatFits(availableSize).height + DKDefaultConstants.padding)
    }


    // MARK: - Bind
    public func bind(_ listener: DKCodeTableViewCellListener) {
        listener.codeObservable
            .bind(to: codeLabel.rx.text)
            .disposed(by: disposeBag)
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
