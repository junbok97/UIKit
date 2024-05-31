//
//  UILabelSettingListViewReactor.swift
//  UILabel
//
//  Created by 이준복 on 5/29/24.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

public final class UILabelSettingListViewReactor: Reactor {
    
    // MARK: - Property
    public let initialState = State()
    
    // MARK: - Action
    public enum Action {
        
    }
    
    // MARK: - Mutation
    public enum Mutation {
        
    }
    
    // MARK: - State
    public struct State {
        var text = TargetLabel.text
        var textColor = TargetLabel.textColor
        var backgroudColor = TargetLabel.backgroundColor
        var fontWeight = TargetLabel.fontWeight
        var fontSize = TargetLabel.fontSize
        var textAlignment = TargetLabel.textAlignment
        var numberOfLines = TargetLabel.numberOfLines
    }
    
    
}
