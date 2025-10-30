import Foundation
import UIKit

final class WelcomeViewController_Closure: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 112, y: 87, width: 150, height: 150))
        imageView.image = UIImage(named: "Image")
        return imageView
    }()
    
    var name: String? //optional 타입으로 선언
    
    var completionHandler: ((String) -> Void)? // 클로저타입의 프로퍼티 선언 (name 값을 다른 곳으로 전송하기 위해 전송)
    
    private let welcomeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 140, y: 295, width: 95, height: 60))
        label.text = "???님 \n반가워요!"
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 25)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private var goHomeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 426, width: 335, height: 58))
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.layer.cornerRadius = 6
        return button
    }()
    
    lazy var backToLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 498, width: 335, height: 58))
        button.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        button.setTitle("다시 로그인", for: .normal)
        button.setTitleColor(UIColor(red: 172/255, green: 176/255, blue: 185/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
//        button.addTarget(self, action: #selector(backToLoginButtonDidTap),for: .touchUpInside)
        button.layer.cornerRadius = 6
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setLayout()
        bindID()
        
        backToLoginButton.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
    }
    
    private func setLayout() {
        [logoImageView, welcomeLabel, goHomeButton, backToLoginButton].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
    }
    
    @objc
    private func backToLoginButtonDidTap() {
    
        let nickname = name ?? "알 수 없는 사용자"
            
        completionHandler?("\(nickname)님이 다시 로그인 버튼을 눌렀어요!")
        
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    

    private func bindID() {
        
        if let name = name {
            self.welcomeLabel.text = "\(name)님 \n반가워요!"
        } else {
            print("환영합니다")
        }
        
    }
}

#Preview{
    let vc = LoginViewController_Closure()
    UINavigationController(rootViewController: vc)
}
