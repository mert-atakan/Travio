//
//  AddTravelCollectionCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 23.08.2023.
//

import UIKit
import TinyConstraints
class AddTravelCollectionCell: UICollectionViewCell {
    
    private lazy var defaultImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "addPhoto")
        iv.backgroundColor = Color.white.chooseColor
        return iv
    }()
    
    private lazy var choosenImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.addCornerRadius(corners: [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner], radius: 16)
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    override func layoutSubviews() {
        self.contentView.roundCornersWithShadow([.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        choosenImageview.image = image
    }
    
    private func setupView() {
        self.contentView.backgroundColor = Color.white.chooseColor
        self.contentView.addSubViews(defaultImageview,choosenImageview)
        
        setupLayout()
    }
    private func setupLayout() {
        defaultImageview.centerInSuperview()
        defaultImageview.width(62)
        defaultImageview.height(58)
        
        choosenImageview.edgesToSuperview()
    }
    
}
