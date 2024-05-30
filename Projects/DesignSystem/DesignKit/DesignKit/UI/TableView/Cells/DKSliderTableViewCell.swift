//
//  DKSliderTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 5/30/24.
//

import UIKit

import PinLayout
import FlexLayout
import RxSwift
import RxCocoa


public protocol DKSliderTableViewCellListener: AnyObject {
    var sliderValueChangedObserver: AnyObserver<Float> { get }
}

public final class DKSliderTableViewCell: DKBaseTableViewCell {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let minimumValueLabel: UILabel = .init()
    private let maximumValueLabel: UILabel = .init()
    private let sliderValueLabel: UILabel = .init()
    private let slider: UISlider = .init()
    
    // MARK: - View Life Cycles
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
    
    // MARK: - ViewMethods
    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func setupAttribute() {
        slider.minimumValue = Constants.Slider.minimumValue
        slider.maximumValue = Constants.Slider.maximimValue
        
        super.setupAttribute()
        
        minimumValueLabel.text = Constants.MinimumValueLabel.text
        minimumValueLabel.textAlignment = .center
        sliderValueLabel.text = Constants.SliderValueLabel.text
        sliderValueLabel.textAlignment = .center
        maximumValueLabel.text = Constants.MaximumValueLabel.text
        maximumValueLabel.textAlignment = .center
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.flex.padding(DKDefaultConstants.padding).define { flex in
            
            flex.addItem().direction(.column).define { flex in
                
                flex.addItem(sliderValueLabel)
                flex.addItem().direction(.row).marginTop(DKDefaultConstants.padding).define { flex in
                    flex.addItem(minimumValueLabel).width(Constants.MinimumValueLabel.width)
                    flex.addItem(slider).shrink(1)
                    flex.addItem(maximumValueLabel).width(Constants.MaximumValueLabel.width)
                }
            }
        }
    }
    
    override func reset() {
        super.reset()
        
        disposeBag = DisposeBag()
        
        minimumValueLabel.text = Constants.MinimumValueLabel.text
        sliderValueLabel.text = Constants.SliderValueLabel.text
        maximumValueLabel.text = Constants.MaximumValueLabel.text
        
        slider.setValue(Constants.Slider.defaultValue, animated: true)
        slider.rx.value
            .withUnretained(self)
            .bind { object, sliderValue in
                object.sliderValueLabel.text = "\(Int(sliderValue))"
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Bind
    public func bind(_ listener: DKSliderTableViewCellListener) {
        slider.rx.value
            .bind(to: listener.sliderValueChangedObserver)
            .disposed(by: disposeBag)
    }
    
}


// MARK: - Constants
private extension DKSliderTableViewCell {
    
    enum Constants {
        enum MinimumValueLabel {
            static var text: String { "\(Int(Slider.minimumValue))" }
            static var width: CGFloat { 40 }
        }
        
        enum SliderValueLabel {
            static var text: String { "\(Int(Slider.defaultValue))" }
        }
        
        
        enum MaximumValueLabel {
            static var text: String { "\(Int(Slider.maximimValue))" }
            static var width: CGFloat { 40 }
        }
        
        enum Slider {
            static var minimumValue: Float { 1.0 }
            static var defaultValue: Float { maximimValue / 2 }
            static var maximimValue: Float { 100.0 }
        }
    }
    
}
