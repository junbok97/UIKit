//
//  DKCodeViewController.swift
//  DesignKit
//
//  Created by 이준복 on 6/13/24.
//

import UIKit

public final class DKCodeViewController: DKBaseViewController {
    
    // MARK: - UI
    private let scrollView = UIScrollView().then { scrollView in
        scrollView.alwaysBounceVertical = true
    }
    private let contentView = UIView().then { view in
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.ContentView.cornerRadius
    }
    
    private let codeLabel = UILabel().then { label in
        label.text = Constants.CodeLabel.defaultText
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.numberOfLines = Constants.CodeLabel.numberOfLines
    }
    
    // MARK: - View Methods
    public override func setupAttribute() {
        super.setupAttribute()
        
        setupNaviBar()
        modalPresentationStyle = .popover
        view.backgroundColor = .secondarySystemBackground
        scrollView.backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .systemBackground
    }
    
    public override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.flex.define { flex in
            flex.addItem(codeLabel).margin(Constants.margin).grow(1)
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin.all(view.pin.safeArea)
        contentView.pin
            .margin(Constants.margin)
            .top()
            .horizontally()
        
        contentView.flex.layout(mode: .adjustHeight)
        
        // 3) Adjust the scrollview contentSize
        scrollView.contentSize = contentView.frame.size
    }
    
    public func setupCode(_ code: String) {
        DispatchQueue.main.async { [weak self] in
            self?.codeLabel.text = code
        }
    }
    
}

// MARK: - NaviBar
private extension DKCodeViewController {
    
    func setupNaviBar() {
        naviBarButtonItem()
        
        navigationItem.title = Constants.title
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    func naviBarButtonItem() {
        navigationItem.leftBarButtonItem = .init(
            title: Constants.NaviRightBarButtonItem.leftTitle,
            style: .plain,
            target: self,
            action: #selector(naviLeftBarButtonItemDidTapped)
        )
        
        navigationItem.rightBarButtonItem = .init(
            title: Constants.NaviRightBarButtonItem.rightTitle,
            style: .plain,
            target: self,
            action: #selector(naviRightBarButtonItemDidTapped)
        )
    }
    
    @objc
    func naviLeftBarButtonItemDidTapped() {
        let alertController = UIAlertController(
            title: Constants.AlertController.title,
            message: Constants.AlertController.message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: Constants.AlertAction.title,
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            UIPasteboard.general.string = self.codeLabel.text
            self.dismiss(animated: true)
        }
        
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    @objc
    func naviRightBarButtonItemDidTapped() {
        dismiss(animated: true)
    }

}

// MARK: - Constants
private extension DKCodeViewController {
    
    enum Constants {
        static var title: String { "Code" }
        static var margin: CGFloat { 20 }
        
        enum AlertController {
            static var title: String { "알림" }
            static var message: String { "클립보드에 코드가 복사되었습니다." }
        }
        
        enum AlertAction {
            static var title: String { "완료" }
        }
        
        enum ContentView {
            static var cornerRadius: CGFloat { 8 }
        }
        
        enum CodeLabel {
            static var numberOfLines: Int { 0 }
            static var defaultText: String { """
                private let codeView = UITextView().then { textView in
                    textView.isEditable = false
                    textView.font = DKDefaultConstants.font
                }
            """}
        }
        
        enum NaviRightBarButtonItem {
            static var leftTitle: String { "Copy" }
            static var rightTitle: String { "Done" }
        }
    }
    
}
