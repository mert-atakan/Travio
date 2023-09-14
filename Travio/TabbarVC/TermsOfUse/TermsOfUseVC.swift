//
//  TermsOfUseVC.swift
//  Travio
//
//  Created by Kaan Acikgoz on 12.09.2023.
//

import UIKit
import WebKit
import TinyConstraints

class TermsOfUseVC: UIViewController {
    
    private lazy var backButton:UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "vector"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var headerLabel:UILabel = {
        let termsLabel = UILabel()
        termsLabel.font = Font.poppins(fontType: .semibold, size: 32).font
        termsLabel.textColor = Color.white.chooseColor
        termsLabel.text = "Terms Of Use"
        
        return termsLabel
    }()
    
    private lazy var containerView:UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = Color.systemWhite.chooseColor
        return whiteView
    }()
    
    private lazy var webView:WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.systemGreen.chooseColor
        setupView()
       
    }
    
    override func viewWillLayoutSubviews() {
        containerView.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webKitUrl()
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func webKitUrl() {
        
        guard let url = URL(string: "https://api.iosclass.live/terms") else {
            return
            }
        webView.load(URLRequest(url: url))
    }
    
    func setupView() {
        
        view.addSubviews(backButton, headerLabel, containerView)
        containerView.addSubview(webView)
        setupLayout()
    }

    func setupLayout() {
            
        backButton.edgesToSuperview(excluding: [.bottom, .right], insets: .left(24) + .top(32), usingSafeArea: true)
        backButton.height(21.39)
        backButton.width(24)
            
        headerLabel.topToSuperview(offset:19, usingSafeArea: true)
        headerLabel.leadingToTrailing(of: backButton, offset: 24)
            
        containerView.topToBottom(of: headerLabel, offset: 58)
        containerView.edgesToSuperview(excluding: [.top])
        
        webView.edges(to: containerView)
    }
    

}
