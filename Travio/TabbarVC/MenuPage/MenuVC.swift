//
//  MenuVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

class MenuVC: UIViewController {
    
    let menuVM = MenuVM()
    
    private lazy var headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textColor = .white
        label.font = UIFont(name: Font.semibold32.chooseFont.fontName, size: Font.semibold32.chooseFont.pointSize)
        return label
    }()
    
    private lazy var logoutButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logoutButton"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = Color.systemWhite.chooseColor
        return contentView
    }()
    
    private lazy var profileImage:UIImageView = {
        let profileImage = UIImageView(frame: CGRect(x: 135, y: 149, width: 120, height: 120))
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.kf.setImage(with: URL(string: "https://cdn.britannica.com/48/194248-050-4EE825CF/Bruce-Willis-2013.jpg"))
        return profileImage
    }()
    
    private lazy var fullNameLabel:CustomLabel = {
        let fullName = CustomLabel()
        fullName.text = "Bruce Wills"
        fullName.font = Font.semibold16.chooseFont
        return fullName
    }()
    
    private lazy var editProfileButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0, green: 0.7960889935, blue: 0.9382097721, alpha: 1), for: .normal)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = Font.regular12.chooseFont
        button.addTarget(self, action: #selector(editProfilePage), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(CustomCvCell.self, forCellWithReuseIdentifier: "CustomCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = Color.systemGreen.chooseColor
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        contentView.roundCorners(corners: .topLeft, radius: 80)
    }
    
    func setupView() {
        
        self.view.addSubviews(logoutButton,contentView,headerLabel)
        contentView.addSubviews(profileImage, fullNameLabel, editProfileButton, collectionView)
        setupLayout()
    }

    func setupLayout() {
        
        headerLabel.edgesToSuperview(excluding: [.bottom, .right], insets: .left(20) + .top(24), usingSafeArea: true)
        
        logoutButton.edgesToSuperview(excluding: [.left, .bottom], insets: .top(34) + .right(24), usingSafeArea: true)
        logoutButton.height(30)
        logoutButton.width(30)
        
        contentView.edgesToSuperview(excluding: [.top])
        contentView.topToBottom(of: headerLabel, offset: 54)
        
        profileImage.top(to: contentView, offset: 24)
        profileImage.height(120)
        profileImage.width(120)
        profileImage.centerXToSuperview()
        
        fullNameLabel.topToBottom(of: profileImage, offset: 8)
        fullNameLabel.centerXToSuperview()
        
        editProfileButton.topToBottom(of: fullNameLabel)
        editProfileButton.centerXToSuperview()
        editProfileButton.height(18)
        editProfileButton.width(62)
        
        collectionView.topToBottom(of: editProfileButton, offset: 6)
        collectionView.bottomToSuperview(usingSafeArea: true)
        collectionView.leftToSuperview()
        collectionView.trailingToSuperview()
    }
    
    @objc func editProfilePage() {
        let vc = EditProfileVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}

extension MenuVC:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuVM.collectionViewCellsLabels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCvCell else  {return UICollectionViewCell()}
        
        let leftImagesAtRow = menuVM.getLeftImageForRow(indexpath: indexPath)
        let labelsAtRow = menuVM.getLabelForRow(indexpath: indexPath)
        let rightImagesAtRow = menuVM.getRightImageForRow(indexpath: indexPath)
        
        cell.configure(cellLeftImage: leftImagesAtRow, cellLabel: labelsAtRow, cellRightImage: rightImagesAtRow)
        
        return cell
    }
    
    
}
extension MenuVC:UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let labelsAtRow = menuVM.getLabelForRow(indexpath: indexPath)
        
        switch labelsAtRow {
        case "Security Settings":
            let nav = SecuritySettingsVC()
            self.present(nav, animated: true)
        case "Help&Support":
            self.present(HelpAndSupportVC(), animated: true)
        case "About":
            self.present(AboutUsVC(), animated: true)
        default: return
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-32, height:54)
        }
    
}

