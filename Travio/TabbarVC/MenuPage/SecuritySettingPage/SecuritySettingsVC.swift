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
        l.text = "Security Settings"
        return l
    }()
    
    
    private lazy var saveBtn: CustomButton = {
        let btn = CustomButton()
        btn.layer.cornerRadius = 3
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SecurityCell.self, forCellReuseIdentifier: "cell")
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    @objc func saveTapped() {
        checkForEqual()
        viewModal.statusAlert = {status in
            self.statusAlert(status: status)
        }
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func textFieldFunctions(text: String,number:Int) {
        passwords[number] = text
        print(passwords )
    }
    
    func checkForEqual() {
        if passwords[1] == passwords[2] && passwords[1] != "" || passwords[2] != "" {
            guard let password = passwords[1] else {return}
            viewModal.changePassword(password: ["new_password": password])
        } else {
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Hata", message: "Girdiğiniz şifreler aynı değildir.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func statusAlert(status:String) {
        var alert = UIAlertController()
        var action = UIAlertAction()
        if status == "success" {
            alert = UIAlertController(title: "Tebrikler", message: "Şifreniz başarıyla değiştirildi.", preferredStyle: .alert)
             action = UIAlertAction(title: "Tamam", style: .default) {action in
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            alert = UIAlertController(title: "Üzgünüz", message: "Şifreniz değiştirilemedi.", preferredStyle: .alert)
             action = UIAlertAction(title: "Tamam", style: .default)
        }
       
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(view1,tableView,backButton,titleLbl,saveBtn)
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
        
        tableView.edgesToSuperview(excluding:[.bottom,.top])
        tableView.bottomToTop(of: saveBtn, offset: -20)
        tableView.top(to: view1, offset: 20)
        
        saveBtn.edgesToSuperview(excluding: [.top], insets: .left(24) + .right(24) + .bottom(18))
        saveBtn.height(54)
        
    }
    
}

extension SecuritySettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        headerView.backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 24, y: 5, width: tableView.frame.size.width - 20, height: 20))
        label.font = Font.bold16.chooseFont
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
        return 30.0
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


