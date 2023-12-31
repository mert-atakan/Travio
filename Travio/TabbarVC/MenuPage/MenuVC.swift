//
//  MenuVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher
import NVActivityIndicatorView

class MenuVC: UIViewController {
    
    let viewModal = MenuVM()
    
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    private lazy var headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textColor = .white
        label.font = Font.poppins(fontType: .semibold, size: 32).font
        return label
    }()
    
    private lazy var logoutButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logoutButton"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
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
        return profileImage
    }()
    
    private lazy var fullNameLabel:UILabel = {
        let fullName = UILabel()
        fullName.font = Font.poppins(fontType: .semibold, size: 16).font
        fullName.textAlignment = .center
        return fullName
    }()
    
    private lazy var editProfileButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0, green: 0.7960889935, blue: 0.9382097721, alpha: 1), for: .normal)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = Font.poppins(fontType: .regular, size: 12).font
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
        setupView()
        initVM()
    }
    
    override func viewDidLayoutSubviews() {
        contentView.roundCorners(corners: .topLeft, radius: 80)
    }
    
    @objc func editProfilePage() {
        let vc = EditProfileVC()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @objc func logoutTapped() {
        AlertHelper.showAlert(in: self, title: .information, message: "Do you want to logout of your account?", primaryButtonTitle: .yes, primaryButtonAction: {
            KeychainHelper.shared.delete("access-token", account: "api.Iosclass")
            let token = self.getTokenFromChain()
            self.navigationController?.pushViewController(LoginVC(), animated: true)
        }, secondaryButtonTitle: .no, secondaryButtonAction: nil)
    }
    
    func initVM() {
        viewModal.onDataFetch = { [weak self] isLoading in
        DispatchQueue.main.async {
            if isLoading {
                self?.activity.startAnimating()
            } else {
                self?.activity.stopAnimating()
            }
        }
    }
        viewModal.getUserInfo() { user, status, message in
            if status {
                guard let user = user else {return}
                self.configure(data: user)
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok)
            }
            
        }
        
    }
    
    func configure(data: User) {
        self.fullNameLabel.text = data.full_name
        if data.pp_url != "" {
            let url = URL(string: data.pp_url)
            self.profileImage.setImage(with: url)
        } else {
            self.profileImage.image = UIImage(systemName: "person.fill")
        }
    }
    
    func getTokenFromChain()->String {
        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return""}
        guard let tokenstr = String(data: token, encoding: .utf8) else {return""}
        return tokenstr
    }
    
    func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = Color.systemGreen.chooseColor
        self.view.addSubviews(logoutButton,contentView,headerLabel,activity)
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
        
        activity.centerInSuperview()
        activity.height(50)
        activity.width(50)
    }
    

}

extension MenuVC:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModal.collectionViewCellsLabels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCvCell else  {return UICollectionViewCell()}
        
        let leftImagesAtRow = viewModal.getLeftImageForRow(indexpath: indexPath)
        let labelsAtRow = viewModal.getLabelForRow(indexpath: indexPath)
        let rightImagesAtRow = viewModal.getRightImageForRow(indexpath: indexPath)
        
        cell.configure(cellLeftImage: leftImagesAtRow, cellLabel: labelsAtRow, cellRightImage: rightImagesAtRow)
        
        return cell
    }
    
    
}
extension MenuVC:UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let labelsAtRow = viewModal.getLabelForRow(indexpath: indexPath)
        
        switch labelsAtRow {
        case "Security Settings":
            self.present(SecuritySettingsVC(), animated: true)
        case "Help&Support":
            self.present(HelpAndSupportVC(), animated: true)
        case "About":
            self.present(AboutUsVC(), animated: true)
        case "Terms of Use":
            self.present(TermsOfUseVC(), animated: true)
        case "My Added Places":
            let vc = SeeAllPlacesVC()
            vc.fromWhere = "myAddedPlaces"
            navigationController?.pushViewController(vc, animated: true)
        default: return
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-32, height:54)
        }
    
}

extension MenuVC:Reloader {
    func reload() {
        viewModal.getUserInfo(){ user, status, message in
            if status {
                guard let user = user else {return}
                self.configure(data: user)
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok)
            }
           
        }
    }
}
