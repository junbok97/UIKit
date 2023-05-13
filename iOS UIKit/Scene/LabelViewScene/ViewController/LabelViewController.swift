//
//  LabelViewController.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelViewController: UIViewController {
    
    weak var coordinator: LabelCoordinatorProtocol?
    
    private let disposeBag = DisposeBag()
    private var viewModel: LabelViewModel!
    
    static func create(
        _ viewModel: LabelViewModel,
        _ coordinator: LabelCoordinatorProtocol
    ) -> LabelViewController {
        let labelViewController = LabelViewController()
        labelViewController.viewModel = viewModel
        labelViewController.coordinator = coordinator
        labelViewController.bind()
        return labelViewController
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private lazy var labelSettingList: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .singleLine
        LabelTextCell.register(tableView: tableView)
        LabelFontCell.register(tableView: tableView)
        LabelFontSizeCell.register(tableView: tableView)
        LabelColorCell.register(tableView: tableView)
        LabelAlignmentCell.register(tableView: tableView)
        LabelNumberOfLinesCell.register(tableView: tableView)
        CodeLabelCell.register(tableView: tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    func bind() {
        let dataSource = viewModel.labelSettingListDataSource()
        viewModel.labelSettingListCellDatas
            .drive(labelSettingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        labelSettingList.rx.itemSelected
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
    
}

private extension LabelViewController {
    func attribute() {
        view.backgroundColor = .secondarySystemBackground
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = LabelViewConstants.title
    }
    
    func layout() {
        [containerView, labelSettingList].forEach { view.addSubview($0) }
        containerView.addSubview(targetLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: LabelViewConstants.containerViewHeight),
            
            targetLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LabelViewConstants.targetLabelOffset),
            targetLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LabelViewConstants.targetLabelOffset),
            targetLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LabelViewConstants.targetLabelOffset),
            targetLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -LabelViewConstants.targetLabelOffset),
            
            labelSettingList.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            labelSettingList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelSettingList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            labelSettingList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
