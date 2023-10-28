//
//  func.swift
//  iOS-calculator
//
//  Created by 김소혜 on 10/28/23.
//

import Foundation
import SwiftUI


// 버튼 크기 반응형
func responsiveBtnWidth(button: ButtonType) -> CGFloat {
    switch button{
    case .zero:
        return ((UIScreen.main.bounds.width - 5 * 10) / 4) * 2
    default:
        return ((UIScreen.main.bounds.width - 5 * 10) / 4)
    }
}
func responsiveBtnHeight(button: ButtonType) -> CGFloat {
    return ((UIScreen.main.bounds.width - 5 * 10) / 4)
}



// Int, Double 체크 후, Int인 경우 소수점 버려주기
func intOrDouble(_ input: String) -> String {
    let floatNumber = Float(input) ?? 0
    let floored = floor(floatNumber)
    if floatNumber - floored == 0{
        // Int
        let convertInt = Int(floored)
        return "\(convertInt)"
    }else{
        // Float
        return input
    }
}

