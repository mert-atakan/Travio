//
//  AddTravelCollectionCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 23.08.2023.
//

import UIKit
import TinyConstraints
class AddTravelCollectionCell: UICollectionViewCell {
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "addPhoto")
        iv.backgroundColor = Color.white.chooseColor
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
        imageview.image = image
        imageview.edgesToSuperview()
    }
    
    private func setupView() {
        self.contentView.backgroundColor = Color.white.chooseColor
        self.contentView.addSubViews(imageview)
        
        setupLayout()
    }
    private func setupLayout() {
        imageview.centerInSuperview()
        imageview.width(62)
        imageview.height(58)
    }
    
}
