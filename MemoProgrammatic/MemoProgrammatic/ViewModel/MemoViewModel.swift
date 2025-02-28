//
//  MemoViewModel.swift
//  MemoProgrammatic
//
//  Created by 정근호 on 2/27/25.
//

import RealmSwift
import Combine

class MemoViewModel {
    private let realm = try! Realm()
    @Published var memos: Results<Memo>?
    
    var memosPublisher: AnyPublisher<[Memo], Never> {
        $memos
            .compactMap { $0?.map{$0} } // .map: 각 요소 변형해서 새 컬렉션, 항상 Array를 반환
            .eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
    }

    func addMemo(_ text: String) {
        let newMemo = Memo()
        newMemo.memoText = text
        
        do {
            try realm.write {
                realm.add(newMemo)
            }
        } catch {
            print("메모 추가 실패: \(error)")
        }
    }

    func deleteMemo(at index: Int) {
        guard let memo = memos?[index] else { return }
        do {
            try realm.write {
                realm.delete(memo)
            }
        } catch {
            print("메모 삭제 실패: \(error)")
        }
    }

    func loadData() {
        memos = realm.objects(Memo.self) // Realm에서 메모 목록 가져옴
    }
}
