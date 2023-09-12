//
//  Help&SupportVC.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 4.09.2023.
//

import UIKit
import TinyConstraints

class HelpAndSupportVC: UIViewController {
    
    let viewModel = HelpAndSupportVM()
    
    private lazy var backBtn:UIButton = {
        let backButton = UIButton()
        let backButtonImage = UIImage(named: "vector.png")
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backToSettings), for: .touchUpInside)
        
        return backButton
    }()
    
    private lazy var titleLbl:CustomLabel = {
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
    
    private lazy var faqTableView:UITableView = {
        let faqTableView = UITableView(frame: .zero, style: .plain)
        faqTableView.dataSource = self
        faqTableView.delegate = self
        faqTableView.register(HelpSupportTableCell.self, forCellReuseIdentifier: "customCell")
        faqTableView.isScrollEnabled = true
        faqTableView.separatorStyle = .none
        faqTableView.backgroundColor = .clear
        faqTableView.translatesAutoresizingMaskIntoConstraints = false
        return faqTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        whiteView.roundCorners(corners: .topLeft, radius: 80)
    }
    
    @objc func backToSettings() {
        self.dismiss(animated: true)
    }
    
    func setupView() {
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubviews(backBtn, titleLbl, whiteView)
        whiteView.addSubviews(faqTableView)
        setupLayout()
    }
    
    func setupLayout() {
        backBtn.edgesToSuperview(excluding: [.right, .bottom], insets: .top(32) + .left(24), usingSafeArea: true)
        
        titleLbl.leadingToTrailing(of: backBtn, offset: 24)
        titleLbl.topToSuperview(offset:19, usingSafeArea: true)
        
        whiteView.topToBottom(of: titleLbl, offset: 58)
        whiteView.edgesToSuperview(excluding: [.top])
        
        faqTableView.topToSuperview(offset: 44)
        faqTableView.edgesToSuperview(excluding: [.top])
    }
    
    private func headerLabel(section:Int, headerView:UIView) -> UILabel {
        let label = UILabel()
        label.frame = CGRect.init(x: 24, y: 0, width: headerView.frame.width-10, height: 21)
        label.text = "FAQ"
        label.font = Font.semibold24.chooseFont
        label.textColor = Color.systemGreen.chooseColor
        return label
    }
    
}

extension HelpAndSupportVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellForSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? HelpSupportTableCell else { return UITableViewCell() }
        cell.set(viewModel.getObject(indexPath: indexPath))
        return cell
    }
    
}

extension HelpAndSupportVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.mockedData[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 21))
        headerView.backgroundColor = Color.systemWhite.chooseColor
        
        let label = headerLabel(section: section,headerView: headerView)
        
        headerView.addSubview(label)
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
}






