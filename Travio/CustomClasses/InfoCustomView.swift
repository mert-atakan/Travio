//
//  InfoCustomView.swift
//  AccessTokenApi
//
//  Created by Kullanici on 31.08.2023.
//

import UIKit
import TinyConstraints

class InfoCustomView: UIView {


    
     lazy var Lbl: UILabel = {
        let l = UILabel()
        l.font = Font.semibold12.chooseFont
        l.textColor = Color.systemblack.chooseColor
        return l
    }()
    
     lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    override func layoutSubviews() {
        self.roundCornersWithShadow([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = Color.white.chooseColor
        self.addSubviews(Lbl,imageview)
        setupLayout()
    }
    private func setupLayout() {
        imageview.edgesToSuperview(excluding: [.right], insets: .top(20) + .left(16) + .bottom(20))
        
        Lbl.edgesToSuperview(excluding: [.left, .right], insets: .top(18) + .bottom(16))
        Lbl.leftToRight(of: imageview, offset: 8)
        
    }

}
