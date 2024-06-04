//
//  DKLabelTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

import RxSwift
import PinLayout
import Then

import Extensions

public protocol DKLabelTableViewCellListener: AnyObject {
    var textObservable: Observable<String> { get }
}

public final class DKLabelTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let label = UILabel().then { label in
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.numberOfLines = Constants.Label.numberOfLines
    }
    
    // MARK: - View Methods
    override func setupLayout() {
        super.setupLayout()
        
        contentView.addSubview(label)
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        
        label.font = DKDefaultConstants.font
        label.text = Constants.Label.defaultText
    }
    
    // MARK: - View Drawing Cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        label.pin.all(DKDefaultConstants.padding)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let availableSize = CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude)
        return CGSize(
            width: size.width,
            height: label.sizeThatFits(availableSize).height + (DKDefaultConstants.padding * 2))
    }

    public func bind(_ listener: DKLabelTableViewCellListener) {
        listener.textObservable
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Logic
    public func setup(
        text: String,
        ofSize: CGFloat = DKDefaultConstants.fontSize,
        weight: UIFont.Weight = .regular,
        textAlignment: NSTextAlignment = .left
    ) {
        label.text = text
        label.font = .systemFont(ofSize: ofSize, weight: weight)
        label.textAlignment = textAlignment
    }
    
}

// MARK: - Constants
private extension DKLabelTableViewCell {
    
    enum Constants {
        enum Label {
            static var numberOfLines: Int { 0 }
            static var defaultText: String { "default Text" }
        }
    }
    
}
