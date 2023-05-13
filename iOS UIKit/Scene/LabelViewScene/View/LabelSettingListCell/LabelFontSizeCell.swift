//
//  LabelFontSizeCell.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelFontSizeCell: DefaultLabelSettingListCell {
    
    static override var cellId: String { LabelFontSizeCellConstants.cellId }
    
    private lazy var minNumLabel: UILabel = {
        let label = UILabel()
        label.text = LabelFontSizeCellConstants.minNumLabelText
        label.font = LabelViewConstants.defaultFont
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(
            LabelFontSizeCellConstants.numLabelContentCompressionResistancePriority,
            for: .horizontal
        )
        return label
    }()
    
    private lazy var maxNumLabel: UILabel = {
        let label = UILabel()
        label.text = LabelFontSizeCellConstants.maxNumLabelText
        label.font = LabelViewConstants.defaultFont
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(
            LabelFontSizeCellConstants.numLabelContentCompressionResistancePriority,
            for: .horizontal
        )
        return label
    }()
    
    private lazy var fontSizeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = LabelFontSizeCellConstants.sliderMinimumValue
        slider.maximumValue = LabelFontSizeCellConstants.sliderMaximimValue
        return slider
    }()
    
    private lazy var sliderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minNumLabel, fontSizeSlider, maxNumLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = LabelFontSizeCellConstants.sliderStackViewSpacing
        return stackView
    }()
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.text = LabelFontSizeCellConstants.sizeLabelText
        label.font = LabelViewConstants.defaultFont
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    lazy var sliderValueLabel: UILabel = {
        let label = UILabel()
        label.text = LabelFontSizeCellConstants.sliderValueLabelText
        label.font = LabelViewConstants.defaultFont
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()
    
    private lazy var sizeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sizeLabel, sliderValueLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = LabelFontSizeCellConstants.sliderStackViewSpacing
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sizeStackView, sliderStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = LabelFontSizeCellConstants.sliderStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind(_ viewModel: LabelViewModel) {
        fontSizeSlider.rx.value
            .startWith(LabelViewConstants.targetLabelFontSize)
            .map { Int($0) }
            .distinctUntilChanged()
            .bind(to: viewModel.fontSizeCellDidChangedFontSizeSlider)
            .disposed(by: disposeBag)
        
        viewModel.fontSizeCellSliderText
            .drive(self.rx.sliderText)
            .disposed(by: disposeBag)
    }
    
}

private extension LabelFontSizeCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
        fontSizeSlider.setValue(LabelFontSizeCellConstants.sliderValue, animated: true)
    }
    
    func layout() {
        contentView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            minNumLabel.widthAnchor.constraint(equalToConstant: LabelFontSizeCellConstants.numLabelWidth),
            maxNumLabel.widthAnchor.constraint(equalToConstant: LabelFontSizeCellConstants.numLabelWidth),
            
            containerStackView.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                constant: LabelViewConstants.defaultOffset
            ),
            containerStackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: LabelViewConstants.defaultOffset
            ),
            containerStackView.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -LabelViewConstants.defaultOffset
            ),
            containerStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -LabelViewConstants.defaultOffset
            )
        ])
    }
}

extension Reactive where Base: LabelFontSizeCell {
    var sliderText: Binder<Int> {
        return Binder(base) { base, value in
            base.sliderValueLabel.text = "\(value)"
        }
    }
}
