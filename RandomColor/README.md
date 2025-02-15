<h1>랜덤 컬러 생성 앱 프로젝트</h1>

랜덤 컬러 생성 앱은 버튼을 클릭할 때마다 배경색이 랜덤하게 바뀌고, 현재 색상의 RGB 값을 화면에 표시하는 간단한 iOS 앱입니다.

### Objective
1. **랜덤 색상 생성**: 버튼 클릭 시 배경색이 랜덤하게 변경됩니다.
2. **색상 정보 표시**:현재 화면 배경색의 RGB 값을 화면에 표시합니다.
3. **초기화 기능**: 초기화 버튼을 누르면 배경색이 흰색으로 변경되고, RGB 값도 초기화됩니다.

### Key Result
- Change Color 버튼을 누르면 색상이 바뀌고 그에따라 중앙 RGB 텍스트도 변경됨
- Reset 버튼을 누르면 하얀색(R:255, G:255, B:255)으로 초기화

![Simulator Screen Recording - iPhone 16 Pro - 2025-02-10 at 16 32 37](https://github.com/user-attachments/assets/9ad99e8a-b0a7-43ca-9262-658be37b5f5d)

- AutoLayout을 적용하여 다른 기기에서도 동일한 위치에 오게끔 하였음
<table>
  <tr>
    <td><img width="374" alt="Screenshot 2025-02-10 at 16 24 15" src="https://github.com/user-attachments/assets/adc3abae-b7b9-4fb9-8bef-77ef9da148bf" /></td>
    <td><img width="475" alt="Screenshot 2025-02-10 at 16 23 50" src="https://github.com/user-attachments/assets/cd7c0d7a-cf44-492e-8eb6-979bdda6fc18" /></td>
  </tr>
</table>


### Comments
- UIColor에서 RGB값을 적용하려면 0부터 1사이의 값을 적용해야함. 다른 방법이 있을 것 같지만, 일단 간단히 텍스트 변환시에 255를 곱하여 표현하였음.
