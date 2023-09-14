//
//  CustomView.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints

class CustomView: UIView {
    
    var isEmail = false
    var isUsername = false
    var isPassword = false
    
    let attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Color.systemgray.chooseColor,
        .font: Font.poppins(fontType: .regular, size: 12).font as Any
    ]
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 3
        label.font = Font.poppins(fontType: .medium, size: 14).font
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = Font.poppins(fontType: .light, size: 12).font
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.delegate = self
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
    }
    
    override func layoutSubviews() {
        self.roundCornersWithShadow([.topLeft, .topRight, .bottomLeft], radius: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = Color.white.chooseColor
        self.addSubViews(titleLabel,textField)
        setupLayout()
    }
    private func setupLayout() {
        
        titleLabel.edgesToSuperview(excluding: [.bottom], insets: .left(12) + .top(8))
        
        textField.topToBottom(of: titleLabel,offset: 8)
        textField.leadingToSuperview(offset:12)
        textField.trailingToSuperview(offset:12)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidUsername(_ name: String) -> Bool {
        let allowedCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
        let isAlphabetic = name.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil
        let isLengthValid = name.count >= 6
        
        if isAlphabetic && isLengthValid {
            return true
        } else {
            return false
        }
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let letterCharacterSet = NSCharacterSet.letters
        let digitCharacterSet = NSCharacterSet.decimalDigits
        
        let containsLetter = password.rangeOfCharacter(from: letterCharacterSet as CharacterSet) != nil
        let containsDigit = password.rangeOfCharacter(from: digitCharacterSet as CharacterSet) != nil
        
        let isLengthValid = password.count >= 6
        
        return containsLetter && containsDigit && isLengthValid
    }
    
}


extension CustomView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textField {
            
            let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            isEmail = isValidEmail(updatedText)
            isUsername = isValidUsername(updatedText)
            isPassword = isValidPassword(updatedText)
            
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Klavyeyi kapat
        return true
    }
}
