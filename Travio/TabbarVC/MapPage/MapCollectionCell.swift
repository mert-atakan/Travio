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
    
    private lazy var visitedView: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemGreen.chooseColor
        return v
    }()
    
    private lazy var visitedIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "visited")
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
        l.font = Font.bold24.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Amsterdam"
        return l
    }()
    
    private lazy var cityLbl: UILabel = {
        let l = UILabel()
        l.font = Font.regular16.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Amsterdam"
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.roundCorners(corners: [.topLeft , .topRight, .bottomLeft ], radius: 16)
        self.visitedView.roundCorners(corners: [.topRight, .bottomLeft], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: PlaceItem) {
        guard let itemUrl = item.cover_image_url else {return}
        let url = URL(string: itemUrl)
        imageview.kf.setImage(with: url)
        
        cityLbl.text = item.place
        titleLbl.text = item.title
    }
    
    
    private func setupView() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubViews(imageview)
        imageview.addSubViews(cityLbl,titleLbl,iconView,visitedView)
        visitedView.addSubViews(visitedIcon)
        
        setupLayout()
    }
    private func setupLayout() {
        imageview.edgesToSuperview()
    
        iconView.edgesToSuperview(excluding: [.top, .right], insets: .left(22) + .bottom(14))
        iconView.height(12)
        iconView.width(9)
        
        titleLbl.edgesToSuperview(excluding: [.bottom,.right], insets: .left(22) + .top(113))
        titleLbl.height(36)
        titleLbl.width(200)
        
        iconView.edgesToSuperview(excluding: [.top, .right], insets: .left(22) + .bottom(14))
        iconView.height(12)
        iconView.width(9)
        
        cityLbl.topToBottom(of: titleLbl)
        cityLbl.leftToRight(of: iconView,offset: 6)
        cityLbl.height(21)
        cityLbl.width(200)
        
        visitedView.edgesToSuperview(excluding: [.left, .bottom])
        visitedView.height(40)
        visitedView.width(45)
        
        visitedIcon.centerInSuperview()
        visitedIcon.height(20)
        visitedIcon.width(25)
    }
}
