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
    private lazy var colorCellRelays: [PublishRelay<UIColor>] = [textColorCellRelay, backgroundColorCellRelay]
    private let textColorCellRelay = PublishRelay<UIColor>()
    private let backgroundColorCellRelay = PublishRelay<UIColor>()
    
    // FontCell
    let fontCellRelay = PublishRelay<Int>()
    
    // AlignmentCell
    let alignmentCellRelay = PublishRelay<Int>()
    
    // FontSizeCell
    let fontSizeCellRelay = PublishRelay<Int>()
    let fontSizeCellDriver: Driver<Int>
    
    // NumberOfLinesCell
    let linesCellRelay = PublishRelay<Int>()
    let linesCellDriveer: Driver<Int>
    
    // CodeTextViewCell
    let codeViewCellDriver: Driver<String>
    
    // ViewModel -> View
    let targetText: Driver<String>
    let targetFont: Driver<UIFont>
    let targetTextColor: Driver<UIColor>
    let targetBackgroundColor: Driver<UIColor>
    let targetAlignment: Driver<NSTextAlignment>
    let targetNumberOfLines: Driver<Int>
    
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
        
        targetBackgroundColor = backgroundColorCellRelay
            .asDriver(onErrorDriveWith: .empty())
        
        targetAlignment = alignmentCellRelay
            .map {
                AlignmentCase(rawValue: $0)?.aligment ?? .center
            }
            .asDriver(onErrorDriveWith: .empty())
        
        targetNumberOfLines = linesCellRelay
            .asDriver(onErrorDriveWith: .empty())
        
        fontSizeCellDriver = fontSizeCellRelay
            .asDriver(onErrorDriveWith: .empty())
        
        linesCellDriveer = linesCellRelay
            .asDriver(onErrorDriveWith: .empty())
        
        codeViewCellDriver = Observable
            .combineLatest(textCellRelay, textColorCellRelay, backgroundColorCellRelay, fontCellRelay, fontSizeCellRelay, alignmentCellRelay, linesCellRelay) { text, textColor, backgroudColor, font, fontSize, alignment, lines in
                """
                private lazy var label: UILabel = {
                    let label = UILabel()
                    label.text = \(text)
                    label.textColor = \(textColor)
                    label.backgroundColor = \(backgroudColor)
                    label.textAlignment = \(AlignmentCase(rawValue: alignment)!.code)
                    label.font = \(UISystemFontWeightCase(rawValue: font)!.code(ofSize: CGFloat(fontSize)))
                    label.numberOfLines = \(lines)
                    return label
                }()
                """
            }
            .asDriver(onErrorDriveWith: .empty())
            
    }
    func getColorRelay(_ row: Int) -> PublishRelay<UIColor> {
        return colorCellRelays[row]
    }
}
