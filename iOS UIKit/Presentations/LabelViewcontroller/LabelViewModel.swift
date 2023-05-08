//
//  LabelViewModel.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/13.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelViewModel {
    
    private let disposeBag = DisposeBag()
    
    // 외부로부터 전달받을 값
    // TextCell
    let textCellRelay = PublishRelay<String>()
    
    // ColorCell
    private lazy var colorCellRelays: [PublishRelay<UIColor>] = [textColorCellRelay, backgroundCellRelay]
    private let textColorCellRelay = PublishRelay<UIColor>()
    private let backgroundCellRelay = PublishRelay<UIColor>()
    
    // FontCell
    let fontCellRelay = PublishRelay<Int>()
    
    // AlignmentCell
    let alignmentCellRelay = PublishRelay<Int>()
    
    // FontSizeCell
    let fontSizeCellRelay = PublishRelay<Int>()
    let fontSizeCellDriver: Driver<Int>
    
    // ViewModel -> View
    let targetText: Driver<String>
    let targetFont: Driver<UIFont>
    let targetTextColor: Driver<UIColor>
    let targetBackgroundColor: Driver<UIColor>
    let targetAlignment: Driver<NSTextAlignment>
    
    // View -> ViewModel
    
    init() {
        targetText = textCellRelay
            .asDriver(onErrorDriveWith: .empty())
        
        targetFont = Observable
            .combineLatest(fontCellRelay, fontSizeCellRelay) { (rawValue, ofSize) -> UIFont in
                UISystemFontWeightCase(rawValue: rawValue)?.font(ofSize: CGFloat(ofSize)) ?? LabelViewConstants.defaultFont
            }
            .asDriver(onErrorDriveWith: .empty())
  
        targetTextColor = textColorCellRelay
            .asDriver(onErrorDriveWith: .empty())
        
        targetBackgroundColor = backgroundCellRelay
            .asDriver(onErrorDriveWith: .empty())
        
        targetAlignment = alignmentCellRelay
            .map {
                AlignmentCase(rawValue: $0)?.aligment ?? .center
            }
            .asDriver(onErrorDriveWith: .empty())
        
        fontSizeCellDriver = fontSizeCellRelay
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func getColorRelay(_ row: Int) -> PublishRelay<UIColor> {
        return colorCellRelays[row]
    }
}
