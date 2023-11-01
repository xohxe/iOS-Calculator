# 📱SwiftUI로 만들어보는 iOS 계산기 클론코딩


현재, 기본적인 연산 기능만 구현하였습니다. (2023.10.28 기준)


## 1. 현재 구현된 내역

### 1-1. 기본 UI 구성

iOS 유사하게 UI제작

### 1-2. 기본 연산 기능

![](/image/calc-basic.gif)
![](/image/calc-percent.gif)
```
2 * 2 = 4
4 + 2 = 6 
``` 

### 1-3. Int,Float 구분하여 출력
![](/image/calc-double.gif)


### 1-4. 화면 크기에 따라 버튼 달라지게 구성

아이패드 기기에서는 최대값을 지정하여, 아예 버튼크기가 커지지 않게 조정.

![아이패드](/iOS-calculator/Preview Content/Preview Assets.xcassets/ipad-calc.imageset/ipad-calc.imageset)

### 1-5. 숫자길이가 길어질 때,글자가 작아지게 표현
 
`minimumScaleFactor()` 함수를 이용하여 글자 크기를 frame에 맞춰 지게 조절 

#### 1-6. 숫자 길이 제한 9자 설정

- 소수점 8자리까지 표시, 그 밑은 반올림
 




## 구현이 필요한 부분

- [ ] 연산버튼 클릭 시, 버튼 Active
- [ ] 세자리 수마다 `,` 삽입하기 
- [ ] 가로모드(공학용 계산기) : 최대 숫자 길이 16자 
- [ ] 백스페이스 시, 숫자 삭제가능
- [ ] AC/C 구분 
- [ ] 연산자 우선순위

