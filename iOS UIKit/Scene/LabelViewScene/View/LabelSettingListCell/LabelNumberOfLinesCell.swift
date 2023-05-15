//
//  LabelLinesCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/08.
//

import UIKit
import RxSwift

final class LabelNumberOfLinesCell: DefaultCell, LabelSettingListCellProtocol {
    static override var cellId: String { LabelNumberOfLinesCellConstants.cellId }
    
    private lazy var linesLabel: UILabel = {
        let label = UILabel()
        label.font = LabelViewControllerConstants.defaultFont
        label.text = LabelNumberOfLinesCellConstants.linesLabelText
        label.textAlignment = .left
        return label
    }()
    
    lazy var stepperValueLabel: UILabel = {
        let label = UILabel()
        label.font = LabelViewControllerConstants.defaultFont
        label.text = LabelNumberOfLinesCellConstants.valueLabelText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var lineStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = LabelNumberOfLinesCellConstants.stepperValue
        stepper.minimumValue = LabelNumberOfLinesCellConstants.stepperMinimumValue
        stepper.maximumValue = LabelNumberOfLinesCellConstants.stepperMaximumValue
        return stepper
    }()
    
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [linesLabel, stepperValueLabel, lineStepper])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = LabelNumberOfLinesCellConstants.stackViewSpacing
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
    
    func setup(_ item: LabelSettingListItemType) { } 
    
    func bind(_ viewModel: LabelViewModel) {
        lineStepper.rx.value
            .map { Int($0) }
            .bind(to: viewModel.numberOfLinesCellDidChangedLineStepper)
            .disposed(by: disposeBag)
        
        viewModel.numberOfLinesCellStepperValueLabelText
            .drive(self.rx.stepperValueLabelText)
            .disposed(by: disposeBag)
    }
    
}

private extension LabelNumberOfLinesCell {
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {
        contentView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                constant: LabelViewControllerConstants.defaultOffset
            ),
            containerStackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: LabelViewControllerConstants.defaultOffset
            ),
            containerStackView.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -LabelViewControllerConstants.defaultOffset
            ),
            containerStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -LabelViewControllerConstants.defaultOffset
            )
        ])
    }
}

extension Reactive where Base: LabelNumberOfLinesCell {
    var stepperValueLabelText: Binder<Int> {
        return Binder(base) { base, value in
            base.stepperValueLabel.text = "\(value)"
        }
    }
}
