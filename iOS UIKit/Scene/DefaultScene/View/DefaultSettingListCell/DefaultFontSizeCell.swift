//
//  DefaultFontSizeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa

class DefaultFontSizeCell: DefaultCell {
    
    class override var cellId: String {
        get { DefaultFontSizeCellConstants.cellId }
    }
    
    private lazy var minNumLabel: UILabel = {
        let label = UILabel()
        label.text = DefaultFontSizeCellConstants.minNumLabelText
        label.font = DefaultViewControllerConstants.defaultFont
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(
            DefaultFontSizeCellConstants.numLabelContentCompressionResistancePriority,
            for: .horizontal
        )
        return label
    }()
    
    lazy var maxNumLabel: UILabel = {
        let label = UILabel()
        label.text = DefaultFontSizeCellConstants.maxNumLabelText
        label.font = DefaultViewControllerConstants.defaultFont
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(
            DefaultFontSizeCellConstants.numLabelContentCompressionResistancePriority,
            for: .horizontal
        )
        return label
    }()
    
    lazy var fontSizeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = DefaultFontSizeCellConstants.sliderMinimumValue
        slider.maximumValue = DefaultFontSizeCellConstants.sliderMaximimValue
        return slider
    }()
    
    private lazy var sliderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minNumLabel, fontSizeSlider, maxNumLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = DefaultFontSizeCellConstants.sliderStackViewSpacing
        return stackView
    }()
    
    lazy var sliderValueLabel: UILabel = {
        let label = UILabel()
        label.text = DefaultFontSizeCellConstants.sliderValueLabelText
        label.font = DefaultViewControllerConstants.defaultFont
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
        
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sliderValueLabel, sliderStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = DefaultFontSizeCellConstants.sliderStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func attribute() {
        super.attribute()
        fontSizeSlider.setValue(DefaultFontSizeCellConstants.sliderValue, animated: true)
        fontSizeSlider.rx.value
            .compactMap { Int($0) }
            .bind(to: self.rx.sliderText)
            .disposed(by: disposeBag)
    }
    
    override func layout() {
        super.layout()
        contentView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            minNumLabel.widthAnchor.constraint(equalToConstant: DefaultFontSizeCellConstants.numLabelWidth),
            maxNumLabel.widthAnchor.constraint(equalToConstant: DefaultFontSizeCellConstants.numLabelWidth),
            
            containerStackView.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                constant: DefaultViewControllerConstants.defaultOffset
            ),
            containerStackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: DefaultViewControllerConstants.defaultOffset
            ),
            containerStackView.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -DefaultViewControllerConstants.defaultOffset
            ),
            containerStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -DefaultViewControllerConstants.defaultOffset
            )
        ])

    }
    
}

extension Reactive where Base: DefaultFontSizeCell {
    var sliderText: Binder<Int> {
        return Binder(base) { base, value in
            base.sliderValueLabel.text = "\(value)"
        }
    }
}
