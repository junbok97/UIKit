//
//  StepperViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

final class StepperViewController: DefaultListViewController {
    weak var coordinator: StepperCoordinatorProtocol?
    private var viewModel: StepperViewModelProtocol!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<StepperSettingListSectionModel> =
    viewModel.stepperSettingListDataSource()
    
    static func create(
        _ coordinator: StepperCoordinatorProtocol,
        _ viewModel: StepperViewModelProtocol
    ) -> StepperViewController {
        let viewController = StepperViewController()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        viewController.bind()
        return viewController
    }
    
    // MARK: - UI구현
    lazy var targetValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = StepperViewControllerConstants.defaultFont
        label.text = StepperViewControllerConstants.valueLabelText
        return label
    }()
    
    lazy var targetStepper: UIStepper = {
        let stepper = UIStepper()   
        stepper.value = StepperViewControllerConstants.defaulSteppertValue
        stepper.minimumValue = StepperViewControllerConstants.defaultStepperMinimumValue
        stepper.maximumValue = StepperViewControllerConstants.defaultStepperMaximumValue
        return stepper
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [targetValueLabel, targetStepper])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = StepperViewControllerConstants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    @objc override func didTappedLeftBarButton() { coordinator?.finish() }
    
    // MARK: - 바인딩
    private func bind() {
        
        targetStepper.rx.value
            .bind(to: viewModel.targetStepperDidChanged)
            .disposed(by: disposeBag)
        
        viewModel.stepperSettingListCellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        settingList.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.targetVauleLabelText
            .drive(self.rx.targetValueLabelText)
            .disposed(by: disposeBag)
        
        viewModel.targetStepValue
            .drive(self.rx.targetStepperValue)
            .disposed(by: disposeBag)
        
        viewModel.targetMaximumValue
            .drive(self.rx.targetStepperMaximumValue)
            .disposed(by: disposeBag)
        
        viewModel.targetMinimumValue
            .drive(self.rx.targetStepperMinimumValue)
            .disposed(by: disposeBag)
        
        viewModel.targetAutorepeat
            .drive(self.rx.targetAutorepeat)
            .disposed(by: disposeBag)
        
        viewModel.targetWrap
            .drive(self.rx.targetWrap)
            .disposed(by: disposeBag)
            
    }
    
    // MARK: - 레이아웃
    override func attribute() {
        super.attribute()
        navigationItem.title = StepperViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        
        containerView.addSubview(stackView)
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(StepperViewControllerConstants.containerViewHeight)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(containerView).inset(StepperViewControllerConstants.defaultOffset)
        }
    }
    
    override func getDocumentURLString() -> String {
        StepperViewControllerConstants.documentURLString
    }
    
    override func settingListConfigure() {
        super.settingListConfigure()
        StepperValueCell.register(tableView: settingList)
        StepperCodeCell.register(tableView: settingList)
        StepperToggleCell.register(tableView: settingList)
    }
    
    deinit {
        print("StepperViewController Deinit")
    }
}

// MARK: - UITableViewDelegate
extension StepperViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DefaultSettingListHeaderView()
        headerView.setupHeaderTitle(dataSource[section].sectionHeader.rawValue)
        return headerView
    }
}

// MARK: - Reactive
extension Reactive where Base: StepperViewController {
    var targetValueLabelText: Binder<String> {
        Binder(base) { base, text in
            base.targetValueLabel.text = text
        }
    }
    
    var targetStepperValue: Binder<Double> {
        Binder(base) { base, value in
            base.targetStepper.stepValue = value
        }
    }
    
    var targetStepperMaximumValue: Binder<Double> {
        Binder(base) { base, value in
            base.targetStepper.maximumValue = value
        }
    }
    
    var targetStepperMinimumValue: Binder<Double> {
        Binder(base) { base, value in
            base.targetStepper.minimumValue = value
        }
    }
    
    var targetAutorepeat: Binder<Bool> {
        Binder(base) { base, value in
            base.targetStepper.autorepeat = value
        }
    }
    
    var targetWrap: Binder<Bool> {
        Binder(base) { base, value in
            base.targetStepper.wraps = value
        }
    }

}
