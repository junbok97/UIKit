//
//  SFSymbolsViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import Foundation
import RxSwift
import RxCocoa

protocol SFSymbolsViewModelProtocol: ViewModelProtocol {
    var symbolSystemNameListDriver: Driver<[String]> { get }
    var symbolSystemNameListStream: BehaviorRelay<[String]> { get }
    var popSFSymbolsViewController: PublishSubject<Void> { get }
    
    func serachSFSymbolSystemName(_ text: String)
    func getSFSymbolsSystemName(_ indexPath: IndexPath) -> String
}

final class SFSymbolsViewModel: SFSymbolsViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    // ViewModel -> View
    let symbolSystemNameListDriver: Driver<[String]>
    let symbolSystemNameListStream = BehaviorRelay<[String]>(value: SFSymbolsSystemName.sfSymbolsSystemNameList)
    
    // View -> ViewModel
    let popSFSymbolsViewController = PublishSubject<Void>()
    
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
