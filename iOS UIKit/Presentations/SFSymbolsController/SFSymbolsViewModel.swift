//
//  SFSymbolsViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import Foundation
import RxSwift
import RxCocoa

final class SFSymbolsViewModel {
    
    let disposeBag = DisposeBag()
    
    // ViewModel -> View
    let symbolListDriver: Driver<[String]>
    
    // View -> ViewModel
    let serachSFSymbol = PublishRelay<String>()
    let itemSelected = PublishRelay<IndexPath>()
    
    let symbolListStream = ReplayRelay<[String]>.create(bufferSize: 1)
    
    init() {
        let model = SFSymbolsModel()
        
        symbolListDriver = symbolListStream
            .asDriver(onErrorDriveWith: .empty())
        
        Observable.just(model.symbolsNameList)
            .bind(to: symbolListStream)
            .disposed(by: disposeBag)
        
        serachSFSymbol
            .map { model.getName($0) }
            .bind(to: symbolListStream)
            .disposed(by: disposeBag)
    }
    
}
