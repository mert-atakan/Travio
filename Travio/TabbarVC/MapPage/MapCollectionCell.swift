//
//  MapCollectionCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 23.08.2023.
//

import UIKit
import TinyConstraints

class MapCollectionCell: UICollectionViewCell {
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named:"defaultImage")
        return iv
    }()
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "visitWhite")
        return iv
    }()
    
    private lazy var titleLbl: UILabel = {
        let l = UILabel()
        l.font = Font.poppins(fontType: .bold, size: 24).font
        l.textColor = Color.white.chooseColor
        return l
    }()
    
    private lazy var cityLbl: UILabel = {
        let l = UILabel()
        l.font = Font.poppins(fontType: .regular, size: 16).font
        l.textColor = Color.white.chooseColor
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.roundCorners(corners: [.topLeft , .topRight, .bottomLeft ], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: PlaceItem) {
        guard let itemUrl = item.cover_image_url else {return}
        let url = URL(string: itemUrl)
        imageview.setImage(with: url)
        
        cityLbl.text = item.place
        titleLbl.text = item.title
    }
    
    
    private func setupView() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubViews(imageview)
        imageview.addSubViews(cityLbl,titleLbl,iconView)
        
        setupLayout()
    }
    private func setupLayout() {
        imageview.edgesToSuperview()
        
        iconView.edgesToSuperview(excluding: [.top, .right], insets: .left(22) + .bottom(14))
        iconView.height(12)
        iconView.width(9)
        
        titleLbl.edgesToSuperview(excluding: [.bottom, .top], insets: .left(22) + .right(22))
        titleLbl.height(36)
        titleLbl.bottomToTop(of: cityLbl, offset: -6)
        
        cityLbl.leftToRight(of: iconView,offset: 6)
        cityLbl.centerY(to: iconView)
        cityLbl.height(21)
        cityLbl.rightToSuperview(offset: -22)
        
    }
}
