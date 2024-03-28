//
//  DatePickerViewContorller.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/10.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxDataSources

final class DatePickerViewContorller {
    let datePicker = UIDatePicker().then {
        $0.rx.preferredDatePickerStyle
    }
}
 
