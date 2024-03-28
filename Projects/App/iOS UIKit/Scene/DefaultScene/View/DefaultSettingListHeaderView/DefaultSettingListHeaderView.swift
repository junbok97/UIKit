//
//  DefaultSettingListHeaderView.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import UIKit

final class DefaultSettingListHeaderView: UITableViewHeaderFooterView, UITableViewHeaderFooterViewRegister {
    static var viewId: String = DefaultSettingListHeaderViewConstants.viewId
    static var isFromNib: Bool = false

    private lazy var headerTitleLabel: UILabel = {
       let label = UILabel()
        label.font = DefaultSettingListHeaderViewConstants.defaultFont
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupHeaderTitle(_ text: String) {
        headerTitleLabel.text = text
    }
}

private extension DefaultSettingListHeaderView {
    func attribute() {
        backgroundColor = .secondarySystemBackground
    }

    func layout() {
        addSubview(headerTitleLabel)

        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: DefaultSettingListHeaderViewConstants.defaultHorizionOffset),
            headerTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -DefaultSettingListHeaderViewConstants.defaultHorizionOffset),
            headerTitleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -DefaultSettingListHeaderViewConstants.defaultVerticalOffset)
        ])
    }
}
