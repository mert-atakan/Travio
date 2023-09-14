//
//  EditProfileVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 29.08.2023.
//

import UIKit
import TinyConstraints
import Kingfisher
import NVActivityIndicatorView
class EditProfileVC: UIViewController {
    
    let viewModal = EditProfileVM()
    
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    private lazy var dissmissButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "dismissButton"), for: .normal)
        button.addTarget(self, action: #selector(dissmissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.semibold32.chooseFont
        label.textColor = Color.white.chooseColor
        label.text = "Edit Profile"
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.systemWhite.chooseColor
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFill
        return profileImage
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Photo", for: .normal)
        button.setTitleColor(Color.systemBlue.chooseColor, for: .normal)
        button.titleLabel?.font = Font.regular12.chooseFont
        button.addTarget(self, action: #selector(changePhotoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.semibold24.chooseFont
        label.textColor = Color.systemblack.chooseColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateView: InfoCustomView = {
        let view = InfoCustomView()
        view.layer.cornerRadius = 16
        view.backgroundColor = Color.white.chooseColor
        view.imageView.image = UIImage(named: "dateIcon")
        return view
    }()
    
    private lazy var roleView: InfoCustomView = {
        let view = InfoCustomView()
        view.layer.cornerRadius = 16
        view.backgroundColor = Color.white.chooseColor
        view.imageView.image = UIImage(named: "positionIcon")
        view.label.text = "Admin"
        return view
    }()
    
    private lazy var fullNameView: CustomView = {
        let view = CustomView()
        view.titleLabel.text = "Full Name"
        view.textField.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: view.attributes)
        return view
    }()
    
    private lazy var emailView: CustomView = {
        let view = CustomView()
        view.titleLabel.text = "Email"
        view.textField.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: view.attributes)
        return view
    }()
    
    private lazy var saveButton: CustomButton = {
        let button = CustomButton()
        button.layer.cornerRadius = 16
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initVM()
    }
    
    override func viewDidLayoutSubviews() {
        containerView.roundCorners(corners: [.topLeft], radius: 80)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = true
    }
    
    @objc func dissmissButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func changePhotoButtonTapped() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func saveButtonTapped() {
        guard let name = fullNameView.textField.text, let email = emailView.textField.text else {return}
        let imageUrl = viewModal.getImageUrl()
        let body = ["full_name":name, "email": email, "pp_url": imageUrl]
        viewModal.editProfile(body: body)
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
        viewModal.getUserInfo()
        viewModal.configureUserInfo = {user in
            self.fullNameLabel.text = user.full_name
            self.roleView.label.text = user.role
           self.dateView.label.text = self.dateFormat(date: user.created_at)
            self.fullNameView.textField.text = user.full_name
            self.emailView.textField.text = user.email
            if user.pp_url != "" {
                let url = URL(string: user.pp_url)
                self.profileImage.kf.setImage(with: url)
            } else {
                self.profileImage.image = UIImage(systemName: "person.fill")
            }
           
        }
    }
    
    func dateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatType.longFormat.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = FormatType.dayMonthYear.rawValue
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return ""
        }
    }
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.systemGreen.chooseColor
        containerView.addSubViews(profileImage, fullNameLabel, changePhotoButton, dateView, roleView, fullNameView, emailView, saveButton)
        self.view.addSubViews(dissmissButton, headerLabel, containerView , activity)
        setupLayout()
    }
    
    private func setupLayout() {
        dissmissButton.edgesToSuperview(excluding: [.bottom,.left], insets: .top(24) + .right(24), usingSafeArea: true)
        dissmissButton.height(20)
        dissmissButton.width(20)
        
        headerLabel.leadingToSuperview(offset: 24)
        headerLabel.topToSuperview(offset: 12, usingSafeArea: true)
        headerLabel.height(48)
        
        containerView.topToBottom(of: headerLabel, offset: 54)
        containerView.leadingToSuperview()
        containerView.trailingToSuperview()
        containerView.bottomToSuperview()
        
        profileImage.topToSuperview(offset: 24)
        profileImage.centerXToSuperview()
        profileImage.height(120)
        profileImage.width(120)
        
        changePhotoButton.topToBottom(of: profileImage, offset: 7)
        changePhotoButton.centerXToSuperview()
        changePhotoButton.height(18)
        changePhotoButton.width(86)

        fullNameLabel.topToBottom(of: changePhotoButton, offset: 7)
        fullNameLabel.centerXToSuperview()

        dateView.topToBottom(of: fullNameLabel, offset: 21)
        dateView.leftToSuperview(offset: 24)
        dateView.height(52)
        dateView.width(164)

        roleView.leftToRight(of: dateView, offset: 16)
        roleView.topToBottom(of: fullNameLabel, offset: 21)
        roleView.height(52)
        roleView.width(164)

        fullNameView.topToBottom(of: dateView, offset: 20)
        fullNameView.edgesToSuperview(excluding: [.bottom, .top], insets: .left(24) + .right(24))
        fullNameView.height(74)

        emailView.topToBottom(of: fullNameView, offset: 16)
        emailView.edgesToSuperview(excluding: [.bottom, .top], insets: .left(24) + .right(24))
        emailView.height(74)
        
        saveButton.edgesToSuperview(excluding: [.top], insets: .left(24) + .right(24) + .bottom(50))
        saveButton.height(51)
        
        activity.centerInSuperview()
        activity.height(50)
        activity.width(50)
    }

}

extension EditProfileVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage?  {
            guard let image = image else {return}
            profileImage.image = image
            guard let data = image.jpegData(compressionQuality: 0.5) else {return}
            let dataArray = [data]
            
            viewModal.uploadPhoto(images: dataArray )
        }

        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
