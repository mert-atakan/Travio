//
//  Help&SupportVC.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 4.09.2023.
//

import UIKit
import TinyConstraints

class HelpAndSupportVC: UIViewController {
    
    var dataSource = CellDataModel.mockedData
    
//    let viewModel = HelpAndSupportVM()
    
    private lazy var helpAndSupportBackButton:UIButton = {
        let backButton = UIButton()
        let backButtonImage = UIImage(named: "vector.png")
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backToSettings), for: .touchUpInside)
        
        return backButton
    }()
    
    private lazy var helpAndSupportLabel:CustomLabel = {
        let topTitle = CustomLabel()
        topTitle.text = "Help&Support"
        topTitle.font = Font.semibold32.chooseFont
        topTitle.textColor = Color.white.chooseColor
        
        return topTitle
    }()
    
    private lazy var whiteView:UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = Color.systemWhite.chooseColor
        
        return whiteView
    }()
    
    private lazy var faqLabel:UILabel = {
        let faq = UILabel()
        faq.text = "FAQ"
        faq.textColor = Color.systemGreen.chooseColor
        faq.font = Font.semibold24.chooseFont
        
        return faq
    }()
    
        private lazy var faqTableView:UITableView = {
            let faqTableView = UITableView(frame: .zero, style: .plain)
            faqTableView.dataSource = self
            faqTableView.delegate = self
            faqTableView.register(HelpSupportTableCell.self, forCellReuseIdentifier: "customCell")
            faqTableView.isScrollEnabled = false
//            faqTableView.estimatedRowHeight = 100
//            faqTableView.rowHeight = UITableView.automaticDimension
            faqTableView.separatorStyle = .none
            faqTableView.backgroundColor = .clear
            faqTableView.translatesAutoresizingMaskIntoConstraints = false
            return faqTableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.systemGreen.chooseColor
        setupView()
        
    }
    
    override func viewDidLayoutSubviews() {
        whiteView.roundCorners(corners: .topLeft, radius: 80)
    }
    
    @objc func backToSettings() {
        self.dismiss(animated: true)
    }

    func setupView() {
        view.addSubviews(helpAndSupportBackButton, helpAndSupportLabel, whiteView)
        whiteView.addSubviews(faqLabel, faqTableView)
        setupLayout()
    }
  
    func setupLayout() {
        
        helpAndSupportBackButton.edgesToSuperview(excluding: [.right, .bottom], insets: .top(32) + .left(24), usingSafeArea: true)
        
        helpAndSupportLabel.leadingToTrailing(of: helpAndSupportBackButton, offset: 24)
        helpAndSupportLabel.topToSuperview(offset:19, usingSafeArea: true)
        
        whiteView.edgesToSuperview(insets: .top(125),usingSafeArea: true)
        whiteView.bottomToSuperview()
        
        faqLabel.top(to: whiteView, offset: 44)
        faqLabel.leadingToSuperview(offset:24)
        
        faqTableView.leadingToSuperview(offset:24)
        faqTableView.topToBottom(of: faqLabel, offset: 1)
        faqTableView.centerXToSuperview()
        faqTableView.bottomToSuperview(offset:-75)
    }

}

extension HelpAndSupportVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? HelpSupportTableCell else { return UITableViewCell() }
            cell.set(dataSource[indexPath.row])
                return cell
    }
    
}

extension HelpAndSupportVC:UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableView.automaticDimension
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
        }
    
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         dataSource[indexPath.row].isExpanded.toggle()
         tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    

}
