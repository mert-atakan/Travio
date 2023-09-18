
import Foundation
import UIKit
import TinyConstraints

class SeeAllPlacesCustomCell:UICollectionViewCell {
    
    
    private lazy var cellImage:UIImageView = {
        let cellImage = UIImageView()
        cellImage.contentMode = .scaleToFill
        return cellImage
    }()
    
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.font = Font.poppins(fontType: .semibold, size: 24).font
        label.textColor = .black
        return label
    }()
    
    private lazy var cityNameLabel:UILabel = {
        let label = UILabel()
        label.font = Font.poppins(fontType: .regular, size: 14).font
        label.textColor = .black
        return label
    }()
    
    private lazy var locationSymbolImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "visit")?.withTintColor(.black)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    override func layoutSubviews() {
        addShadowRadius()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .white
        self.addSubviews(cellImage, nameLabel, locationSymbolImage, cityNameLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        
        cellImage.edgesToSuperview(excluding: [.right])
        cellImage.width(90)
        cellImage.height(90)
        
        nameLabel.leadingToTrailing(of: cellImage, offset: 8)
        nameLabel.topToSuperview(offset:16)
        nameLabel.trailingToSuperview(offset:16)
        
        locationSymbolImage.leadingToTrailing(of: cellImage, offset: 8)
        locationSymbolImage.topToBottom(of: nameLabel, offset: 4)
        locationSymbolImage.height(12)
        locationSymbolImage.width(9)
        
        cityNameLabel.topToBottom(of: nameLabel)
        cityNameLabel.leadingToTrailing(of: locationSymbolImage, offset: 6)
    }
    
    func configure(item: PlaceItem){
        
        nameLabel.text = item.title
        cityNameLabel.text = item.place
        guard let url = item.cover_image_url else {return}
        cellImage.setImage(with: URL(string: url ))
    }
    
    
    private func addShadowRadius() {
        layer.shadowColor = Color.systemgray.chooseColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 4
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    
}
