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
import Then

public protocol DKStepperTableViewCellListener: AnyObject {
    var stepperValueChanged: AnyObserver<Double> { get }
}

public final class DKStepperTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let stepperValueLabel = UILabel().then { label in
        label.font = DKDefaultConstants.font
        label.textAlignment = .left
    }
    private let stepper = UIStepper().then { stepper in
        stepper.maximumValue = Constants.Stepper.maximumValue
        stepper.minimumValue = Constants.Stepper.minimumValue
    }
    
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
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.flex.padding(DKDefaultConstants.padding).define { flex in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(stepperValueLabel).grow(1)
                flex.addItem(stepper)
            }
        }
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()

        stepperValueLabel.text = Constants.StepperValueLabel.defaultText
        
        stepper.value = Constants.Stepper.defaultValue
        stepper.rx.value
            .withUnretained(self)
            .bind { object, stepperValue in
                object.stepperValueLabel.text = "\(Int(stepperValue))"
            }
            .disposed(by: disposeBag)
    }
    
    public func setupStepperValue(_ value: Double) {
        stepper.value = value
    }
    
    // MARK: - Bind
    public func bind(_ listener: DKStepperTableViewCellListener) {
        stepper.rx.value
            .bind(to: listener.stepperValueChanged)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - Constants
private extension DKStepperTableViewCell {
    
    enum Constants {
        enum StepperValueLabel {
            static var defaultText: String { "\(Int(Constants.Stepper.defaultValue))" }
        }
        
        enum Stepper {
            static var defaultValue: Double { 1 }
            static var minimumValue: Double { 0 }
            static var maximumValue: Double { 100 }
        }
    }
    
}
