//
//  HelpSupportTableCell.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 5.09.2023.
//

import Foundation
import UIKit
import TinyConstraints

class HelpSupportTableCell:UITableViewCell {
    
//    private lazy var shadowView:UIView = {
//        let shadowView = UIView()
//        shadowView.backgroundColor = .white
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0) // Gölge yönü ve boyutu
//        shadowView.layer.shadowOpacity = 0.2 // Gölge opaklığı
//        shadowView.layer.shadowRadius = 4 // Gölge yarıçapı
//        shadowView.layer.cornerRadius = 12 // Hücrenin köşe yuvarlama miktarı
//        shadowView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
//
//        return shadowView
//    }()
    
     private lazy var stackView:UIStackView = {
       let stackView = UIStackView()
         stackView.axis = .vertical
         stackView.spacing = 8
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.distribution = .fill
         stackView.alignment = .fill
         stackView.isLayoutMarginsRelativeArrangement = true
         stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        return stackView
    }()
    
    private lazy var topStackView:UIStackView = {
        let topStackView = UIStackView()
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.distribution = .fill
        topStackView.alignment = .center
        topStackView.spacing = 8
        
        return topStackView
    }()
    
    private lazy var topLabel:UILabel = {
        let topLabel = UILabel()
        topLabel.textColor = Color.systemblack.chooseColor
        topLabel.font = Font.semibold14.chooseFont
        topLabel.numberOfLines = 0
        topLabel.lineBreakMode = .byWordWrapping
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        return topLabel
    }()
    
    private lazy var buttonImageView:UIImageView = {
       let buttonImageView = UIImageView()
        let buttonImage = UIImage(named: "helpAndSupportImage.png")
        buttonImageView.image = buttonImage
        buttonImageView.contentMode = .scaleAspectFit
//        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        return buttonImageView
    }()
    
    private lazy var extendView:UIView = {
        let extendView = UIView()
        extendView.translatesAutoresizingMaskIntoConstraints = false
        extendView.isHidden = true
        return extendView
    }()
    
    private lazy var botLabel:UILabel = {
       let botLabel = UILabel()
        botLabel.textColor = Color.systemblack.chooseColor
        botLabel.font = Font.regular10.chooseFont
        botLabel.numberOfLines = 0
        botLabel.translatesAutoresizingMaskIntoConstraints = false
        return botLabel
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ model: CellDataModel) {
            topLabel.text = model.title
            botLabel.text = model.description
            extendView.isHidden = !model.isExpanded
        buttonImageView.image = model.buttonImage
        }
    
    
    func setupView() {
        contentView.addSubviews(stackView)
        stackView.addArrangedSubviews(topStackView, extendView)
        topStackView.addArrangedSubviews(topLabel, buttonImageView)
        extendView.addSubview(botLabel)
        setupLayout()
        }
    
    func setupLayout() {
        
//        shadowView.topToSuperview(offset:3)
//        shadowView.leadingToSuperview(offset:3)
//        shadowView.trailingToSuperview(offset:3)
//        shadowView.bottomToSuperview(offset:-3)
        
        stackView.top(to: contentView)
        stackView.bottom(to: contentView)
        stackView.leading(to: contentView)
        stackView.trailing(to: contentView)
        
        topLabel.edges(to: topStackView, excluding: .none, insets: .left(12) + .top(16) + .bottom(4) + .right(46))
    
        buttonImageView.height(10)
        buttonImageView.width(7)
        buttonImageView.leadingToTrailing(of: topLabel, offset: 12)
        buttonImageView.centerY(to: topLabel)
        
        
        botLabel.top(to: extendView, offset: 8)
        botLabel.bottom(to: extendView, offset: -8)
        botLabel.leading(to: extendView)
        botLabel.trailing(to: extendView, offset: -16)
    }
    
    
//    private func addShadowRadius() {
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 0)
//        layer.shadowOpacity = 0.25
//        layer.shadowRadius = 4
//        clipsToBounds = false
//        layer.cornerRadius = 16
//        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
//    }
    

    
}

//extension UICollectionViewCell {
//    
//    func radiusWithShadow(corners:UIRectCorner) {
//        
//        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: corners, cornerRadii: CGSize(width: 16, height: 16))
//        rectanglePath.close()
//        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowOffset = CGSize(width: 0, height: 0)

