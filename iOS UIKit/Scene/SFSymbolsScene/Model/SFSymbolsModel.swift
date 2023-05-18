//
//  SFSymbolsModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import Foundation
import RxSwift
import RxRelay

final class SFSymbolsModel {
    
    let symbolSystemNameListStream = BehaviorRelay<[String]>(value: SFSymbolsSystemName.sfSymbolsSystemNameList)

    func searchSFSymbolsSystemName(_ text: String) {
        if text == "" {
            symbolSystemNameListStream.accept(SFSymbolsSystemName.sfSymbolsSystemNameList)
        } else {
            symbolSystemNameListStream.accept(SFSymbolsSystemName.sfSymbolsSystemNameList.filter { $0.range(of: text, options: .caseInsensitive) != nil })
        }
    }
    
    func getSFSymbolsSystemName(_ index: Int) -> String {
        return SFSymbolsSystemName.sfSymbolsSystemNameList.count <= index ? "" : SFSymbolsSystemName.sfSymbolsSystemNameList[index]
    }
    
    deinit {
        print("SFSymbolsModel deinit")
    }
    
}
