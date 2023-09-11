//
//  TableViewCell.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 29.08.2023.
//

import Foundation
import UIKit
import TinyConstraints

class CustomCvCell:UICollectionViewCell {
    
    private lazy var shadowView:UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0) // Gölge yönü ve boyutu
        shadowView.layer.shadowOpacity = 0.2 // Gölge opaklığı
        shadowView.layer.shadowRadius = 4 // Gölge yarıçapı
        shadowView.layer.cornerRadius = 12 // Hücrenin köşe yuvarlama miktarı
        shadowView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return shadowView
    }()
    
    
    private lazy var cellsLeftImageView:UIImageView = {
       let cellsLeftImage = UIImageView()
        
        
        return cellsLeftImage
    }()
    
    private lazy var cellsLabel:UILabel = {
      let cellLabel = UILabel()
        cellLabel.font = Font.regular14.chooseFont
        cellLabel.textColor = Color.systemblack.chooseColor
        
        return cellLabel
    }()
    
    private lazy var cellsRightImageView:UIImageView = {
       let cellsRightImage = UIImageView()
        cellsRightImage.contentMode = .scaleAspectFit
        return cellsRightImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            setupView()
        }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cellLeftImage:UIImage, cellLabel:String, cellRightImage:UIImage) {
        
        cellsLeftImageView.image = cellLeftImage
        cellsLabel.text = cellLabel
        cellsRightImageView.image = cellRightImage
    }
    
    
    func setupView() {
        contentView.addSubview(shadowView)
        shadowView.addSubviews(cellsLeftImageView, cellsLabel, cellsRightImageView)
        setupLayout()
    }
    
    func setupLayout() {
        
        shadowView.topToSuperview(offset:3)
        shadowView.leadingToSuperview(offset:3)
        shadowView.trailingToSuperview(offset:-3)
        shadowView.bottomToSuperview(offset:-3)
        
        cellsLeftImageView.leadingToSuperview(offset:16)
        cellsLeftImageView.height(17.5)
        cellsLeftImageView.width(20)
        cellsLeftImageView.centerYToSuperview()
        
        cellsLabel.leadingToTrailing(of: cellsLeftImageView, offset: 9.4)
        cellsLabel.centerY(to: cellsLeftImageView)
        
        cellsRightImageView.height(17.5)
        cellsRightImageView.width(20)
        cellsRightImageView.centerY(to: cellsLabel)
        cellsRightImageView.edgesToSuperview(excluding: [.left, .bottom, .top], insets: .right(13))
    }
    
}
