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
import Then

import Extensions

public protocol DKInputTableViewCellListener: AnyObject {
    var inputTextChanged: AnyObserver<String> { get }
}

public final class DKInputTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let inputTextField = UITextField().then { textField in
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .never
        textField.enablesReturnKeyAutomatically = true
        textField.spellCheckingType = .no
        textField.rightViewMode = .always
        textField.returnKeyType = .done
        textField.font = DKDefaultConstants.font
    }
    
    // MARK: - View Methods
    override func setupAttribute() {
        super.setupAttribute()
        
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
            .bind(to: listener.inputTextChanged)
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

