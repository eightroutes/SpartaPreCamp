<h1>카운터 앱 프로젝트</h1>

카운터 앱은 숫자를 증가, 감소, 초기화하는 기능을 가진 간단한 iOS 앱입니다.

### Objective
1. **숫자 증가/감소**:
    - "+" 버튼을 클릭하면 숫자가 1씩 증가.
    - "-" 버튼을 클릭하면 숫자가 1씩 감소.
2. **초기화 기능**:
    - "Reset" 버튼을 클릭하면 숫자가 0으로 초기화.
3. **현재 숫자 표시**:
    - 중앙에 UILabel로 현재 숫자를 표시.
      
### Key Result
- -10 ~ 10 까지 +, - 버튼을 누르면 숫자 텍스트가 변경됨
- -10, 10에 도달시 버튼 비활성화
- Reset 누를 시 0으로 초기화

![Simulator Screen Recording - iPhone 16 Pro - 2025-02-11 at 17 01 39](https://github.com/user-attachments/assets/0d117c40-4df6-42c6-a9b6-1bae24465035)
  
- AutoLayout으로 다른 기기에서도 동일하게 위치하도록 하였음.
  <table>
    <tr>
      <td><img width="401" alt="Screenshot 2025-02-11 at 17 02 06" src="https://github.com/user-attachments/assets/16638a9e-98fc-4a5f-bd6e-30ab620ac266" /></td>
      <td><img width="696" alt="Screenshot 2025-02-11 at 16 53 31" src="https://github.com/user-attachments/assets/7f43782a-aaa2-444d-83d9-13b35fc31abe" /></td>
    </tr>
  </table>
### Comments
- 힌트를 보고 코드 수정 하였음.
  
  ```
  minusButton.isEnabled = count > -10
  plusButton.isEnabled = count < 10
  ```
- 기존 코드

  ```
  
    import UIKit
    
    class ViewController: UIViewController {
    
        @IBOutlet weak var numberText: UILabel!
        @IBOutlet weak var resetBtn: UIButton!
        var currentNum = 0
        
        @IBOutlet weak var plusBtn: UIButton!
        @IBOutlet weak var minusBtn: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
        
        @IBAction func plusBtnClicked(_ sender: Any) {
            currentNum += 1
            numberText.text = String(currentNum)
            if currentNum == 10 {
                plusBtn.isEnabled = false
            }
            
            if currentNum != -10 {
                minusBtn.isEnabled = true
            }
    
        }
        
    
        @IBAction func minusBtnClicked(_ sender: Any) {
            currentNum -= 1
            numberText.text = String(currentNum)
            if currentNum != 10 {
                plusBtn.isEnabled = true
            }
            
            if currentNum == -10 {
                minusBtn.isEnabled = false
            }
            
        }
        
        @IBAction func resetBtnClicked(_ sender: Any) {
            currentNum = 0
            numberText.text = String(currentNum)
            
            plusBtn.isEnabled = true
            minusBtn.isEnabled = true
        }
        
    }

  ```



