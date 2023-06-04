//
//  StackViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class StackViewController: DefaultListViewController {
    
    private weak var coordinator: StackViewCoordinatorProtocol?
    private var viewModel: StackViewViewModelProtocl!
    
    
    static func create(
        _ coordinator: StackViewCoordinatorProtocol,
        _ viewModel: StackViewViewModelProtocl
    ) -> StackViewController {
        let viewController = StackViewController()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        viewController.bind()
        return viewController
    }
    
    // MARK: - UI구현
    private lazy var firstObject: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = StackViewControllerConstants.objectFontSize
        label.text = StackViewControllerConstants.firstObjectTitle
        label.backgroundColor = StackViewControllerConstants.firstObjectBackgroundColor
        return label
    }()
    
    private lazy var secondObject: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = StackViewControllerConstants.objectFontSize
        label.text = StackViewControllerConstants.secondObjectTitle
        label.backgroundColor = StackViewControllerConstants.secondObjectBackgroundColor
        return label
    }()
    
    private lazy var thirdObject: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = StackViewControllerConstants.objectFontSize
        label.text = StackViewControllerConstants.thirdObjectTitle
        label.backgroundColor = StackViewControllerConstants.thirdObjectBackgroundColor
        return label
    }()
    
    private lazy var arrangedSubviews: [UIView] = [firstObject, secondObject, thirdObject]
    
    lazy var targetStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = StackViewControllerConstants.targetSpacing
        return stackView
    }()
    
    // MARK: - 라이프사이클
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.finish()
    }
    
    // MARK: - 바인딩
    private func bind() {
        
    }
    
    // MARK: - 레이아웃
    override func attribute() {
        super.attribute()
        navigationItem.title = StackViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        containerView.addSubview(targetStackView)
        
        targetStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(StackViewControllerConstants.defaultOffset)
        }
    }
    
    
    override func getDocumentURLString() -> String {
        LabelViewControllerConstants.documentURLString
    }
    
    @objc override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    override func settingListConfigure() {
        super.settingListConfigure()
    }
    
    deinit {
        print("StackViewController Deinit")
    }

}
