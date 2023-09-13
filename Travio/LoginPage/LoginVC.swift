//
//  ViewController.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//
//

import UIKit

import TinyConstraints
import NVActivityIndicatorView

class LoginVC: UIViewController {
    
    let viewModal = LoginVM()
    
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "travio")
        return iv
    }()
    
    private lazy var welcomeLbl: UILabel = {
        let l = UILabel()
        l.layer.cornerRadius = 3
        l.text = "Welcome to Travio"
        l.textAlignment = .center
        l.font = Font.semibold24.chooseFont
        return l
    }()
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    private lazy var emailView: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "Email"
        v.textField.text = "Melihv6@gmail.com"
        v.textField.attributedPlaceholder = NSAttributedString(string: "developer@bilgeadam.com", attributes: v.attributes)
        return v
    }()
    
    private lazy var passwordView: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "Password"
        v.textField.text = "123456q"
        v.textField.isSecureTextEntry = true
        v.textField.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
        return v
    }()
    
    private lazy var lgnBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var signLbl: UILabel = {
        let l = UILabel()
        l.text = "Don’t have  any account? Sign Up"
        l.font = Font.bold14.chooseFont
        l.textColor = Color.systemblack.chooseColor
        l.textAlignment = .center
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view1.roundCorners(corners: .topLeft, radius: 80)
    }
    
    @objc func signLblTapped(_ sender: UITapGestureRecognizer) {
        let signVC = SignUpVC()
        navigationController?.pushViewController(signVC, animated: true)
    }
    
    @objc func loginTapped() {
        self.activity.startAnimating()
        guard let email = emailView.textField.text, let password = passwordView.textField.text else {return}
        let body = ["email":email,"password":password]
        viewModal.login(params: body) { status,message in
            if !status {
                AlertHelper.showAlert(in: self, title: "Hata", message: message, primaryButtonTitle: "Ok", primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
            self.activity.stopAnimating()
            let vc = MainTabBarController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
//    private func showAlert(message: String) {
//        let alert = UIAlertController(title: "Üzgünüz", message: message, preferredStyle: .alert)
//        
//            let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
//            alert.addAction(action)
//            present(alert, animated: true, completion: nil)
//        
//    }
    
    private func setupView() {
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(imageview,view1,activity)
        view1.addSubViews(emailView,passwordView,welcomeLbl,lgnBtn,signLbl)
        setupLayout()
        signUpGesture()
    }
    
    private func setupLayout() {
        imageview.edgesToSuperview( insets: .top(44) + .right(121) + .left(120) + .bottom(622))
        
        view1.topToBottom(of: imageview ,offset: 24)
        view1.edgesToSuperview(excluding: [.top])
        
        welcomeLbl.edgesToSuperview( insets: .top(64) + .right(30) + .left(30) + .bottom(498))
        
        emailView.edgesToSuperview( insets: .top(141) + .right(24) + .left(24) + .bottom(383))
        
        passwordView.edgesToSuperview( insets: .top(239) + .right(24) + .left(24) + .bottom(285))
        
        lgnBtn.topToBottom(of: passwordView, offset: 48)
        lgnBtn.edgesToSuperview(excluding:[.top], insets: .right(24) + .left(24) + .bottom(183))
        
        signLbl.topToBottom(of: lgnBtn,offset: 141)
        signLbl.edgesToSuperview(excluding:[.top], insets: .right(30) + .left(30) + .bottom(21))
        
        activity.centerInSuperview()
        activity.height(50)
        activity.width(50)
    }
    
    func signUpGesture() {
        let signUpTapped = UITapGestureRecognizer(target: self, action: #selector(signLblTapped(_:)))
        self.signLbl.isUserInteractionEnabled = true
        self.signLbl.addGestureRecognizer(signUpTapped)
    }
    
   
    
}

