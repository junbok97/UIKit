//
//  SFSymbolsModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import Foundation
import RxSwift
import RxRelay

protocol SFSymbolsModelProtocol: ModelProtocol {
    static func searchSFSymbolsSystemName(_ text: String) -> [String]
    static func getSFSymbolsSystemName(_ index: Int) -> String
}

final class SFSymbolsModel {

    static func searchSFSymbolsSystemName(_ text: String) -> [String] {
        if text == "" {
            return SFSymbolsSystemName.sfSymbolsSystemNameList
        } else {
            return SFSymbolsSystemName.sfSymbolsSystemNameList.filter { $0.range(of: text, options: .caseInsensitive) != nil }
        }
    }
    
    static func getSFSymbolsSystemName(_ index: Int) -> String {
        SFSymbolsSystemName.sfSymbolsSystemNameList.count <= index ? "" : SFSymbolsSystemName.sfSymbolsSystemNameList[index]
    }
    
}
