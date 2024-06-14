//
//  UILabelSettingListViewController.swift
//  UILabel
//
//  Created by 이준복 on 5/28/24.
//

import UIKit

import CoreKit
import DesignKit

import Then
import ReactorKit
import RxSwift
import RxCocoa
import PinLayout

public final class UILabelSettingListViewController: DKListViewController,
                                                     DKInputTableViewCellListener,
                                                     DKColorTableViewCellListener,
                                                     DKSliderTableViewCellListener,
                                                     DKStepperTableViewCellListener {
    
    public typealias Reactor = UILabelSettingListViewReactor
    
    public init(reactor: Reactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private let reactor: Reactor
    private var disposeBag = DisposeBag()
    
    private let fontTypeSubject: PublishSubject<DKFontType> = .init()
    private let textAlignmentSubject: PublishSubject<DKTextAlignmentType> = .init()
    
    private let codeSubejct: BehaviorRelay<String> = .init(value: "")
    
    // DKInputTableViewCellListener
    private let inputTextSubject: PublishSubject<String> = .init()
    public var inputTextChanged: AnyObserver<String> { inputTextSubject.asObserver() }
    
    // DKColorTableViewCellListener
    private let colorSubject: PublishSubject<DKColor> = .init()
    public var colorSelectedObserver: AnyObserver<DKColor> { colorSubject.asObserver() }
    
    // DKSliderTableViewCellListener
    private let sliderValueSubject: PublishSubject<Float> = .init()
    public var sliderValueChangedObserver: AnyObserver<Float> { sliderValueSubject.asObserver() }
    
    // DKStepperTableViewCellListener
    private let stepperValueSubject: PublishSubject<Double> = .init()
    public var stepperValueChanged: AnyObserver<Double> { stepperValueSubject.asObserver() }
    
    // MARK: - UI
    private let targetLabel = UILabel().then { label in
        label.text = TargetLabel.text
        label.textColor = TargetLabel.textColor
        label.backgroundColor = TargetLabel.backgroundColor
        label.font = .systemFont(ofSize: TargetLabel.fontSize, weight: TargetLabel.fontType.weight)
        label.textAlignment = TargetLabel.textAlignment.aligment
        label.numberOfLines = TargetLabel.numberOfLines
    }
    
    // MARK: - View Methods
    public override func setupAttribute() {
        super.setupAttribute()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DKLabelTableViewCell.self)
        tableView.register(DKInputTableViewCell.self)
        tableView.register(DKColorTableViewCell.self)
        tableView.register(DKSliderTableViewCell.self)
        tableView.register(DKStepperTableViewCell.self)
        tableView.register(DKTitleTableSectionHeaderView.self)
    }
    
    public override func setupLayout() {
        super.setupLayout()
        
        containerView.addSubview(targetLabel)
    }
    
    
    // MARK: - View Life Cycles
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        targetLabel.pin.all()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - NavigationItem
    public override func setupNavigationItemTitle() {
        navigationItem.title = Constants.title
    }
    
    public override func getAppleDeveloperDocumentation() -> String {
        Constants.NaviRightBarButtonItem.documentURLString
    }
    
    // MARK: - Bind
    public func bind(_ reactor: Reactor) {
        bindAction(reactor)
        bindState(reactor)

        codeButton.rx.tap
            .bind(with: self) { object, _ in
                let codeVC = DKCodeViewController()
                let naviVC = UINavigationController(rootViewController: codeVC)
                codeVC.setupCode(object.codeSubejct.value)
                object.present(naviVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}

// MARK: - BindAction
private extension UILabelSettingListViewController {
    
    func bindAction(_ reactor: Reactor) {
        inputTextSubject
            .distinctUntilChanged()
            .map { Reactor.Action.textChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textAlignmentSubject
            .distinctUntilChanged()
            .map { Reactor.Action.textAlignmentChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
        colorSubject
            .distinctUntilChanged()
            .map { Reactor.Action.colorChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        fontTypeSubject
            .distinctUntilChanged()
            .map { Reactor.Action.fontTypeChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        sliderValueSubject
            .distinctUntilChanged()
            .map { Reactor.Action.fontSizeChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        stepperValueSubject
            .distinctUntilChanged()
            .map { Reactor.Action.numberOfLinesChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - BindState
private extension UILabelSettingListViewController {
    
    func bindState(_ reactor: Reactor) {
        reactor.state
            .map { $0.code }
            .distinctUntilChanged()
            .bind(to: codeSubejct)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.text }
            .bind(to: targetLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.textColor }
            .bind(to: targetLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.backgroudColor }
            .bind(to: targetLabel.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { .systemFont(ofSize: $0.fontSize, weight: $0.fontType.weight) }
            .bind(to: targetLabel.rx.font )
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.textAlignment.aligment }
            .bind(to: targetLabel.rx.textAlignment)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.numberOfLines }
            .bind(to: targetLabel.rx.numberOfLines)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UITableViewDataSource
extension UILabelSettingListViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        Constants.TableView.items.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.TableView.items[safe: section]?.items.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Constants.TableView.items[safe: indexPath.section]?.sectionHeader else { return .init() }
        
        switch section {
        case .fontWeight, .alignment :
            let cell = tableView.dequeue(DKLabelTableViewCell.self, for: indexPath)
            
            if case let .fontWeight(fontType) = Constants.TableView.items[safe: indexPath.section]?.items[safe: indexPath.row] {
                cell.setup(
                    text: fontType.title,
                    weight: fontType.weight
                )
            }
            
            if case let .alignment(type: alignmentType) = Constants.TableView.items[safe: indexPath.section]?.items[safe: indexPath.row]  {
                cell.setup(
                    text: alignmentType.title,
                    textAlignment: alignmentType.aligment
                )
            }
            
            return cell
            
        case .input:
            let cell = tableView.dequeue(DKInputTableViewCell.self, for: indexPath)
            cell.setupPlaceholder(TargetLabel.text)
            cell.bind(self)
            return cell
            
        case .color:
            let cell = tableView.dequeue(DKColorTableViewCell.self, for: indexPath)
            cell.bind(self)
            
            if case let .color(type) = Constants.TableView.items[safe: indexPath.section]?.items[safe: indexPath.row]  {
                cell.setupColorType(type)
            }
            
            return cell
            
        case .fontSize:
            let cell = tableView.dequeue(DKSliderTableViewCell.self, for: indexPath)
            cell.bind(self)
            cell.setupSliderValue(Float(reactor.currentState.fontSize))
            return cell
            
        case .numberOfLines:
            let cell = tableView.dequeue(DKStepperTableViewCell.self, for: indexPath)
            cell.bind(self)
            cell.setupStepperValue(Double(reactor.currentState.numberOfLines))
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate
extension UILabelSettingListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        DKTitleTableSectionHeaderView.height
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = Constants.TableView.items[safe: section]?.sectionHeader.title else { return nil }
        let headerView = tableView.dequeue(DKTitleTableSectionHeaderView.self)
        headerView.setupTitle(title)
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case let .fontWeight(fontType) = Constants.TableView.items[safe: indexPath.section]?.items[safe: indexPath.row] {
            fontTypeSubject.onNext(fontType)
        } else if case let .alignment(type: alignmentType) = Constants.TableView.items[safe: indexPath.section]?.items[safe: indexPath.row]  {
            textAlignmentSubject.onNext(alignmentType)
        }
    }
        
}

// MARK: - Constants
private extension UILabelSettingListViewController {
    
    enum Constants {
        static var title: String { "UILabel" }
        static var margin: CGFloat { 20 }
        
        enum NaviRightBarButtonItem {
            static var documentURLString: String { "https://developer.apple.com/documentation/uikit/uilabel" }
        }
        
        enum TableView {
            static var items: [UILabelSettingListSectionModel] {[
                UILabelSettingListSectionModel(
                    sectionHeader: .input,
                    items: [
                        .input
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .fontWeight,
                    items: [
                        .fontWeight(type: .ultraLight),
                        .fontWeight(type: .thin),
                        .fontWeight(type: .light),
                        .fontWeight(type: .regular),
                        .fontWeight(type: .medium),
                        .fontWeight(type: .semibold),
                        .fontWeight(type: .bold),
                        .fontWeight(type: .heavy),
                        .fontWeight(type: .black)
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .fontSize,
                    items: [
                        .fontSize
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .alignment,
                    items: [
                        .alignment(type: .natural),
                        .alignment(type: .left),
                        .alignment(type: .center),
                        .alignment(type: .right),
                        .alignment(type: .justified)
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .color,
                    items: [
                        .color(type: .text),
                        .color(type: .background)
                    ]
                ),
                UILabelSettingListSectionModel(
                    sectionHeader: .numberOfLines,
                    items: [
                        .numberOfLines
                    ]
                )
            ]}
        }
        
    }
    
}

