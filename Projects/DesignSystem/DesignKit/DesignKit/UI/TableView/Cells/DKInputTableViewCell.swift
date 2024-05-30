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
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let inputTextField: UITextField = .init()
    
    // MARK: - View Methods
    override func setupAttribute() {
        super.setupAttribute()
        
        inputTextField.autocorrectionType = .no
        inputTextField.autocapitalizationType = .none
        inputTextField.clearButtonMode = .never
        inputTextField.enablesReturnKeyAutomatically = true
        inputTextField.spellCheckingType = .no
        inputTextField.rightViewMode = .always
        inputTextField.returnKeyType = .done
        inputTextField.font = DKDefaultConstants.font
        inputTextField.delegate = self
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.addSubview(inputTextField)
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        
        inputTextField.placeholder = Constants.InputTextField.placeHolder
    }
    
    // MARK: - View Drawing Cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        inputTextField.pin.all(DKDefaultConstants.padding)
    }
    
    
    // MARK: - Bind
    public func bind(_ listener: DKInputTableViewCellListener) {
        inputTextField.rx.text
            .compactMap { $0 }
            .bind(onNext: listener.textChanged)
            .disposed(by: disposeBag)
    }
    
    public func setupPlaceholder(_ placeholder: String) {
        inputTextField.placeholder = placeholder
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

