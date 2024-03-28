//
//  ObjectListCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

final class ObjectListCell: UITableViewCell, UITableViewCellReigster {
    
    static var cellId: String = ObjectListCellConstants.cellId
    static var isFromNib: Bool = false
    
    // MARK: - UI 구현
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = ObjectListCellConstants.imageViewLayerCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = ObjectListCellConstants.titleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(objectType: ObjectType) {
        titleLabel.text = objectType.rawValue
        mainImageView.image = UIImage(named: objectType.rawValue)
    }
    
}

// MARK: - 레이아웃
private extension ObjectListCell {
    func attribute() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    func layout() {
        [mainImageView, titleLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: ObjectListCellConstants.defaultOffset),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: ObjectListCellConstants.defaultOffset),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -ObjectListCellConstants.defaultOffset),
            mainImageView.widthAnchor.constraint(equalToConstant: ObjectListCellConstants.imageViewWidth),
            mainImageView.heightAnchor.constraint(equalToConstant: ObjectListCellConstants.imageViewHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: ObjectListCellConstants.defaultOffset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -ObjectListCellConstants.defaultOffset),
            titleLabel.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor)
        ])
    }
    
}
