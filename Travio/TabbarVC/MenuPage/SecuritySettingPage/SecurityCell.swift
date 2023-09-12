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
         v.textField.delegate = self
        return v
    }()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchValueChanged(_ sender: CustomSwitchView ) {
        openAppSettings()
        switch switchView.titleLabel.text {
        case "Camera"  :
            self.viewModal.checkCameraPermission()
            switchView.switchView.isOn = viewModal.setPermissionToggle(forKey: "Camera")
        case "Photo Library" :
            self.viewModal.checkLibraryPermission()
            switchView.switchView.isOn = viewModal.setPermissionToggle(forKey: "Photo Library")
        case "Location" :
            self.viewModal.checkLocationPermission()
            switchView.switchView.isOn = viewModal.setPermissionToggle(forKey: "Location")
        default:
            break
        }
        
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        passwordView.textField.resignFirstResponder()
        }
    
    func openAppSettings() {
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettingsURL) {
                UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func configure(section: Int,data:String ) {
        if section == 0 {
//            passwordView.edgesToSuperview(excluding: [.bottom])
//            passwordView.height(72)
            switchView.isHidden = true
            passwordView.titleLabel.text = data
            passwordView.textField.attributedPlaceholder = NSAttributedString(string: "******", attributes: passwordView.attributes)
        } else if section == 1 {
//            switchView.edgesToSuperview(excluding: [.bottom])
//            switchView.height(72)
            switchView.titleLabel.text = data
            setToggles(data: data)
            passwordView.isHidden = true
        }
    }
    
    func setToggles(data: String) {
        switch data {
        case "Camera":
            self.viewModal.checkCameraPermission()
            switchView.switchView.isOn = viewModal.setPermissionToggle(forKey: "CameraPermission")
        case "Photo Library":
            self.viewModal.checkLibraryPermission()
            switchView.switchView.isOn = viewModal.setPermissionToggle(forKey: "LibraryPermission")
        case "Location":
            self.viewModal.checkLocationPermission()
            switchView.switchView.isOn = viewModal.setPermissionToggle(forKey: "LocationPermission")
        default:
            break
        }
    }
    
    private func setupView() {
        contentView.addGestureRecognizer(tapGesture)
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


extension SecurityCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if passwordView.titleLabel.text == "New Password" {
            textField.resignFirstResponder() // Klavyeyi kapat
            if let text = textField.text {
                delegate?.textFieldFunctions(text: text, number: 1)
            }
            return true
        } else {
           textField.resignFirstResponder() // Klavyeyi kapat
           if let text = textField.text {
               delegate?.textFieldFunctions(text: text, number:2 )
           }
           return true
       }
    }
}
