import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberText: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    
    var currentNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func plusBtnClicked(_ sender: Any) {
        currentNum += 1
        updateUI()
    }

    @IBAction func minusBtnClicked(_ sender: Any) {
        currentNum -= 1
        updateUI()
    }

    @IBAction func resetBtnClicked(_ sender: Any) {
        currentNum = 0
        updateUI()
    }
    
    private func updateUI() {
        numberText.text = "\(currentNum)"
        updateButtonStates()
    }

    private func updateButtonStates() {
        plusBtn.isEnabled = currentNum < 10
        minusBtn.isEnabled = currentNum > -10
    }
}
