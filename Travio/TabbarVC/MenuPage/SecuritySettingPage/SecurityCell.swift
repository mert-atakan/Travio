//
//  SecurityCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 4.09.2023.
//

import UIKit
import TinyConstraints

class SecurityCell: UITableViewCell {
    
    let viewModal = SecurityCellVM()
    weak var delegate: CellFunctions?
    
    lazy var switchView: CustomSwitchView = {
        let v = CustomSwitchView()
        v.switchView.addTarget(self, action: #selector(switchValueChanged(_ : )), for: .valueChanged)
        return v
    }()
    
    lazy var passwordView: CustomView = {
        let v = CustomView()
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchValueChanged(_ sender: CustomSwitchView ) {
        viewModal.openAppSettings()
    }
    
    @objc func textFieldDidChange() {
        if passwordView.isPassword {
            if passwordView.titleLabel.text == "New Password" {
                delegate?.textFieldFunctions(text: passwordView.textField.text!, number: 1)
            } else {
                delegate?.textFieldFunctions(text: passwordView.textField.text!, number:2 )
            }
        }
    }
    
    func configure(section: Int,data:String ) {
        if section == 0 {
            switchView.isHidden = true
           setPasswordAttributes(view: passwordView, data: data)
        } else if section == 1 {
            switchView.titleLabel.text = data
            setToggles(data: data)
            passwordView.isHidden = true
        }
    }
    
    func setPasswordAttributes(view: CustomView,data:String) {
       view.titleLabel.text = data
       view.textField.isSecureTextEntry = true
       view.textField.attributedPlaceholder = NSAttributedString(string: "******", attributes: passwordView.attributes)
       view.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func setToggles(data: String) {
        var permissionKey = String()
        switch data {
        case "Camera":
            self.viewModal.checkCameraPermission()
            permissionKey = "CameraPermission"
        case "Photo Library":
            self.viewModal.checkLibraryPermission()
            permissionKey = "LibraryPermission"
        case "Location":
            self.viewModal.checkLocationPermission()
            permissionKey = "LocationPermission"
            
        default:
            break
        }
        switchView.switchView.isOn = viewModal.setPermissionToggle(forKey: permissionKey)
    }
    
    private func setupView() {
        contentView.backgroundColor = Color.systemWhite.chooseColor
        contentView.addSubviews(passwordView,switchView)
        setupLayout()
    }
    
    func setupLayout() {
        switchView.edgesToSuperview(insets: .right(24) + .left(24) + .top(4) + .bottom(5))
        switchView.height(72)
        
        passwordView.edgesToSuperview(insets: .right(24) + .left(24) + .top(4) + .bottom(5))
        passwordView.height(72)
    }
    
}


//extension SecurityCell: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//    }
//}
