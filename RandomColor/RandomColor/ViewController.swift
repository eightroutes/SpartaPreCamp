//
//  ViewController.swift
//  RandomColor
//
//  Created by 정근호 on 2/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectedColor: UILabel!
    @IBOutlet weak var changeColorBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func changeColor(_ sender: Any) {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        
        backgroundView.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
        selectedColor.text = "R: \(Int(randomRed*255)), G: \(Int(randomGreen*255)), B: \(Int(randomBlue*255))"
        
        print("R: \(Int(randomRed*255)), G: \(Int(randomGreen*255)), B: \(Int(randomBlue*255))")

    }
    
    @IBAction func resetColor(_ sender: Any) {
        backgroundView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        selectedColor.text = "R: 255, G: 255, B: 255"
    }
}

