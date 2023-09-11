//
//  AboutUsVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 6.09.2023.
//

import UIKit
import TinyConstraints
import WebKit
import NVActivityIndicatorView
class AboutUsVC: UIViewController, WKUIDelegate {
    
    var shouldStop: Bool? = false {
        didSet {
            activity.stopAnimating()
        }
    }
    
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
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
        l.font = Font.bold32.chooseFont
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
           //shouldStop = true
           return vw
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: [.topLeft], radius: 80)
        activity.startAnimating()
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1,backButton,titleLbl,activity)
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
        
        activity.centerInSuperview()
        activity.height(50)
        activity.width(50)
        
    }
}


//extension AboutUsVC : WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        let changeFontFamilyScript = "document.getElementsByTagName('body')[0].style.fontFamily = 'Times New Roman, Times, serif';"
//
//
//        webView.evaluateJavaScript(changeFontFamilyScript) { (response, error) in
//            debugPrint("Am here")
//        }
//    }
//}
