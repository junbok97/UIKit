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
    
    private let disposeBag = DisposeBag()
    
    // ViewModel -> View
    let symbolSystemNameListDriver: Driver<[String]>
    
    // View -> ViewModel
    let serachSFSymbolSystemName = PublishRelay<String>()
    
//    let sfSymbolsSystemNameStream = PublishRelay<String>()
    let popSFSymbolsViewController = PublishSubject<Void>()
    
    let model = SFSymbolsModel()
    
    init() {
        symbolSystemNameListDriver = model.symbolSystemNameListStream
            .asDriver(onErrorDriveWith: .empty())
        
        serachSFSymbolSystemName
            .bind(onNext: model.searchSFSymbolsSystemName)
            .disposed(by: disposeBag)
    }
    
    func getSFSymbolsSystemName(_ indexPath: IndexPath) -> String {
        model.getSFSymbolsSystemName(indexPath.row)
    }
    
    deinit {
        print("SFSymbolsViewModel Deinit")
    }
    
}
