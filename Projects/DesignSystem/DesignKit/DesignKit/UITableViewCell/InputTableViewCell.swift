//
//  InputTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 5/3/24.
//

import UIKit

import PinLayout
import RxSwift
import RxCocoa

import Extensions

public protocol InputTableViewCellListener: AnyObject {
    var inputText: AnyObserver<String> { get }
}

public final class InputTableViewCell: BaseTableViewCell {
    
    // MARK: - Attribute
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let inputTextField: UITextField = .init()

    // MARK: - Func
    
    override func setAttribute() {
        super.setAttribute()
        
        inputTextField.returnKeyType = .done
        inputTextField.placeholder = Constants.InputTextField.placeHolder
        inputTextField.font = DefaultConstants.font
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.addSubview(inputTextField)
        inputTextField.pin.all(DefaultConstants.inset)
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        inputTextField.placeholder = Constants.InputTextField.placeHolder
    }
    
    public func bind(_ listener: InputTableViewCellListener) {
        inputTextField.rx.text
            .compactMap { $0 }
            .subscribe(listener.inputText)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UITextFieldDelegate
extension InputTableViewCell: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - Constants
private extension InputTableViewCell {
    
    enum Constants {
        
        enum InputTextField {
            static var placeHolder: String { "Input Text" }
        }
    }
    
}

