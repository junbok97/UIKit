//
//  StepperViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import UIKit

protocol StepperViewControllerConstantsProtocol: DefaultViewControllerConstantsProtocol {
    static var defaulSteppertValue: Double { get }
    static var defaultStepperMinimumValue: Double { get }
    static var defaultStepperMaximumValue: Double { get }
    
    static var valueLabelText: String { get }
    static var stackViewSpacing: CGFloat { get }
    static var defaultStepperCode: String { get }
}

extension StepperViewControllerConstantsProtocol {
    static var defaultFont: UIFont { .boldSystemFont(ofSize: 20) }
    static var title: String { "Stepper" }
    static var documentURLString: String { "https://developer.apple.com/documentation/uikit/uistepper" }

    static var valueLabelText: String { "\(StepperViewControllerConstants.defaulSteppertValue)"}
    
    static var defaulSteppertValue: Double { 1 }
    static var defaultStepperMinimumValue: Double { 0 }
    static var defaultStepperMaximumValue: Double { 10 }
    
    static var stackViewSpacing: CGFloat { 15 }
    static var containerViewHeight: CGFloat { 100 }
    static var defaultStepperCode: String {
        """
        lazy var stepper: UIStepper = {
            let stepper = UIStepper()
        
            stepper.autorepeat = false
            stepper.wraps = false
        
            stepper.stepValue = \(String(format: "%lf", 1))
            stepper.maximumValue = \(String(format: "%lf", defaultStepperMaximumValue))
            stepper.minimumValue = \(String(format: "%lf", defaultStepperMinimumValue))
            
            return stepper
        }()
        """

    }
    
}

struct StepperViewControllerConstants: StepperViewControllerConstantsProtocol {}
