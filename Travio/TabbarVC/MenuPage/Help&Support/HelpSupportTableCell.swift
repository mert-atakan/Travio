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
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        stackView.backgroundColor = Color.white.chooseColor
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
        topLabel.font = Font.poppins(fontType: .medium, size: 14).font
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
        botLabel.font = Font.poppins(fontType: .light, size: 10).font
        botLabel.numberOfLines = 0
        botLabel.translatesAutoresizingMaskIntoConstraints = false
        return botLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        cornerShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cornerShadows() {
        layoutIfNeeded()
        stackView.roundCornersWithShadow( [.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    func set(_ model: CellDataModel) {
        topLabel.text = model.title
        botLabel.text = model.description
        extendView.isHidden = !model.isExpanded
        buttonImageView.image = model.buttonImage
    }
    
    
    func setupView() {
        contentView.backgroundColor = Color.systemWhite.chooseColor
        contentView.addSubviews(stackView)
        stackView.addArrangedSubviews(topStackView, extendView)
        topStackView.addArrangedSubviews(topLabel, buttonImageView)
        extendView.addSubview(botLabel)
        setupLayout()
    }
    
    func setupLayout() {
        stackView.top(to: contentView, offset:6)
        stackView.bottom(to: contentView, offset:-6)
        stackView.leading(to: contentView, offset: 24)
        stackView.trailing(to: contentView,offset: -24)
        
        topLabel.edges(to: topStackView, excluding: .none, insets: .left(12) + .top(16) + .bottom(15) + .right(46))
        
        buttonImageView.height(10)
        buttonImageView.width(7)
        buttonImageView.leadingToTrailing(of: topLabel, offset: 12)
        buttonImageView.centerY(to: topLabel)
        
        botLabel.top(to: extendView, offset: 8)
        botLabel.bottom(to: extendView, offset: -8)
        botLabel.leading(to: extendView)
        botLabel.trailing(to: extendView, offset: -16)
    }

}



