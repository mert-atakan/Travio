//
//  CustomSwitchView.swift
//  AccessTokenApi
//
//  Created by Kullanici on 29.08.2023.
//

import UIKit
import TinyConstraints
class CustomSwitchView: UIView {
    
     lazy var titleLabel: UILabel = {
        let l = UILabel()
         l.font = Font.poppins(fontType: .medium, size: 14).font
        l.textColor = Color.systemblack.chooseColor
        return l
    }()
    
     lazy var switchView: UISwitch = {
        let s = UISwitch()
        return s
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    override func layoutSubviews() {
        self.roundCornersWithShadow( [.topLeft, .topRight, .bottomLeft], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = Color.white.chooseColor
        self.addSubviews(titleLabel,switchView)
        setupLayout()
    }
    
    private func setupLayout() {
        titleLabel.edgesToSuperview( insets: .top(25) + .left(16) + .bottom(27) + .right(200))

        switchView.edgesToSuperview( insets: .top(20) + .left(275) + .bottom(22) + .right(10))
    }

}
