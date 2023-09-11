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
    
    let viewModel = MenuVM()
    
    private lazy var InsideWhiteView: UIView = {
        let WhiteView = UIView()
        WhiteView.backgroundColor = Color.systemWhite.chooseColor
        return WhiteView
    }()
    
    private lazy var BrucesImage:UIImageView = {
        let BruceWillsImage = UIImageView(frame: CGRect(x: 135, y: 149, width: 120, height: 120))
        BruceWillsImage.layer.cornerRadius = BruceWillsImage.frame.size.width / 2
        BruceWillsImage.layer.masksToBounds = true
        BruceWillsImage.contentMode = .scaleAspectFill
        BruceWillsImage.kf.setImage(with: URL(string: "https://cdn.britannica.com/48/194248-050-4EE825CF/Bruce-Willis-2013.jpg"))
        
        return BruceWillsImage
    }()
    
    private lazy var BrucesName:CustomLabel = {
        let BrucesNameSurname = CustomLabel()
        BrucesNameSurname.text = "Bruce Wills"
        BrucesNameSurname.font = Font.semibold16.chooseFont
        
        return BrucesNameSurname
    }()
    
    private lazy var editProfileButton:UIButton = {
        let editProfile = UIButton()
        editProfile.setTitleColor(#colorLiteral(red: 0, green: 0.7960889935, blue: 0.9382097721, alpha: 1), for: .normal)
        editProfile.setTitle("Edit Profile", for: .normal)
        editProfile.titleLabel?.font = Font.regular12.chooseFont
        editProfile.addTarget(self, action: #selector(editProfilePage), for: .touchUpInside)
    
        return editProfile
    }()
    
    private lazy var collectionView:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(CustomCvCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        return cv
    }()
    
    private lazy var settingsLabel:UILabel = {
        let settings = UILabel()
        settings.text = "Settings"
        settings.textColor = .white
        settings.font = UIFont(name: Font.bold30.chooseFont.fontName, size: Font.bold30.chooseFont.pointSize)
        
        return settings
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Color.systemGreen.chooseColor
        setupView()
        
            }
    
    override func viewDidLayoutSubviews() {
        
        InsideWhiteView.roundCorners(corners: .topLeft, radius: 80)
        
    }
    
    func setupView() {
        
        self.view.addSubviews(settingsLabel,InsideWhiteView)
        InsideWhiteView.addSubviews(BrucesImage, BrucesName, editProfileButton, collectionView)
        setupLayout()
    }

    func setupLayout() {
        
        settingsLabel.edgesToSuperview(excluding: [.bottom, .right], insets: .left(20) + .top(23), usingSafeArea: true)
        settingsLabel.height(48)
        settingsLabel.width(134)
        
        InsideWhiteView.edgesToSuperview(insets: .top(170))
        InsideWhiteView.topToBottom(of: settingsLabel, offset: 54)
        
        BrucesImage.top(to: InsideWhiteView, offset: 24)
        BrucesImage.height(120)
        BrucesImage.width(120)
        BrucesImage.centerXToSuperview()
        
        BrucesName.topToBottom(of: BrucesImage, offset: 8)
        BrucesName.centerXToSuperview()
        BrucesName.height(24)
        BrucesName.width(94)
        
        editProfileButton.topToBottom(of: BrucesName)
        editProfileButton.centerXToSuperview()
        editProfileButton.height(18)
        editProfileButton.width(62)
        
        collectionView.topToBottom(of: editProfileButton, offset: 16)
        collectionView.bottomToSuperview(offset: -48)
        collectionView.leftToSuperview(offset:16)
        collectionView.trailingToSuperview(offset: -16)
    }
    
    @objc func editProfilePage() {
        
        let vc = EditProfileVC()
        self.present(vc, animated: true)
    }

}

extension MenuVC:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewCellsLabels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCvCell else  {return UICollectionViewCell()}
        
        let leftImagesAtRow = viewModel.getLeftImageForRow(indexpath: indexPath)
        let labelsAtRow = viewModel.getLabelForRow(indexpath: indexPath)
        let rightImagesAtRow = viewModel.getRightImageForRow(indexpath: indexPath)
        
        cell.configure(cellLeftImage: leftImagesAtRow, cellLabel: labelsAtRow, cellRightImage: rightImagesAtRow)
        
        return cell
    }
    
    
}
extension MenuVC:UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let labelsAtRow = viewModel.getLabelForRow(indexpath: indexPath)
        if labelsAtRow == "Security Settings" {
            let nav = SecuritySettingsVC()
            navigationController?.pushViewController(nav, animated: true)
        } else if labelsAtRow == "Help&Support" {
            self.present(HelpAndSupportVC(), animated: true)
        }
     
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 354, height:58)
        }
    
}

