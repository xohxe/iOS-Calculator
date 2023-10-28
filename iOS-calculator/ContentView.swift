//
//  ContentView.swift
//  iOS-calculator
//
//  Created by 김소혜 on 2023/10/26.
//

import SwiftUI
import UIKit

enum ButtonType : String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case dot = "."
    case equal = "="
    case plus = "+"
    case minus = "-"
    case multiple = "×"
    case divide = "÷"
    case percent = "%"
    case opposite = "⁺⁄₋"
    case clear = "AC"
    
    // 배경색
    var backgroundColor : Color {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot:
            return Color("NumberButton")
        case .plus,.minus,.multiple, .divide,.equal:
           return Color.orange
           
        case .clear, .opposite, .percent:
            return Color.gray
        }
    }
  
    // 글자색
    var forgroundColor : Color {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot,.plus,.minus,.multiple, .divide,.equal:
            return Color.white
        case .clear, .opposite, .percent:
            return Color.black
        }
    }
    
  
}
// 연산자
enum Operator{
    case plus, minus, multiple, divide, none, dial
}

struct ContentView: View {
     
    @State var value : String = "0" // 결과값
    @State var tempNumber : Double = 0 // 임시 저장
    @State var buttonState : Operator = .none // 버튼 상태
    @State public var isButtonPressed = false
    
    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite,.percent,.divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one,.two,.three,.plus],
        [.zero,.dot,.equal]
    ]
    
    
    var body: some View {
     
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        Text(value)
                            .padding()
                            .foregroundColor(.white)
                            .font(.system(size: value.count > 6 ? 60 : 82))
                            .lineLimit(1)
//                            .truncationMode(.tail)
                    }.frame(maxWidth: 400)
                   
                    ForEach(buttonData, id:\.self){ line in
                        HStack{
                            ForEach(line, id:\.self){ item in
                               
                                Button{
                                    self.pressBtn(button: item)
                                } label: {
                                    Text(item.rawValue)
                                        .frame(width: responsiveBtnWidth(button: item), height: responsiveBtnHeight(button: item) )
                                        .background(item.backgroundColor)
                                        .cornerRadius(responsiveBtnHeight(button: item)/2)
                                       .foregroundColor(item.forgroundColor)
                                       .font(.system(size: 36))
                                       .fontWeight(.semibold)
                               }
                            }
                        }
                    }
                    
                }
                .padding()
            
            
        }
    }
    
    
  
    func pressBtn(button: ButtonType){
        switch button{
     
        case .plus, .minus,.multiple,.divide,.equal:
            if button == .plus{
                buttonState = .plus
                tempNumber = Double(value) ?? 0
            } else if button == .minus {
                buttonState = .minus
                tempNumber = Double(value) ?? 0
            } else if button == .multiple {
                buttonState = .multiple
                tempNumber = Double(value) ?? 0
            } else if button == .divide {
                buttonState = .divide
                tempNumber = Double(value) ?? 0
            } else if button == .equal{
                let tempNumber = tempNumber
                let currentNumber = Double(value) ?? 0
                switch buttonState {
                case .plus:
                    value = "\(tempNumber + currentNumber)"
                    value = intOrDouble(value)
                case .minus:
                    value = "\(tempNumber - currentNumber)"
                    value = intOrDouble(value)
                case .multiple:
                    value = "\(tempNumber * currentNumber)"
                    value = intOrDouble(value)
                case .divide:
                    value = "\(tempNumber / currentNumber)"
                    value = intOrDouble(value)
                case .dial:
                    break
                case .none:
                    break
                }
            }
            
            if button != .equal {
                // 값 초기화
               // value = "0"
                value = "\(intOrDouble2(tempNumber))"
                isButtonPressed = true
                // 버튼 색상 변화
                
            }
        case .opposite:
            tempNumber = -(Double(value) ?? 0)
            value = "\(tempNumber)"
        case .percent:
            tempNumber = Double(value) ?? 0 / 100
            value = "\(tempNumber)"
        case .clear:
            value = "0"
        case .dot:
            if value == "0"{
                value = "0."
            }else{
                value = "."
            }
        default:
            let result = button.rawValue
            switch buttonState {
            case .plus, .minus, .multiple, .divide:
                 value = result
            default:
                if value == "0"{
                    value = result
                }else{
                    
                    value += result
                }
            }
           
        }
        
    }
 
    
    
    
}
 
#Preview {
    ContentView()
}
