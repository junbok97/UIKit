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
    
    private lazy var presenter: LabelPresenter = LabelPresenter(viewController: self)
    private let disposeBag = DisposeBag()
    
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
        label.font = LabelViewConstants.defaultFont
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
        tableView.delegate = presenter
        tableView.dataSource = presenter
        LabelTextCell.register(target: tableView)
        LabelFontCell.register(target: tableView)
        LabelFontSizeCell.register(target: tableView)
        LabelColorCell.register(target: tableView)
        LabelAlignmentCell.register(target: tableView)
        LabelNumberOfLinesCell.register(target: tableView)
        CodeLabelCell.register(target: tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.finish()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
}

extension LabelViewController: LabelViewControllerProtocol {
    func bind(_ viewModel: LabelViewModel) {
        viewModel.targetText
            .drive(self.rx.targetText)
            .disposed(by: disposeBag)
        
        viewModel.targetFont
            .drive(self.rx.targetFont)
            .disposed(by: disposeBag)
        
        viewModel.targetTextColor
            .drive(self.rx.targetTextColor)
            .disposed(by: disposeBag)
        
        viewModel.targetBackgroundColor
            .drive(self.rx.targetBackgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.targetAlignment
            .drive(self.rx.targetAlignment)
            .disposed(by: disposeBag)
        
        viewModel.targetNumberOfLines
            .drive(self.rx.targetNumberOfLines)
            .disposed(by: disposeBag)
        
        Observable.just(UISystemFontWeightType.regular.rawValue)
            .bind(to: viewModel.fontCellRelay)
            .disposed(by: disposeBag)
        
        Observable.just(Int(LabelFontSizeCellConstants.sliderValue))
            .bind(to: viewModel.fontSizeCellRelay)
            .disposed(by: disposeBag)
            
    }
    
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
    
    var targetTextColor: Binder<UIColor> {
        return Binder(base) { base, textColor in
            base.targetLabel.textColor = textColor
        }
    }
    
    var targetBackgroundColor: Binder<UIColor> {
        return Binder(base) { base, textColor in
            base.targetLabel.backgroundColor = textColor
        }
    }
    
    var targetAlignment: Binder<NSTextAlignment> {
        return Binder(base) { base, alignment in
            base.targetLabel.textAlignment = alignment
        }
    }
    
    var targetNumberOfLines: Binder<Int> {
        return Binder(base) { base, numberOfLines in
            base.targetLabel.numberOfLines = numberOfLines
        }
    }
    
}
