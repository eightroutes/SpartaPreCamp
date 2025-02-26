//
//  ViewController.swift
//  MemoProgrammatic
//
//  Created by 정근호 on 2/20/25.
//

import UIKit
import RealmSwift


class MemoViewController: UIViewController {
    
    let realm = try! Realm()
    
    var memo: Results<Memo>?
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var memoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MemoCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.clipsToBounds = true
        
        return tableView
        
    }()
    
    
    private lazy var addBtn: UIButton = {
        let addBtn = UIButton()
        addBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        addBtn.configuration = .filled()
        addBtn.tintColor = .black
        addBtn.clipsToBounds = true
        
        addBtn.addTarget(self, action: #selector(addMemo), for: .touchUpInside)
        
        
        return addBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        loadData()
        setUI()
    }
    
    private func setUI() {
        
        [memoTableView, addBtn, titleLabel].forEach {
            view.addSubview($0)
        }
        memoTableView.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memoTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            memoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            memoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            memoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            addBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addBtn.widthAnchor.constraint(equalToConstant: 50),
            addBtn.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: memoTableView.topAnchor, constant: -10)
        ])
    }
    
    
    
    func saveData(_ memo: Memo) {
        
        do {
            try realm.write {
                realm.add(memo)
            }
        } catch {
            print("메모 추가 에러, \(error)")
        }
        
        memoTableView.reloadData()
    }
    
    func loadData() {
        
        memo = realm.objects(Memo.self)
        
        memoTableView.reloadData()
        
    }
    
    @objc private func addMemo() {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "새 메모", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "추가", style: .default) { _ in
            let newMemo = Memo()
            newMemo.memoText = textField.text!
            
            self.saveData(newMemo)
        }
        
        addAction.isEnabled = false
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "메모할 내용을 입력하세요."
            textField = alertTextField
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { _ in
                addAction.isEnabled = !((textField.text?.isEmpty) == true)
            }
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
        alert.addAction(addAction)
        
        
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - Protocol
extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memo?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        
        cell.textLabel?.text = memo?[indexPath.row].memoText ?? "메모없음"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if let memoForDeletion = self.memo?[indexPath.row]
        {
            do {
                try self.realm.write {
                    self.realm.delete(memoForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
            tableView.reloadData()
        }
    }
}


#Preview {
    MemoViewController()
}
