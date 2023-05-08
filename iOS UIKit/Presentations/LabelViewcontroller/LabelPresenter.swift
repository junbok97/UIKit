//
//  LabelViewModel.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

protocol LabelViewControllerProtocol {
    func attribute()
    func layout()
    func bind(_ viewModel: LabelViewModel)
}

final class LabelPresenter: NSObject {
    
    private let viewController: LabelViewControllerProtocol
    private let disposeBag = DisposeBag()
    
    let viewModel = LabelViewModel()
    
    init(viewController: LabelViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.attribute()
        viewController.layout()
        viewController.bind(viewModel)
    }

}

extension LabelPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return LabelListSectionCase.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LabelListSectionCase(rawValue: section)?.sectionCounts ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = LabelListSectionCase(rawValue: indexPath.section) else { return UITableViewCell() }
        let row = indexPath.row
        
        switch section {
        case .text:
            let cell = LabelTextCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.bind(viewModel)
            return cell
        case .color:
            let cell = LabelColorCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.setup(title: LabelColorCase(rawValue: row)?.title ?? "")
            cell.bind(viewModel.getColorRelay(row))
            return cell
        case .font:
            let cell = LabelFontCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.setup(UISystemFontWeightCase(rawValue: row) ?? .regular)
            return cell
        case .alignment:
            let cell = LabelAlignmentCell.dequeueReusableCell(target: tableView, indexPath: indexPath)
            cell.setup(AlignmentCase(rawValue: row) ?? .natural)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LabelListSectionCase(rawValue: section)?.sectionTitle
    }
    
}

extension LabelPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = LabelListSectionCase(rawValue: indexPath.section) else { return }
        let row = indexPath.row
        
        switch section {
        case .text:
            return
        case .color:
            return
        case .font:
            Observable.just(row)
                .bind(to: viewModel.fontCellRelay)
                .disposed(by: disposeBag)
        case .alignment:
            Observable.just(row)
                .bind(to: viewModel.alignmentCellRelay)
                .disposed(by: disposeBag)
        }
    }
}
