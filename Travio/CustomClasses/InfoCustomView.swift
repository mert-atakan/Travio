//
//  InfoCustomView.swift
//  AccessTokenApi
//
//  Created by Kullanici on 31.08.2023.
//

import UIKit
import TinyConstraints

class InfoCustomView: UIView {
    
     lazy var label: UILabel = {
        let label = UILabel()
        label.font = Font.poppins(fontType: .medium, size: 12).font
        label.textColor = Color.systemblack.chooseColor
        return label
    }()
    
     lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        self.addSubviews(label,imageView)
        setupLayout()
    }
    
    
    private func setupLayout() {
        imageView.leadingToSuperview(offset:16)
        imageView.centerYToSuperview()
        imageView.height(12)
        imageView.width(20)
        
        label.leadingToTrailing(of: imageView, offset: 8)
        label.centerYToSuperview()
        label.trailingToSuperview(offset: 8)
    }

}
