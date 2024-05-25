//
//  DKTableViewController.swift
//  DesignKit
//
//  Created by 이준복 on 5/25/24.
//

import UIKit

import PinLayout
import Extensions

public final class DKTableViewController: DKBaseViewController {
    
    // MARK: - UI
    public let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    
    // MARK: - View Methods
    override func setupAttribte() {
        super.setupAttribte()
        
        setupNaviBar()
        view.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(tableView)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - View Life Cycles
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all(view.pin.safeArea)
    }
    
    // MARK: - NavigationItem
    public func setupNavigationItemTitle() {
        navigationItem.title = Constants.title
    }
    
    public func getAppleDeveloperDocumentation() -> String {
        Constants.NaviRightBarButtonItem.documentURLString
    }
    
}

// MARK: - NaviBar
private extension DKTableViewController {
    
    func setupNaviBar() {
        setupNavigationItemTitle()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = nil
        navigationController?.navigationBar.tintColor = .label
        naviRightBarButtonItem()
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
private extension DKTableViewController {
    
    enum Constants {
        static var title: String { "UIKit" }
        
        enum NaviRightBarButtonItem {
            static var documentURLString: String { "https://developer.apple.com/documentation/uikit" }
            static var buttonImage: UIImage? { .init(systemName: "safari") }
        }
    }
    
}
