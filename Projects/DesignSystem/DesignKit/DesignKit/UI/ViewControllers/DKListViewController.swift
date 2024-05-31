//
//  DKTableViewController.swift
//  DesignKit
//
//  Created by 이준복 on 5/25/24.
//

import UIKit

open class DKListViewController: DKBaseViewController {
    
    // MARK: - UI
    public let containerView = UIView().then { view in
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.ContainerView.cornerRadius
        view.backgroundColor = .secondarySystemBackground
    }
    public let tableView = UITableView(frame: .zero, style: .insetGrouped).then { tableView in
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .secondarySystemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    // MARK: - View Methods
    open override func setupAttribute() {
        super.setupAttribute()
        
        view.backgroundColor = .secondarySystemBackground
        setupNaviBar()
    }
    
    open override func setupLayout() {
        super.setupLayout()
        
        view.addSubviews(containerView, tableView)
    }
    
    // MARK: - View Life Cycles
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.pin
            .margin(Constants.margin)
            .top(view.pin.safeArea)
            .left(view.pin.safeArea)
            .right(view.pin.safeArea)
            .height(Constants.ContainerView.height)
         
        tableView.pin
            .marginTop(Constants.margin)
            .below(of: containerView)
            .left(view.pin.safeArea)
            .right(view.pin.safeArea)
            .bottom(view.pin.safeArea)
    }
    
    // MARK: - NavigationItem
    open func setupNavigationItemTitle() {
        navigationItem.title = Constants.title
    }
    
    open func getAppleDeveloperDocumentation() -> String {
        Constants.NaviRightBarButtonItem.documentURLString
    }
    
}

// MARK: - NaviBar
private extension DKListViewController {
    
    func setupNaviBar() {
        setupNavigationItemTitle()
        naviRightBarButtonItem()
        
        navigationItem.backButtonTitle = nil
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem?.tintColor = .label
        
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    func naviRightBarButtonItem() {
        navigationItem.rightBarButtonItem = .init(
            image: Constants.NaviRightBarButtonItem.buttonImage,
            style: .plain,
            target: self,
            action: #selector(naviRightBarButtonItemDidTapped)
        )
    }
    
    @objc
    func naviRightBarButtonItemDidTapped() {
        guard let url = URL(string: getAppleDeveloperDocumentation()) else { return }
        UIApplication.shared.open(url, options: [:])
    }
    
}

// MARK: - Constants
private extension DKListViewController {
    
    enum Constants {
        static var title: String { "UIKit" }
        static var margin: CGFloat { 20 }
        
        enum ContainerView {
            static var height: CGFloat { 200 }
            static var cornerRadius: CGFloat { 8 }
        }
        
        enum NaviRightBarButtonItem {
            static var documentURLString: String { "https://developer.apple.com/documentation/uikit" }
            static var buttonImage: UIImage? { .init(systemName: "safari") }
        }
    }
    
}
