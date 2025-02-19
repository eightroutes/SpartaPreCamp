//
//  ViewController.swift
//  PreCampMemo
//
//  Created by 정근호 on 2/12/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var memoTableView: UITableView!
    @IBOutlet weak var addMemoBtn: UIButton!
    
    var memoList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        // 테이블 뷰와 컨트롤러 연결
        memoTableView.delegate = self
        memoTableView.dataSource = self
        
    }
    
    func saveData() {
        UserDefaults.standard.set(memoList, forKey: "memoList")
    }

    func loadData() {
        if let savedMemoList = UserDefaults.standard.array(forKey: "memoList") as? [String] {
            memoList = savedMemoList
        }
    }

    @IBAction func addMemo(_ sender: Any) {
        let alert = UIAlertController(title: "새 메모", message: "메모할 내용을 입력하세요.", preferredStyle: .alert)
        alert.addTextField()
        
        let addAction = UIAlertAction(title: "추가", style: .default) { _ in
            
            if let text = alert.textFields?.first?.text, !text.isEmpty {
//                self.memoList.append(text) // 기존
                self.memoList.insert(text, at: 0) // 최근 추가한 것이 맨 위로
                self.memoTableView.reloadData()
                self.saveData()
            }
        }
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoViewCell", for: indexPath)
        cell.textLabel?.text = memoList[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { _, _, completionHandler in

            self.memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            completionHandler(true)
            self.saveData()
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }

    
    
    
}
