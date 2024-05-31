//
//  DKListView.swift
//  DesignKit
//
//  Created by 이준복 on 5/31/24.
//

import UIKit

public final class DKListView: DKBaseView {
    
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
    override func setupAttribute() {
        super.setupAttribute()
        
        backgroundColor = .secondarySystemBackground
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addSubviews(containerView, tableView)
    }
    
    // MARK: - View Life Cycles
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.pin
            .margin(Constants.margin)
            .top()
            .left()
            .right()
            .height(Constants.ContainerView.height)
         
        tableView.pin
            .marginTop(Constants.margin)
            .below(of: containerView)
            .left()
            .right()
            .bottom()
    }
    
}


// MARK: - Constants
private extension DKListView {
    
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
