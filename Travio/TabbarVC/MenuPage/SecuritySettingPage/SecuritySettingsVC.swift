//
//  SecuritySettingsVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 29.08.2023.


import UIKit
import TinyConstraints
import CloudKit

protocol CellFunctions: AnyObject {
    func textFieldFunctions(text: String,number:Int)
}


class SecuritySettingsVC: UIViewController, CellFunctions {
   
    let viewModal = SecuritySettingsVM()
    var passwords = [1:"",2:""]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.poppins(fontType: .bold, size: 32).font
        label.textColor = Color.white.chooseColor
        label.text = "Security Settings"
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.systemWhite.chooseColor
        return view
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SecurityCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var saveButton: CustomButton = {
        let button = CustomButton()
        button.layer.cornerRadius = 3
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        containerView.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    @objc func saveTapped() {
        checkForEqual()
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func textFieldFunctions(text: String,number:Int) {
        passwords[number] = text
    }
    
    func checkForEqual() {
        guard let newPass = passwords[1], let rePass = passwords[2] else { return }
        
        if newPass.count < 6{
            AlertHelper.showAlert(in: self, title: .error, message: "Your password must be more than 6 character!", primaryButtonTitle: .ok)
        } else if (newPass == rePass){
            viewModal.changePassword(password: ["new_password": newPass]) { status, message in
                if !status {
                    AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
                } else {
                    AlertHelper.showAlert(in: self, title: .congrats, message: "Your password have changed successfuly!", primaryButtonTitle: .ok)
                }
            }
        } else {
            AlertHelper.showAlert(in: self, title: .error, message: "Your passwords did not match!", primaryButtonTitle: .ok)
        }
    }
    

    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = Color.systemGreen.chooseColor
        self.view.addSubViews( backButton, titleLabel, containerView)
        containerView.addSubviews(tableView, saveButton)
        setupLayout()
    }
    
    private func setupLayout() {
        
        
        backButton.edgesToSuperview(excluding: [.bottom,.right], insets: .top(32) + .left(24),usingSafeArea: true)
        backButton.height(22)
        backButton.width(24)
        
        titleLabel.centerY(to: backButton)
        titleLabel.leadingToTrailing(of: backButton, offset: 24)
        
        containerView.topToBottom(of: titleLabel, offset: 58)
        containerView.edgesToSuperview(excluding: [.top])
        
        saveButton.edgesToSuperview(excluding: [.top], insets: .left(24) + .right(24) + .bottom(24))
        saveButton.height(54)
        
        tableView.edgesToSuperview(excluding: [.top])
        tableView.bottomToTop(of: saveButton, offset: 78)
        tableView.topToSuperview(offset:20)
        
    }
    
}

extension SecuritySettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        headerView.backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 24, y: 20, width: tableView.frame.size.width - 20, height: 20))
        label.font = Font.poppins(fontType: .bold, size: 16).font
        label.textColor = Color.systemGreen.chooseColor
        if section == 0 {
            label.text = "Change Password"
        } else if section == 1 {
            label.text = "Privacy"
        }
        
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension SecuritySettingsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModal.settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.settingsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SecurityCell else {return UITableViewCell()}
       
        cell.configure(section: indexPath.section,
                       data: viewModal.settingsArray[indexPath.section][indexPath.row])
        
        cell.delegate = self
        return cell
    }
}


