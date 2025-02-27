//
//  ViewController.swift
//  MemoProgrammatic
//
//  Created by 정근호 on 2/20/25.
//

import UIKit
import Combine

class MemoViewController: UIViewController {
    
    private let viewModel = MemoViewModel()
    private var cancellables = Set<AnyCancellable>()
    
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
        
        viewModel.loadData()
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
    
    private func bindViewModel() {
        viewModel.$memos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.memoTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    
    @objc private func addMemo() {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "새 메모", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "추가", style: .default) { _ in
            guard let text = textField.text, !text.isEmpty else { return }
            self.viewModel.addMemo(text)
            self.memoTableView.reloadData()
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
        present(alert, animated: true)
    }
}


// MARK: - Protocol
extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.memos?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.memos?[indexPath.row].memoText ?? "메모없음"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (self.viewModel.memos?[indexPath.row]) != nil
        {
            viewModel.deleteMemo(at: indexPath.row)
            
            tableView.reloadData()
        }
    }
}


#Preview {
    MemoViewController()
}
