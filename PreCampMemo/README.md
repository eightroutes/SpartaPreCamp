<h1>메모 앱 프로젝트</h1>

메모 앱은 사용자가 메모를 추가, 삭제하고 저장할 수 있는 간단한 리스트 앱입니다. UITableView와 UserDefaults를 활용하여 데이터 관리와 리스트 UI 구현을 연습할 수 있는 프로젝트입니다.

### Objective
1. **메모 추가**:
    - "+" 버튼을 눌러 새로운 메모를 추가.
    - 추가된 메모는 리스트에 표시.
2. **메모 삭제**:
    - 리스트에서 특정 메모를 스와이프하여 삭제.
3. **데이터 저장**:
    - 앱 종료 후에도 메모 리스트가 유지되도록 UserDefaults를 활용해 데이터 저장 및 불러오기.

### Key Result
- '+' 버튼을 누르면 UIAlertController로 메모 입력 창이 뜨고 입력 시 UITableView에 메모가 작성됨.
- 일반적인 메모 앱 처럼 메모가 스택처럼 쌓이도록 하였음.
- 스와이프 시 삭제 가능
- UserDefaults에 데이터 저장
  
![Simulator Screen Recording - iPhone 16 Pro - 2025-02-12 at 17 41 07](https://github.com/user-attachments/assets/55392970-eb1f-43c6-9702-37750ceca853)

- AutoLayout으로 다른 기기에서도 동일하게 위치하도록 하였음.
<table>
  <tr>
    <td>
      <img width="401" alt="Screenshot 2025-02-12 at 17 55 08" src="https://github.com/user-attachments/assets/c5d86e17-48b7-4a0a-8aae-304ab91a3e9c" />
    </td> 
    <td>
      <img width="696" alt="Screenshot 2025-02-12 at 17 55 00" src="https://github.com/user-attachments/assets/36eb4f5c-ddef-4a71-a97c-f69517b54f3b" />
    </td>
  </tr>
</table>

### Comments
- UITableView와 UserDefaults에 대해 아직 미숙하여 문제 힌트, 구글링, 지피티를 참고하였음.
