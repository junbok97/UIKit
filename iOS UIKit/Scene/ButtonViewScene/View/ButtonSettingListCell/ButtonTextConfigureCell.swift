//
//  ButtonTitleTypeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import UIKit
import RxSwift

final class ButtonTextConfigureCell: DefaultCell, ButtonSettingListCellProtocol {
    
    static override var cellId: String {
        ButtonTextConfigureCellConstants.cellId
    }
    
    private lazy var titleTypeSegmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: [ButtonTitleType.title.rawValue, ButtonTitleType.subTitle.rawValue])
        segmented.selectedSegmentIndex = ButtonTextConfigureCellConstants.selectedSegmentIndex
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: ButtonSettingListItemType) { }
    
    func bind(_ viewModel: ButtonViewModel) {
//        titleTypeSegmentedControl.rx.selectedSegmentIndex
//            .map {
//                ButtonTextConfigureCellConstants.segmentedControlItems[$0]
//            }
//            .bind(to: viewModel)
//            .disposed(by: disposeBag)
        
    }
    
}

private extension ButtonTextConfigureCell {
    func attribute() {
        selectionStyle = .none
        backgroundColor = .systemBackground
    }
    
    func layout() {
        contentView.addSubview(titleTypeSegmentedControl)
        
        NSLayoutConstraint.activate([
            titleTypeSegmentedControl.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: ButtonViewControllerConstants.defaultOffset),
            titleTypeSegmentedControl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: ButtonViewControllerConstants.defaultOffset),
            titleTypeSegmentedControl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -ButtonViewControllerConstants.defaultOffset),
            titleTypeSegmentedControl.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -ButtonViewControllerConstants.defaultOffset)
        ])
        
    }
    
}
