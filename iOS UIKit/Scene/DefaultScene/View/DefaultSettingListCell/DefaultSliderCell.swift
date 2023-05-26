//
//  DefaultSliderCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/25.
//

import Foundation
import Then

class DefaultSliderCell: DefaultCell {
    override class var cellId: String {
        get { DefaultSliderCellConstants.cellId }
    }
    
    lazy var slider: UISlider = UISlider().then {
        $0.minimumValue = DefaultSliderCellConstants.sliderMinimumValue
        $0.maximumValue = DefaultSliderCellConstants.sliderMaximimValue
    }
    
    override func attribute() {
        super.attribute()
        slider.setValue(DefaultSliderCellConstants.sliderValue, animated: true)
    }
    
    override func layout() {
        super.layout()
        contentView.addSubview(slider)
        
        slider.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(DefaultViewControllerConstants.defaultOffset)
        }
    }

}
