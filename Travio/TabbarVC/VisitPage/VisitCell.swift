//
//  VisitCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher
class VisitCell: UITableViewCell {
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "visitWhite")
        return iv
    }()
    
    private lazy var cityLbl: UILabel = {
        let l = UILabel()
        l.font = Font.regular16.chooseFont
        l.textColor = Color.white.chooseColor
        return l
    }()
    
    private lazy var titleLbl: UILabel = {
        let l = UILabel()
        l.font = Font.bold24.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Amsterdam"
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    
    func configure(item: PlaceItem) {
        
        imageview.layoutIfNeeded()
        imageview.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
        titleLbl.text = item.title
        cityLbl.text = item.place
        guard let safeUrl = item.cover_image_url else {return}
        let url = URL(string: safeUrl)
        imageview.kf.setImage(with: url)
        imageview.kf.indicatorType = .activity
        
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.addSubViews(imageview)
        imageview.addSubViews(titleLbl,iconView,cityLbl)
        setupLayout()
    }
    
    private func setupLayout() {
        imageview.edgesToSuperview(insets: .bottom(16) + .right(22) + .left(22))
        
        iconView.edgesToSuperview(excluding: [.top,.right], insets: .bottom(8) + .left(10))
        iconView.height(20)
        iconView.width(15)
        
        cityLbl.height(24)
        cityLbl.rightToSuperview(offset: -10)
        cityLbl.bottomToSuperview(offset: -8)
        cityLbl.leftToRight(of: iconView, offset: 6)
        
        titleLbl.left(to: iconView)
        titleLbl.bottomToTop(of: iconView, offset: 2)
        titleLbl.height(45)
        titleLbl.rightToSuperview(offset: -10)
    }
}
