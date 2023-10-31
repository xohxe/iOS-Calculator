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
    case clear = "C"
    case allClear = "AC"
    
    // 배경색
    var backgroundColor : Color {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot:
            return Color("NumberButton")
        case .plus,.minus,.multiple, .divide,.equal:
           return Color.orange
        case .clear, .opposite, .percent, .allClear:
            return Color.gray
        }
    }
  
    // 글자색
    var forgroundColor : Color {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot,.plus,.minus,.multiple, .divide,.equal:
            return Color.white
        case .clear, .opposite, .percent, .allClear:
            return Color.black
        }
    }
    
  
}
// 연산자
enum Operator{
    case plus, minus, multiple, divide, none, dial
}



struct ContentView: View {
     
    @State var displayNumber : String = "0" // 결과값
    @State var tempNumber : Double = 0 // 임시 저장
    //@State var prevNumber : Double = 0
    @State var secondNumber : String = "" // 임시 저장
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
                        Text(displayNumber)
                            .padding()
                            .foregroundColor(.white)
                            .font(.system(size: displayNumber.count > 6 ? 72 : 82))
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                            .onChange(of: displayNumber) { newValue in
                                if newValue.count > 9 {
                                    displayNumber = String(newValue.prefix(9))
                                }
                            }
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
                
                tempNumber = Double(displayNumber) ?? 0
                displayNumber = ""
                secondNumber = ""
            } else if button == .minus {
                buttonState = .minus
                tempNumber = Double(displayNumber) ?? 0
                displayNumber = ""
                secondNumber = ""
            } else if button == .multiple {
                buttonState = .multiple
                tempNumber = Double(displayNumber) ?? 0
                displayNumber = ""
                secondNumber = ""
            } else if button == .divide {
                buttonState = .divide
                tempNumber = Double(displayNumber) ?? 0
                displayNumber = ""
                secondNumber = ""
            } else if button == .equal{
                
                // var tempNumber = tempNumber // 저장된 숫자
                var currentNumber = Double(displayNumber) ?? 0 // 현재 입력된 숫자
                
                switch buttonState {
                case .plus:
                    displayNumber = "\(tailRound(tempNumber + currentNumber))" // 이전 숫자와 현재 숫자 더하기
                    displayNumber = intOrDouble(displayNumber) // 정수인지 소수인지 확인
                    tempNumber = Double(displayNumber) ?? 0 // 숫자 업데이트
                    
                case .minus:
                    displayNumber = "\(tailRound(tempNumber - currentNumber))"
                    displayNumber = intOrDouble(displayNumber)
                    tempNumber = Double(displayNumber) ?? 0
                    
                case .multiple:
                    displayNumber = "\(tailRound(tempNumber * currentNumber))"
                    displayNumber = intOrDouble(displayNumber)
                    tempNumber = Double(displayNumber) ?? 0
                    
                case .divide:
                    displayNumber = "\(tailRound(tempNumber / currentNumber))"
                    displayNumber = intOrDouble(displayNumber)
                    tempNumber = Double(displayNumber) ?? 0
                   // secondNumber = "\(tempNumber)"
                    
                case .dial:
                    break
                case .none:
                    break
                }
                
                //buttonState = .none
            
            }
            
            if button != .equal {
                //displayNumber = "0" // 값 초기화
                displayNumber = intOrDouble2(tempNumber)
                
                isButtonPressed = true  // 버튼 색상 변화
                
            }
            
        case .opposite:
            tempNumber = -(Double(displayNumber) ?? 0)
            displayNumber = "\(tempNumber)"
        case .percent:
            tempNumber = Double(displayNumber) ?? 0 / 100
            displayNumber = "\(tempNumber)"
        case .clear:
            tempNumber = 0
            displayNumber = "0"
            secondNumber = ""
            buttonState = .none
            
        case .dot:
            if displayNumber == "0"{
                displayNumber = "0."
            }else{
                displayNumber += "."
            }
        
        default:
            let result = button.rawValue
            switch buttonState {
                
            
            case .plus, .minus, .multiple, .divide:
                displayNumber = ""
                secondNumber += result
                
//                if secondNumber.count > 1 {
//                    secondNumber = result
//                }
                displayNumber = secondNumber
 
            default:
                if displayNumber == "0"{
                    displayNumber = "\(result)"
                    displayNumber = intOrDouble(displayNumber)
                    
                }else{
                    displayNumber += "\(result)"
                    displayNumber = intOrDouble(displayNumber)
                    
                }
            }
           
        }
        
    }
 
    
    
    
}
 
#Preview {
    ContentView()
}
