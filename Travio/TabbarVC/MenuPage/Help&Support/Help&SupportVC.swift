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
    
    private lazy var backButton:UIButton = {
        let backButton = UIButton()
        let backButtonImage = UIImage(named: "vector.png")
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return backButton
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Help&Support"
        label.font = Font.poppins(fontType: .semibold, size: 32).font
        label.textColor = Color.white.chooseColor
        
        return label
    }()
    
    private lazy var containerView:UIView = {
        let view = UIView()
        view.backgroundColor = Color.systemWhite.chooseColor
        return view
    }()
    
    private lazy var faqTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HelpSupportTableCell.self, forCellReuseIdentifier: "customCell")
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        containerView.roundCorners(corners: .topLeft, radius: 80)
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    private func headerLabel(section:Int, headerView:UIView) -> UILabel {
        let label = UILabel()
        label.frame = CGRect.init(x: 24, y: 0, width: headerView.frame.width-10, height: 21)
        label.text = "FAQ"
        label.font = Font.poppins(fontType: .semibold, size: 24).font
        label.textColor = Color.systemGreen.chooseColor
        return label
    }
    
    func setupView() {
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubviews(backButton, titleLabel, containerView)
        containerView.addSubviews(faqTableView)
        setupLayout()
    }
    
    func setupLayout() {
        backButton.edgesToSuperview(excluding: [.right, .bottom], insets: .top(32) + .left(24), usingSafeArea: true)
        backButton.height(22)
        backButton.width(24)
        
        titleLabel.leadingToTrailing(of: backButton, offset: 24)
        titleLabel.centerY(to: backButton)
        
        containerView.topToBottom(of: titleLabel, offset: 58)
        containerView.edgesToSuperview(excluding: [.top])
        
        faqTableView.topToSuperview(offset: 44)
        faqTableView.edgesToSuperview(excluding: [.top])
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
