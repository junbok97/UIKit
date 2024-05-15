//
//  DKInputTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 5/3/24.
//

import UIKit

import PinLayout
import RxSwift
import RxCocoa

import Extensions

public protocol DKInputTableViewCellListener: AnyObject {
    func textChanged(_ text: String)
}

public final class DKInputTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Attribute
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let inputTextField: UITextField = .init()

    // MARK: - Func
    
    override func setAttribute() {
        super.setAttribute()
        
        inputTextField.returnKeyType = .done
        inputTextField.placeholder = Constants.InputTextField.placeHolder
        inputTextField.font = DKDefaultConstants.font
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.addSubview(inputTextField)
        inputTextField.pin.all(DKDefaultConstants.inset)
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        inputTextField.placeholder = Constants.InputTextField.placeHolder
    }
    
    public func bind(_ listener: DKInputTableViewCellListener) {
    
        inputTextField.rx.text
            .compactMap { $0 }
            .bind(onNext: listener.textChanged)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UITextFieldDelegate
extension DKInputTableViewCell: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - Constants
private extension DKInputTableViewCell {
    
    enum Constants {
        
        enum InputTextField {
            static var placeHolder: String { "Input Text" }
        }
    }
    
}

