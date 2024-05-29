//
//  UILabelSettingListViewReactor.swift
//  UILabel
//
//  Created by 이준복 on 5/29/24.
//

import Foundation


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
        var text: String = "Label"
        var fontSize: CGFloat = 20
    }
    
    
}
