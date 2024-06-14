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

import DesignKit

public final class UILabelSettingListViewReactor: Reactor {
    
    // MARK: - Init
    public init() {}
    
    // MARK: - Properties
    public let initialState = State()
    
    // MARK: - Action
    public enum Action {
        case textChanged(String)
        case textAlignmentChanged(DKTextAlignmentType)
        case colorChanged(DKColor)
        case fontTypeChanged(DKFontType)
        case fontSizeChanged(Float)
        case numberOfLinesChanged(Double)
    }
    
    // MARK: - Mutation
    public enum Mutation {
        case setText(String)
        case setTextColor(UIColor)
        case setBackgroundColor(UIColor)
        case setFontType(DKFontType)
        case setFontSize(CGFloat)
        case setTextAlignment(DKTextAlignmentType)
        case setNumberOfLines(Int)
    }
    
    // MARK: - State
    public struct State {
        
        var code: String {
        """
        private let label: UILabel = {
            let label = UILabel()
            
            label.text = \"\(text)\"
        
            label.textAlignment = \(textAlignment.code)
            label.textColor = \(textColor.cgColor.getRGBCode)
            label.backgroundColor = \(backgroudColor.cgColor.getRGBCode)
            label.font = \(fontType.code(ofSize: fontSize))
            label.numberOfLines = \(numberOfLines)
            return label
        }()
        """
        }

        var text: String = TargetLabel.text
        var textColor: UIColor = TargetLabel.textColor
        var backgroudColor: UIColor = TargetLabel.backgroundColor
        var fontType: DKFontType = TargetLabel.fontType
        var fontSize: CGFloat = TargetLabel.fontSize
        var textAlignment: DKTextAlignmentType = TargetLabel.textAlignment
        var numberOfLines: Int = TargetLabel.numberOfLines
    }
    
    // MARK: - Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case var .textChanged(text):
            text =  text.isEmpty ? TargetLabel.text : text
            return Observable.just(Mutation.setText(text))
            
        case let .textAlignmentChanged(alignment):
            return Observable.just(Mutation.setTextAlignment(alignment))
            
        case let .colorChanged(color):
            switch color.colorType {
                
            case .text:
                return Observable.just(Mutation.setTextColor(color.color))
                
            case .background:
                return Observable.just(Mutation.setBackgroundColor(color.color))
                
            default:
                return Observable.empty()
            }
            
        case let .fontTypeChanged(fontType):
            return Observable.just(Mutation.setFontType(fontType))
            
        case let .fontSizeChanged(fontSize):
            return Observable.just(Mutation.setFontSize(CGFloat(fontSize)))
            
        case let .numberOfLinesChanged(numberOfLines):
            return Observable.just(Mutation.setNumberOfLines(Int(numberOfLines)))
        }
        
    }
    
    // MARK: - Reduce
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setText(text): newState.text = text
        case let .setTextColor(textColor): newState.textColor = textColor
        case let .setBackgroundColor(backgroundColor): newState.backgroudColor = backgroundColor
        case let .setFontType(fontType): newState.fontType = fontType
        case let .setFontSize(fontSize): newState.fontSize = CGFloat(fontSize)
        case let .setTextAlignment(textAlignment): newState.textAlignment = textAlignment
        case let .setNumberOfLines(numberOfLines): newState.numberOfLines = numberOfLines
        }
        
        return newState
    }

}
