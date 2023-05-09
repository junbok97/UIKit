//
//  SFSymbolsCollectionViewCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

final class SFSymbolsCollectionViewCell: UICollectionViewCell, UICollectionViewCellRegister {
    static var cellId: String = SFSymbolsCollectionViewCellConstants.cellId
    static var isFromNib: Bool = false
    
    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = SFSymbolsCollectionViewCellConstants.imageViewConrerRadius
        return imageView
    }()
    
    private lazy var symbolNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = SFSymbolsCollectionViewCellConstants.symbolNameLabelNumberOfLines
        label.textColor = .label
        label.font = SFSymbolsCollectionViewCellConstants.defaultFont
        label.textAlignment = .center
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [symbolImageView, symbolNameLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = SFSymbolsCollectionViewCellConstants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ systemName: String) {
        DispatchQueue.main.async { [weak self] in
            self?.symbolNameLabel.text = systemName
            self?.symbolImageView.image = UIImage(systemName: systemName)
        }
    }
    
}

private extension SFSymbolsCollectionViewCell {
    func attribute() {
        backgroundColor = .systemBackground
    }
    
    func layout() {
        contentView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            symbolImageView.widthAnchor.constraint(equalTo: symbolImageView.heightAnchor),
            
            containerStackView.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                constant: SFSymbolsCollectionViewCellConstants.defaultOffset
            ),
            containerStackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: SFSymbolsCollectionViewCellConstants.defaultOffset
            ),
            containerStackView.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -SFSymbolsCollectionViewCellConstants.defaultOffset
            ),
            containerStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -SFSymbolsCollectionViewCellConstants.defaultOffset
            )
        ])
    }
}
