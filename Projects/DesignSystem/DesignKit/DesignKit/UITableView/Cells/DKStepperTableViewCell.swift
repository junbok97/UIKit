//
//  DKStepperTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 5/13/24.
//

import UIKit

import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

public protocol DKStepperTableViewCellListener: AnyObject {
    var stepperChangedValue: AnyObserver<Double> { get }
    var stepperCurrentValue: Observable<Double> { get }
}

public final class DKStepperTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let titleLabel: UILabel = .init()
    private let stepperCurrentValueLabel: UILabel = .init()
    private let stepper: UIStepper = .init()
    
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
        titleLabel.text = Constants.TitleLabel.defaultText
        titleLabel.textAlignment = .left
        
        stepperCurrentValueLabel.font = DKDefaultConstants.font
        stepperCurrentValueLabel.text = Constants.StepperValueLabel.defaultText
        stepperCurrentValueLabel.textAlignment = .center
        
        stepper.value = Constants.Stepper.defaultValue
        stepper.minimumValue = Constants.Stepper.minimumValue
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.flex.padding(DKDefaultConstants.padding).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(titleLabel).grow(1)
                flex.addItem(stepperCurrentValueLabel).paddingRight(DKDefaultConstants.padding).paddingLeft(DKDefaultConstants.padding)
                flex.addItem(stepper)
            }
        }
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        titleLabel.text = Constants.TitleLabel.defaultText
        stepper.value = Constants.Stepper.defaultValue
    }
    
    public func setupTitle(_ title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Bind
    public func bind(_ listener: DKStepperTableViewCellListener) {
        stepper.rx.value
            .bind(to: listener.stepperChangedValue)
            .disposed(by: disposeBag)
        
        listener.stepperCurrentValue
            .withUnretained(self)
            .subscribe(on: MainScheduler.instance)
            .bind { object, currentValue in
                object.stepperCurrentValueLabel.text = "\(currentValue)"
            }.disposed(by: disposeBag)
    }
    
}

// MARK: - Constants
private extension DKStepperTableViewCell {
    
    enum Constants {
        enum TitleLabel {
            static var defaultText: String { "Stepper" }
        }
        
        enum StepperValueLabel {
            static var defaultText: String { "\(Int(Constants.Stepper.defaultValue))" }
        }
        
        enum Stepper {
            static var defaultValue: Double { 1 }
            static var minimumValue: Double { 0 }
        }
    }
    
}
