//
//  LabelColorCellViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/12.
//

import Foundation
import RxSwift
import RxCocoa

final class LabelColorCellViewModel {
    // View -> ViewModel
    let selectedColorSubject = PublishRelay<LabelColor>()
    
    // ViewModel -> View
    let colorType: Observable<LabelColorType>
    
    init(colorCaseRawValue: Int) {
        self.colorType = Observable.just(LabelColorType(rawValue: colorCaseRawValue) ?? .backgroundColor)
    }
    
}
