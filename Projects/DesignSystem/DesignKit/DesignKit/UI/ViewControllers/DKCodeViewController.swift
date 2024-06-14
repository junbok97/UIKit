//
//  DKCodeViewController.swift
//  DesignKit
//
//  Created by 이준복 on 6/13/24.
//

import UIKit

public final class DKCodeViewController: DKBaseViewController {
    
    // MARK: - UI
    private let scrollView = UIScrollView().then { scrollView in
        scrollView.alwaysBounceVertical = true
    }
    private let contentView = UIView().then { view in
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.ContentView.cornerRadius
    }
    
    private let codeLabel = UILabel().then { label in
        label.text = Constants.CodeLabel.defaultText
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.numberOfLines = Constants.CodeLabel.numberOfLines
    }
    // MARK: - View Methods
    public override func setupAttribute() {
        super.setupAttribute()
        
        view.backgroundColor = .secondarySystemBackground
        scrollView.backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
    }
    
    public override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.flex.define { flex in
            flex.addItem(codeLabel).grow(1)
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin.all(view.pin.safeArea)
        contentView.pin
            .margin(Constants.margin)
            .top().left().right()
        
        contentView.flex.layout(mode: .adjustHeight)
        
        // 3) Adjust the scrollview contentSize
        scrollView.contentSize = contentView.frame.size
    }
    
    public func setupCode(_ code: String) {
        DispatchQueue.main.async { [weak self] in
            self?.codeLabel.text = code
        }
    }
    
}

// MARK: - Constants
private extension DKCodeViewController {
    
    enum Constants {
        static var title: String { "Code" }
        static var margin: CGFloat { 20 }
        
        enum ContentView {
            static var cornerRadius: CGFloat { 8 }
        }
        
        enum CodeLabel {
            static var numberOfLines: Int { 0 }
            static var defaultText: String { """
                private let codeView = UITextView().then { textView in
                    textView.isEditable = false
                    textView.font = DKDefaultConstants.font
                }
            """}
        }
        
        enum CopyButton {
            static var title: String { "Copy" }
        }
    }
    
}
