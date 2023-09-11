//
//  SignUpVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
class SignUpVC: UIViewController {
    
    let viewModal = RegisterVM()
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "vector"), for: .normal)
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleLbl: UILabel = {
        let l = UILabel()
        l.font = Font.bold36.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Sign Up"
        return l
    }()
    
    private lazy var usernameView: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "Username"
        //v.textField.delegate = self
        v.textField.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: v.attributes)
        v.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return v
    }()
    
    private lazy var emailView: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "Email"
        v.textField.attributedPlaceholder = NSAttributedString(string: "developer@bilgeadam.com", attributes: v.attributes)
        v.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return v
    }()
    
    private lazy var pass1View: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "Password"
        //v.textField.delegate = self
        v.textField.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
        v.textField.isSecureTextEntry = true
        v.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return v
    }()
    
    private lazy var pass2View: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "Password Confirm"
        v.textField.attributedPlaceholder = NSAttributedString(string: "******", attributes: v.attributes)
        v.textField.isSecureTextEntry = true
        v.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 24
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var lgnBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("Register", for: .normal)
        btn.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        btn.backgroundColor = Color.systemgray.chooseColor
        btn.isEnabled = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: .topLeft, radius: 80)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @objc func textFieldDidChange() {
       if viewModal.updateLoginButtonState(isEmail: emailView.isEmail,
                                                     isUsername: usernameView.isUsername,
                                                     isPassword: pass1View.isPassword,
                                                     isPassword2: pass2View.isPassword,
                                                     password1Text: pass1View.textField.text ?? "",
                                                     password2Text: pass2View.textField.text ?? ""
        ) {
            lgnBtn.isEnabled = true
            lgnBtn.backgroundColor = Color.systemGreen.chooseColor
        }
      }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func registerTapped() {
        guard let name = usernameView.textField.text, let email = emailView.textField.text, let password1 = pass1View.textField.text,let _ = pass2View.textField.text else {return}
        
        let body = ["full_name":name,"email":email,"password":password1]
        
        viewModal.register(params: body, handler: { response in
            if response.status == "fail" {
                self.showErrorAlert(message: """
                                                Username alanına sadece harf girmelisiniz.
                                                Email alanına email formatı girmelisiniz.
                                                Şifreniz en az 1 harf ve 1 sayı ve en az 6 karakterden oluşmalıdır.
                                             """)
            } else {
                self.showPositiveAlert()
            }
        })
    }
    
    private func setupView() {
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1,titleLbl,backButton)
        view1.addSubViews(stackView,lgnBtn)
        stackView.addArrangedSubviews(usernameView)
        stackView.addArrangedSubviews(emailView)
        stackView.addArrangedSubviews(pass1View)
        stackView.addArrangedSubviews(pass2View)
        setupLayout()
    }
    
    private func setupLayout() {
        backButton.edgesToSuperview(excluding: [.bottom,.right], insets: .top(32) + .left(23),usingSafeArea: true)
        backButton.height(21)
        backButton.width(24)
        
        titleLbl.edgesToSuperview(excluding: [.bottom, .left], insets: .top(19) + .right(24),usingSafeArea: true)
        titleLbl.leftToRight(of: backButton, offset: 77)
        titleLbl.height(48)
        
        view1.edgesToSuperview(excluding: [.top])
        view1.topToBottom(of: titleLbl, offset: 58)
        
        stackView.edgesToSuperview( insets: .top(72) + .left(24) + .right(24) + .bottom(279))
        
        lgnBtn.topToBottom(of: stackView, offset: 202)
        lgnBtn.edgesToSuperview( excluding: [.top],insets: .left(24) + .right(24) + .bottom(23))
    }
    
    
    func showPositiveAlert() {
        let alert = UIAlertController(title: "Tebrikler, Kaydoldunuz", message: "Şimdi sisteme giriş yapabilirsin.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Login sayfasına git", style: .default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true)
    }
    func showErrorAlert(message:String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "tamam", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

