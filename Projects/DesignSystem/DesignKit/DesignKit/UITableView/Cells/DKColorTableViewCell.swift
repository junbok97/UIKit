//
//  DKColorTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 5/9/24.
//

import UIKit

import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

import Extensions

public protocol DKColorTableViewCellListener: AnyObject {
    func colorSelected(_ selectedColor: UIColor)
}

public final class DKColorTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let titleLabel: UILabel = .init()
    private let colorWell: UIColorWell = .init()
    
    // MARK: - View Life Cycles
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
    
    // MARK: - View Methods
    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }

    override func setAttribute() {
        super.setAttribute()
        
        titleLabel.font = DKDefaultConstants.font
        titleLabel.textColor = .label
        titleLabel.text = Constants.TitleLabel.defaultText
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.flex.padding(DKDefaultConstants.padding).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(titleLabel).grow(1)
                flex.addItem(colorWell)
            }
        }
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        titleLabel.text = Constants.TitleLabel.defaultText
    }
    
    public func setupTitleLabel(_ title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Bind
    public func bind(_ listener: DKColorTableViewCellListener) {
        colorWell.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .compactMap { (object, _) -> UIColor? in
                object.colorWell.selectedColor
            }
            .distinctUntilChanged()
            .bind(onNext: listener.colorSelected)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - Constants
private extension DKColorTableViewCell {
    
    enum Constants {
        enum TitleLabel {
            static var defaultText: String { "default Color" }
        }
    }
}
