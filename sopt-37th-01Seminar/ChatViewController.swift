//
//  ChatViewController.swift
//  sopt-37th-01Seminar
//
//  Created by 정윤아 on 11/1/25.
//

import UIKit
import SnapKit

final class ChatViewController: UIViewController {
    
    
    private let tableView = UITableView(frame: .zero, style: .plain) // 테이블 뷰 객체 초기화 (autolayout으로 잡아줄거니까 frame .zero)
    
    private var chatRooms: [ChatRoomModel] = [] // 배열 초기화

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        register()
        setDelegate()
            loadMockData() // 데이터 불러오기! ex) 서버 통신
    }

    private func loadMockData() {
        chatRooms = ChatRoomModel.mockData
        tableView.reloadData()
    }
    
    private func setDelegate() { // 누구한테 짬 때릴건지 채택!
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func register() { // 셀 등록
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
    }
    
    private func setUI() {  // 기본 속성 정의
        view.backgroundColor = .white
        title = "채팅"
        tableView.separatorStyle = .singleLine
    }
    
    private func setLayout() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()  //동서남북에 다 채워 넣음
        }
    }
    
    
}

// MARK: - UITableViewDelegate


//액션 처리
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(chatRooms[indexPath.row].name) 채팅방 선택됨")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

// MARK: - UITableViewDataSource

//데이터를 받아 뷰를 그려줌
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(chatRoom: chatRooms[indexPath.row])
        return cell
    }
    
    
    
    
}

#Preview{
    ChatViewController()
}

