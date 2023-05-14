//
//  LabelViewController.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelViewController: DefaultViewController {
    
    weak var coordinator: LabelCoordinatorProtocol?
    private var viewModel: LabelViewModel!
    
    static func create(
        _ viewModel: LabelViewModel,
        _ coordinator: LabelCoordinatorProtocol
    ) -> LabelViewController {
        let viewController = LabelViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.bind()
        return viewController
    }
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = LabelViewConstants.title
        label.font = LabelViewConstants.targetLabelFont
        label.numberOfLines = LabelViewConstants.targetLabelNumberOfLines
        label.clipsToBounds = true
        label.layer.cornerRadius = LabelViewConstants.targetLabelCornerRadius
        label.textAlignment = .center
        label.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.finish()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func bind() {
        super.bind()
        let dataSource = viewModel.labelSettingListDataSource()
        viewModel.labelSettingListCellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        settingList.rx.itemSelected
            .map { indexPath in
                dataSource[indexPath.section].items[indexPath.row]
            }
            .bind(to: viewModel.didItemSelectedLabelSettingList)
            .disposed(by: disposeBag)
        
        viewModel.targetText
            .drive(self.rx.targetText)
            .disposed(by: disposeBag)
        
        viewModel.targetFont
            .drive(self.rx.targetFont)
            .disposed(by: disposeBag)
        
        viewModel.targetColor
            .drive(self.rx.targetColor)
            .disposed(by: disposeBag)
        
        viewModel.targetAlignment
            .drive(self.rx.targetAlignment)
            .disposed(by: disposeBag)
        
        viewModel.targetNumberOfLines
            .drive(self.rx.targetNumberOfLines)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.title = LabelViewConstants.title
        tableViewCellConfigure()
    }
    
    override func layout() {
        super.layout()
        containerView.addSubview(targetLabel)
        
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LabelViewConstants.targetLabelOffset),
            targetLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LabelViewConstants.targetLabelOffset),
            targetLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LabelViewConstants.targetLabelOffset),
            targetLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -LabelViewConstants.targetLabelOffset)
        ])
    }
    
    override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
}

private extension LabelViewController {
    func tableViewCellConfigure() {
        LabelTextCell.register(tableView: settingList)
        LabelFontCell.register(tableView: settingList)
        LabelFontSizeCell.register(tableView: settingList)
        LabelColorCell.register(tableView: settingList)
        LabelAlignmentCell.register(tableView: settingList)
        LabelNumberOfLinesCell.register(tableView: settingList)
    }
}

extension Reactive where Base: LabelViewController {
    var targetText: Binder<String> {
        return Binder(base) { base, text in
            base.targetLabel.text = text
        }
    }
    
    var targetFont: Binder<UIFont> {
        return Binder(base) { base, font in
            base.targetLabel.font = font
        }
    }
    
    var targetColor: Binder<LabelColor> {
        return Binder(base) { base, labelColor in
            switch labelColor.colorType {
            case .textColor:
                base.targetLabel.textColor = labelColor.color
            case .backgroundColor:
                base.targetLabel.backgroundColor = labelColor.color
            }
        }
    }
    
    var targetAlignment: Binder<LabelAlignmentType> {
        return Binder(base) { base, alignment in
            base.targetLabel.textAlignment = alignment.aligment
        }
    }
    
    var targetNumberOfLines: Binder<Int> {
        return Binder(base) { base, numberOfLines in
            base.targetLabel.numberOfLines = numberOfLines
        }
    }
    
}
