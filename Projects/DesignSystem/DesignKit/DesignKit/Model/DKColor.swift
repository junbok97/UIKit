//
//  DKColor.swift
//  DesignKit
//
//  Created by 이준복 on 5/30/24.
//

import UIKit

public struct DKColor: Equatable {
    
    public let color: UIColor
    public let colorType: DKColorType
    
    public init(color: UIColor, colorType: DKColorType) {
        self.color = color
        self.colorType = colorType
    }
    
}
