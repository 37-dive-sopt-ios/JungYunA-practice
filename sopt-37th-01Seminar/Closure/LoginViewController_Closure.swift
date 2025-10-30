//
//  LoginViewController.swift
//  sopt-37th-01Seminar
//
//  Created by 정윤아 on 10/11/25.
//


import UIKit

class LoginViewController_Closure: UIViewController {
    
    // MARK: - Properties

//    // 배달의민족 주조색 (하늘색 계열)
//    let baeminSkyBlue = UIColor(red: 35/255, green: 200/255, blue: 195/255, alpha: 1.0)
//    // 텍스트 필드 배경색 (약간 연한 회색)
//    let textFieldBackgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
//    // 텍스트 필드 테두리 색상 (더 연한 회색)
//    let textFieldBorderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
//
    
    //당근마켓 주황색
    let Primary_Orange = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1.0)
    //로그인 버튼 비활성화
    let disableButton = UIColor.gray
    
    // MARK: - UI Components
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 70, y: 163, width: 250, height: 50))
        label.text = "동네라서 가능한 모든 것 \n당근에서 가까운 이웃과 함께해요"
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 40, y: 276, width: 335, height: 52))
        textField.placeholder = "아이디"
        textField.borderStyle = .none // 기본 borderStyle 제거
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1.0) // 연한 회색 배경
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0).cgColor // 더 연한 테두리
        // 텍스트 필드 좌우 패딩 추가
        textField.addLeftPadding()
        textField.addRightPadding()
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 40, y: 335, width: 335, height: 52))
        textField.placeholder = "비밀번호"
        textField.borderStyle = .none // 기본 borderStyle 제거
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1.0) // 연한 회색 배경
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0).cgColor
        // 텍스트 필드 왼쪽 패딩 추가
        textField.addLeftPadding()
        
        
        //텍스트 필드 오른쪽 '표시' 버튼 추가
        textField.rightView = passwordSecureButton
        textField.rightViewMode = .always
        
        return textField
    }()
    
    lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 15)
        button.addTarget(self, action: #selector(passwordSecureButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func passwordSecureButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        
        let buttonTitle = passwordTextField.isSecureTextEntry ? "표시" : "숨김"
        passwordSecureButton.setTitle(buttonTitle, for: .normal)
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 40, y: 422, width: 335, height: 57))
        button.setTitle("로그인 하기", for: .normal)
        button.backgroundColor = Primary_Orange
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
//        (red: 35/255, green: 200/255, blue: 195/255, alpha: 1.0) // 배민 스카이 블루
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        
        button.addTarget(self, action: #selector(loginButtonDidtap), for: .touchUpInside)
        return button
    }()
    
    //로딩 중을 나타내는 컴포넌트
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        
        indicator.color = .gray
        
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    
 
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setHierarchy() {
        let components = [
            titleLabel,
            idTextField,
            passwordTextField,
            loginButton,
            loadingIndicator
        ]
        
        components.forEach { view.addSubview($0) }
    }
    
    private func setLayout() {
        loadingIndicator.center = self.view.center

    }
    
    //modal
    private func presentTowlecomeVC(){
        let vc = WelcomeViewController_Closure()
        vc.name = idTextField.text //type 맞추기
        // completionHandler 정의하기!
        vc.completionHandler = { [weak self] message in self?.handleCompletion(message: message)
        }
//        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
    }
    
    private func handleCompletion(message: String) {
        titleLabel.text = message
        idTextField.text = ""
        passwordTextField.text = ""
        loginButton.setTitle("다시 로그인하기", for: .normal)
    }

    
    //navigation
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_Closure()
        welcomeViewController.name = idTextField.text
        welcomeViewController.completionHandler = { [weak self] message in
            
            guard let self = self else { return }
            
            self.titleLabel.text = message
            self.idTextField.text = ""
            self.passwordTextField.text = ""
            loginButton.setTitle("다시 로그인하기", for: .normal)
        }
        
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    

    
    //로그인 버튼 눌렀을 때
    @objc
    private func loginButtonDidtap() {
            //로딩 애니메이션을 시작
            loadingIndicator.startAnimating()
            
            // 다른 버튼들을 비활성화
            view.isUserInteractionEnabled = false
            
            // 딜레이
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            // self가 유효한지 확인
            guard let self = self else { return }
            
            // 로딩 애니메이션을 중지
            self.loadingIndicator.stopAnimating()
            
            // 비활성화 해제
            self.view.isUserInteractionEnabled = true
            
            // 화면 전환 실행
//            self.presentTowlecomeVC()
            //            presentTowlecomeVC()
                    pushToWelcomeVC()
        }
    }
}


#Preview{
    let vc = LoginViewController_Closure()
    UINavigationController(rootViewController: vc) //navigation
}
