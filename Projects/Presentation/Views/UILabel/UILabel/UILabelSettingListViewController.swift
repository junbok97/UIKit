//
//  UILabelSettingListViewController.swift
//  UILabel
//
//  Created by 이준복 on 5/28/24.
//

import UIKit

import DesignKit
import Extensions

import RxSwift
import RxCocoa
import RxDataSources
import PinLayout

public final class UILabelSettingListViewController: DKListViewController {
    
    // MARK: - UI
    private let targetLabel: UILabel = .init()
    
    // MARK: - View Methods
    public override func setupAttribte() {
        super.setupAttribte()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DKLabelTableViewCell.self)
        tableView.register(DKInputTableViewCell.self)
        tableView.register(DKColorTableViewCell.self)
        tableView.register(DKStepperTableViewCell.self)
        tableView.register(DKTitleTableSectionHeaderView.self)
        
        
        targetLabel.font = Constants.TargetLabel.font
        targetLabel.text = Constants.TargetLabel.text
        targetLabel.textColor = .label
        targetLabel.textAlignment = .center
        targetLabel.backgroundColor = .systemBackground
    }
    
    public override func setupLayout() {
        super.setupLayout()
        
        containerView.addSubview(targetLabel)
    }
    
    
    // MARK: - View Life Cycles
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        targetLabel.pin.all()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - NavigationItem
    public override func setupNavigationItemTitle() {
        navigationItem.title = Constants.title
    }
    
    public override func getAppleDeveloperDocumentation() -> String {
        Constants.NaviRightBarButtonItem.documentURLString
    }
    
    // MARK: - Bind
    public func bind(_ reactor: UILabelSettingListViewReactor) {
        
    }
    
    
}

// MARK: - UITableViewDataSource
extension UILabelSettingListViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        Constants.TableView.items.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.TableView.items[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = UILabelSettingListSectionType(rawValue: indexPath.section) else { return .init() }
        
        
        switch section {
        case .code, .font, .alignment :
            let cell = tableView.dequeue(DKLabelTableViewCell.self, for: indexPath)
            
            if case let .font(fontType) = Constants.TableView.items[safe: indexPath.section]?.items[safe: indexPath.row] {
                cell.setup(
                    text: fontType.title,
                    weight: fontType.weight
                )
            }
            
            if case let .alignment(type: alignmentType) = Constants.TableView.items[safe: indexPath.section]?.items[safe: indexPath.row]  {
                cell.setup(
                    text: alignmentType.title,
                    textAlignment: alignmentType.aligment
                )
            }

            return cell
        case .input:
            let cell = tableView.dequeue(DKInputTableViewCell.self, for: indexPath)
            return cell
        case .color:
            let cell = tableView.dequeue(DKColorTableViewCell.self, for: indexPath)
            
            if case let .color(title) = Constants.TableView.items[safe: indexPath.section]?.items[safe: indexPath.row]  {
                cell.setupTitleLabel(title)
            }
            
            return cell
        case .fontSize:
            let cell = tableView.dequeue(DKLabelTableViewCell.self, for: indexPath)
            return cell
        case .numberOfLines:
            let cell = tableView.dequeue(DKStepperTableViewCell.self, for: indexPath)
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate
extension UILabelSettingListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        DKTitleTableSectionHeaderView.height
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = UILabelSettingListSectionType(rawValue: section)?.title else { return nil }
        
        let headerView = tableView.dequeue(DKTitleTableSectionHeaderView.self)
        headerView.setupTitle(title)
        return headerView
    }
    
}

// MARK: - Constants
private extension UILabelSettingListViewController {
    
    enum Constants {
        static var title: String { "UILabel" }
        static var margin: CGFloat { 20 }
        
        enum NaviRightBarButtonItem {
            static var documentURLString: String { "https://developer.apple.com/documentation/uikit/uilabel" }
        }
        
        enum TargetLabel {
            static var text: String { "Label" }
            static var font: UIFont { .systemFont(ofSize: 50) }
        }
        
        enum TableView {
            static var items: [UILabelSettingListSectionModel] {[
                UILabelSettingListSectionModel(
                    sectionHeader: .code,
                    items: [
                        .code
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .input,
                    items: [
                        .input
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .color,
                    items: [
                        .color(title: "TitleColor"),
                        .color(title: "BackgroundColor")
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .font,
                    items: [
                        .font(type: .ultraLight),
                        .font(type: .thin),
                        .font(type: .light),
                        .font(type: .regular),
                        .font(type: .medium),
                        .font(type: .semibold),
                        .font(type: .bold),
                        .font(type: .heavy),
                        .font(type: .black)
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .fontSize,
                    items: [
                        .fontSize
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .alignment,
                    items: [
                        .alignment(type: .natural),
                        .alignment(type: .left),
                        .alignment(type: .center),
                        .alignment(type: .right),
                        .alignment(type: .justified)
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .numberOfLines,
                    items: [
                        .numberOfLines
                    ]
                )
            ]}
        }
        
    }
    
}
