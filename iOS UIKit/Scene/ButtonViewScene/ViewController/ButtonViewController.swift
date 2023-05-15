//
//  ButtonViewController.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import UIKit

final class ButtonViewController: DefaultViewController {
    
    weak var coordinator: ButtonCoordinatorProtocol?
    private var viewModel: ButtonViewModel!
    
    static func create(
        _ viewModel: ButtonViewModel,
        _ coordinator: ButtonCoordinatorProtocol
    ) -> ButtonViewController {
        let viewController = ButtonViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.bind()
        return viewController
    }
    
    let targetButton: UIButton = {
        let button = UIButton(configuration: .filled())
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .tintColor
        config.title = "Config Title"
        config.titleAlignment = .leading
        config.subtitle = "Config SubTitle"
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.black
            outgoing.font = UIFont.boldSystemFont(ofSize: 20)
            return outgoing
        }
        config.subtitleTextAttributesTransformer = transformer
//        button.configuration = config
        
        button.titleLabel?.text = "text"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    override func bind() {
        super.bind()
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.title = ButtonViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        containerView.addSubview(targetButton)
    
        NSLayoutConstraint.activate([
            targetButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ButtonViewControllerConstants.targetButtonVerticalOffset),
            targetButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ButtonViewControllerConstants.targetButtonHorizonOffset),
            targetButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ButtonViewControllerConstants.targetButtonHorizonOffset),
            targetButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ButtonViewControllerConstants.targetButtonVerticalOffset)
        ])
    }
    
}

private extension ButtonViewController {
    func settingListConfigure() {
        ButtonCodeCell.register(tableView: settingList)
        ButtonTextCell.register(tableView: settingList)
        ButtonFontCell.register(tableView: settingList)
        ButtonFontSizeCell.register(tableView: settingList)
        ButtonColorCell.register(tableView: settingList)
    }
}
