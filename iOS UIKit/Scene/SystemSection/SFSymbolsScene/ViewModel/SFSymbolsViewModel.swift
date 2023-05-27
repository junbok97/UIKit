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
    
    let symbolSystemNameListStream = BehaviorRelay<[String]>(value: SFSymbolsSystemName.sfSymbolsSystemNameList)
    
//    let sfSymbolsSystemNameStream = PublishRelay<String>()
    let popSFSymbolsViewController = PublishSubject<Void>()
    
    let model = SFSymbolsModel()
    
    init() {
        symbolSystemNameListDriver = symbolSystemNameListStream
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func serachSFSymbolSystemName(_ text: String) {
        symbolSystemNameListStream.accept(SFSymbolsModel.searchSFSymbolsSystemName(text))
    }
    
    func getSFSymbolsSystemName(_ indexPath: IndexPath) -> String {
        SFSymbolsModel.getSFSymbolsSystemName(indexPath.row)
    }
    
    deinit {
        print("SFSymbolsViewModel Deinit")
    }
    
}
