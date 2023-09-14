//
//  AboutUsVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 6.09.2023.
//

import UIKit
import TinyConstraints
import WebKit
class AboutUsVC: UIViewController, WKUIDelegate {
    
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
        l.font = Font.poppins(fontType: .bold, size: 32).font
        l.textColor = Color.white.chooseColor
        l.text = "About Us"
        return l
    }()
    
    private lazy var webView: WKWebView = {
           let vw = WKWebView()
           vw.backgroundColor = Color.systemWhite.chooseColor
           let url = URL(string: "https://api.iosclass.live/about")
           let request = URLRequest(url: url!)
           vw.load(request)
           return vw
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1,backButton,titleLbl)
        view1.addSubviews(webView)
        setupLayout()
    }
    private func setupLayout() {
        backButton.edgesToSuperview(excluding: [.bottom,.right], insets: .top(32) + .left(23),usingSafeArea: true)
        backButton.height(21)
        backButton.width(24)
        
        titleLbl.edgesToSuperview(excluding: [.bottom, .left], insets: .top(19) + .right(24),usingSafeArea: true)
        titleLbl.leftToRight(of: backButton, offset: 24)
        titleLbl.height(48)
        
        view1.edgesToSuperview(excluding: [.top])
        view1.topToBottom(of: titleLbl, offset: 58)
        
        webView.edgesToSuperview()
        
    }
}
