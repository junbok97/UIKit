//
//  ColorTableViewCell.swift
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

public protocol ColorTableViewCellListener: AnyObject {
    var selectColor: AnyObserver<UIColor> { get }
}

public final class ColorTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Attribute
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let rootFlexContainer: UIView = UIView()
    private let titleLabel: UILabel = .init()
    private let colorWell: UIColorWell = .init()
    
    // MARK: - Func
    
    override func setAttribute() {
        super.setAttribute()
        
        titleLabel.font = DKDefaultConstants.font
        titleLabel.textColor = .label
        titleLabel.text = Constants.TitleLabel.defaultText
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.row).define { flex in
            flex.addItem(titleLabel).grow(1)
            flex.addItem(colorWell)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(DKDefaultConstants.inset)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    override func reset() {
        super.reset()
        
        titleLabel.text = Constants.TitleLabel.defaultText
        disposeBag = DisposeBag()
    }
    
    public func setupTitleLabel(_ title: String) {
        titleLabel.text = title
    }
    
    public func bind(_ listener: ColorTableViewCellListener) {
        colorWell.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .compactMap { (object, _) -> UIColor? in
                object.colorWell.selectedColor
            }
            .distinctUntilChanged()
            .bind(to: listener.selectColor)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - Constants

private extension ColorTableViewCell {
    
    enum Constants {
        enum TitleLabel {
            static var defaultText: String { "default Color" }
        }
        
    }
}
