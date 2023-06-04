//
//  StackViewDistributionType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit

enum StackViewDistributionType: String {
    case fill = "Fill"
    case fillEqually = "Fill Equally"
    case fillProportionally = "Fill Proportionally"
    case equalSpacing = "Equal Spacing"
    case equalCentering = "Equal Centering"
    
    var distribution: UIStackView.Distribution {
        switch self {
        case .fill:
            return .fill
        case .fillEqually:
            return .fillEqually
        case .fillProportionally:
            return .fillProportionally
        case .equalSpacing:
            return .equalSpacing
        case .equalCentering:
            return .equalCentering
        }
    }
    
}
