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
    
    let disposeBag = DisposeBag()
}
