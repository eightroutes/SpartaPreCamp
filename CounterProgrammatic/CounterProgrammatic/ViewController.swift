//
//  ViewController.swift
//  CounterProgrammatic
//
//  Created by 정근호 on 2/19/25.
//

import UIKit
import SwiftUI

final class ViewController: UIViewController {
    
    var currentNum = 0
    
    
    private var numberText: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 24, weight: .bold) // 텍스트 사이즈, 굵기
        label.textColor = .black
                
        return label
        
    }()
    
    private lazy var resetBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("RESET", for: .normal)
        btn.titleLabel?.textColor = .white // 텍스트 색
        btn.tintColor = .systemRed // 버튼 색
        btn.clipsToBounds = true
        btn.configuration = .filled() // 버튼 스타일
        
        btn.addTarget(self, action: #selector(resetBtnClicked), for: .touchUpInside) // 버튼 액션 설정
        
        return btn
    }()
    
    private lazy var plusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .black
        btn.titleLabel?.textColor = .white
        btn.clipsToBounds = true
        btn.configuration = .filled()
        
        btn.addTarget(self, action: #selector(plusBtnClicked), for: .touchUpInside)
        

        return btn
    }()
    
    private lazy var minusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "minus"), for: .normal)
        btn.tintColor = .black
        btn.titleLabel?.textColor = .white
        btn.clipsToBounds = true
        btn.configuration = .filled()
        
        btn.addTarget(self, action: #selector(minusBtnClicked), for: .touchUpInside)
        
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUI()
        
        setUI()
        setLayout()
    }
    
    private func updateUI() {
        numberText.text = "\(currentNum)"
        updateButtonStates()
    }

    private func updateButtonStates() {
        plusBtn.isEnabled = currentNum < 10
        minusBtn.isEnabled = currentNum > -10
    }
    
    @objc private func plusBtnClicked() {
        currentNum += 1
        updateUI()
    }
    
    @objc private func minusBtnClicked() {
        currentNum -= 1
        updateUI()
    }
    
    @objc private func resetBtnClicked() {
        currentNum = 0
        updateUI()
    }
    
    
    private func setUI() {
    
        view.backgroundColor = .white
        
        // UIKit에서는 UIViewController가 view라는 기본 뷰를 제공
        // 하지만 우리가 만든 UI 요소(numberText, resetBtn, plusBtn, minusBtn)는 기본적으로 view에 포함되지 않음
        // 그래서 직접 view.addSubview(_:)를 호출해서 view의 하위 뷰로 추가해야 함
        [numberText, resetBtn, plusBtn, minusBtn].forEach {
            view.addSubview($0)
        }
    }
    
    

    private func setLayout() {
        // translatesAutoresizingMaskIntoConstraints = false는 Auto Layout을 사용할 것이니, 자동 크기 조절 기능을 끄겠다는 의미
        numberText.translatesAutoresizingMaskIntoConstraints = false
        resetBtn.translatesAutoresizingMaskIntoConstraints = false
        plusBtn.translatesAutoresizingMaskIntoConstraints = false
        minusBtn.translatesAutoresizingMaskIntoConstraints = false

        // AutoLayout 설정
        NSLayoutConstraint.activate([
            numberText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            resetBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetBtn.topAnchor.constraint(equalTo: numberText.bottomAnchor, constant: 20),
            
            plusBtn.leadingAnchor.constraint(equalTo: resetBtn.trailingAnchor, constant: 20),
            plusBtn.centerYAnchor.constraint(equalTo: resetBtn.centerYAnchor),
            
            minusBtn.trailingAnchor.constraint(equalTo: resetBtn.leadingAnchor, constant: -20),
            minusBtn.centerYAnchor.constraint(equalTo: resetBtn.centerYAnchor),
            
            
        ])
    }
    

}



struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerWrapper()
    }
}

struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
