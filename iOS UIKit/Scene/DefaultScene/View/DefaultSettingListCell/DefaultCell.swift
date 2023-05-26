//
//  DefaultCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift

class DefaultCell: UITableViewCell, UITableViewCellReigster {
    class var cellId: String {
        DefaultCellConstants.cellId
    }
    static var isFromNib: Bool = false
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {}
}
