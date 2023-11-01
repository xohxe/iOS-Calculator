//
//  func.swift
//  iOS-calculator
//
//  Created by 김소혜 on 10/28/23.
//

import Foundation
import SwiftUI
import UIKit

extension UIDevice{
    public var isiPhone: Bool{
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone{
            return true
        }
        return false
    }
    public var isiPad: Bool{
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad{
            return true
        }
        return false
    }
}


let screenWidth = UIScreen.main.bounds.size.width
 
// 버튼 크기 반응형
func responsiveBtnWidth(button: ButtonType) -> CGFloat {
    switch button{
    case .zero:
        if UIDevice.current.isiPhone{
            return ((screenWidth - 5 * 10) / 4) * 2
        }else if UIDevice.current.isiPad{
            return ((400 - 5 * 10 * 0.7) / 4) * 2
        }else{
            return ((400 - 5 * 10 * 0.7) / 4) * 2
        }
        
    default:
        if UIDevice.current.isiPhone{
            return ((screenWidth - 5 * 10) / 4)
        }else if UIDevice.current.isiPad{
            return ((400 - 5 * 10 * 0.7) / 4)
        }else{
            return ((400 - 5 * 10 * 0.7) / 4)
        }
    }
}
 

func responsiveBtnHeight(button: ButtonType) -> CGFloat {
    if UIDevice.current.isiPhone{
        return ((screenWidth - 5 * 10) / 4)
    }else if UIDevice.current.isiPad{
        return ((400 - 5 * 10 * 0.7) / 4)
    }else{
        return ((400 - 5 * 10 * 0.7) / 4)
    }
 
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



func intOrDouble2(_ input: Double) -> String {
    
  //  let floatNumber = Float(input) ?? 0
    let floored = floor(input)
    if input - floored == 0{
        // Int
        let convertInt = Int(floored)
        return "\(convertInt)"
    }else{
        // Double
        return "\(input)"
    }
}




func tailRound( _ input: Double) -> Double{
    let digit: Double = pow(10,8)
    return round(input * digit) / digit
}


   


extension Int{
    func formatterStyle(_ numberStyle: NumberFormatter.Style) -> String?{
        let numberFormatter : NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = numberStyle
        return numberFormatter.string(for: self)
        
    }
}

extension Double {
    func formatterStyle(_ numberStyle: NumberFormatter.Style) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = numberStyle
        return numberFormatter.string(for: self) ?? ""
    }
}
