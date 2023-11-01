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
    var backgroundColor: Color {
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
    @State var selectedOperator: ButtonType? = nil
    
    
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
                            .font(.system(size: 82))
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .onChange(of: displayNumber) { newValue in
                                if newValue.count > 9 {
                                    displayNumber = String(newValue.prefix(9))
                                }
//                                if let numberValue = Double(displayNumber){
//                                    let formattedNumber = numberValue.formatterStyle(.decimal)
//                                    displayNumber = formattedNumber
//                                }
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
                                        .frame(width: responsiveBtnWidth(button: item), height: responsiveBtnHeight(button: item))
                                        .background(item == selectedOperator ? .white : item.backgroundColor)
                                        .cornerRadius(responsiveBtnHeight(button: item)/2)
                                        .foregroundColor(item == selectedOperator ? .orange : item.forgroundColor)
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
                selectedOperator = .plus
                tempNumber = Double(displayNumber) ?? 0
                displayNumber = ""
                secondNumber = ""
            } else if button == .minus {
                buttonState = .minus
                selectedOperator = .minus
                tempNumber = Double(displayNumber) ?? 0
                displayNumber = ""
                secondNumber = ""
            } else if button == .multiple {
                buttonState = .multiple
                selectedOperator = .multiple
                tempNumber = Double(displayNumber) ?? 0
                displayNumber = ""
                secondNumber = ""
            } else if button == .divide {
                buttonState = .divide
                selectedOperator = .divide
                tempNumber = Double(displayNumber) ?? 0
                displayNumber = ""
                secondNumber = ""
            } else if button == .equal{
                // var tempNumber = tempNumber // 저장된 숫자
                selectedOperator = .none
                let currentNumber = Double(displayNumber) ?? 0 // 현재 입력된 숫자
                
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
                case .dial:
                    break
                case .none:
                    break
                }
            }
            
            if button != .equal {
                displayNumber = intOrDouble2(tempNumber)
            }
            
        case .opposite:
            tempNumber = -(Double(displayNumber) ?? 0)
            displayNumber = "\(tempNumber)"
        case .percent:
            tempNumber = (Double(displayNumber) ?? 0) / 100
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
                displayNumber = secondNumber
            default:
                if displayNumber == "0"{
                    displayNumber = "\(result)"
                   // displayNumber = intOrDouble(displayNumber)
                    
                }else{
                    
                    displayNumber += "\(result)"
                    //displayNumber = intOrDouble(displayNumber)
                   // print(displayNumber)
                }
            }
           
        }
        
    }
 
 
    
  

    
    
}
 
#Preview {
    ContentView()
}
