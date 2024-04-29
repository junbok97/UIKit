//
//  CodeTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

import SnapKit
import Extensions

public final class CodeTableViewCell: BaseTableViewCell {
    
    // MARK: - UI
    private let codeLabel: UILabel = .init()
    
    // MARK: - Func
    
    override func setAttribute() {
        super.setAttribute()
        
        codeLabel.backgroundColor = .systemBackground
        codeLabel.text = Constants.CodeLabel.defaultText
        codeLabel.font = Constants.CodeLabel.font
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.addSubview(codeLabel)
        
        codeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.inset)
        }
    }

    
    override func reset() {
        super.reset()
        codeLabel.text = Constants.CodeLabel.defaultText
    }
    
    func setupCodeLabel(_ codeString: String) {
        codeLabel.text = codeString
    }
    
}


// MARK: - Constants
private extension CodeTableViewCell {
    
    enum Constants {
        static var inset: CGFloat { 10 }
        
        enum CodeLabel {
            static var defaultText: String { "default Code" }
            static var font: UIFont { .systemFont(ofSize: 16) }
        }
        
    }
    
}
