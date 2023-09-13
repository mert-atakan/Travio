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
    
    weak var delegate:(Reloader)?
    
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    private lazy var backButton: UIButton = {
        let iv = UIButton()
//        iv.contentMode = .scaleAspectFit
        iv.setImage(UIImage(named: "vector"), for: .normal)
        iv.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return iv
    }()
    
    private lazy var titleLbl: UILabel = {
        let l = UILabel()
        l.font = Font.bold32.chooseFont
        l.textColor = Color.white.chooseColor
        l.text = "Edit Profile"
        return l
    }()
    
    private lazy var imageview: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = iv.frame.size.width / 2
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var changePhotoBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Photo", for: .normal)
        btn.setTitleColor(Color.systemBlue.chooseColor, for: .normal)
        btn.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var nameLbl: UILabel = {
        let l = UILabel()
        l.font = Font.bold24.chooseFont
        l.textColor = Color.systemblack.chooseColor
        l.textAlignment = .center
        return l
    }()
    
    private lazy var dateView: InfoCustomView = {
        let v = InfoCustomView()
        v.layer.cornerRadius = 16
        v.backgroundColor = Color.white.chooseColor
        v.imageview.image = UIImage(named: "dateIcon")
        return v
    }()
    
    private lazy var positionView: InfoCustomView = {
        let v = InfoCustomView()
        v.layer.cornerRadius = 16
        v.backgroundColor = Color.white.chooseColor
        v.imageview.image = UIImage(named: "positionIcon")
        v.Lbl.text = "Admin"
        return v
    }()
    
    private lazy var nameView: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "Full Name"
        v.textField.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: v.attributes)
        return v
    }()
    
    private lazy var emailView: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "Email"
        v.textField.attributedPlaceholder = NSAttributedString(string: "bilge_adam", attributes: v.attributes)
        return v
    }()
    
    private lazy var saveBtn: CustomButton = {
        let btn = CustomButton()
        btn.layer.cornerRadius = 3
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initVM()
    }
    
    override func viewDidLayoutSubviews() {
        view1.roundCorners(corners: [.topLeft], radius: 80)
        imageview.layer.cornerRadius = imageview.frame.size.width / 2
        imageview.layer.masksToBounds = true
    }
    
    @objc func changePhotoTapped() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func saveTapped() {
        guard let name = nameView.textField.text, let email = emailView.textField.text else {return}
        let imageUrl = viewModal.getImageUrl()
        let body = ["full_name":name, "email": email, "pp_url": imageUrl]
        viewModal.editProfile(body: body) { status, message in
            if status {
                AlertHelper.showAlert(in: self, title: "Profile Information Updated", message: message, primaryButtonTitle: "Ok", primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            } else {
                AlertHelper.showAlert(in: self, title: "We are sorry.", message: message, primaryButtonTitle: "Ok", primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
        }
    }
    @objc func backTapped() {
        self.dismiss(animated: true)
    }
    
    func statusAlert(status:String) {
        var alert = UIAlertController()
        var action = UIAlertAction()
        if status == "success" {
            alert = UIAlertController(title: "Tebrikler", message: "Bilgileriniz başarıyla değiştirildi.", preferredStyle: .alert)
             action = UIAlertAction(title: "Tamam", style: .default) {action in
                 self.delegate?.reloadMap()
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            alert = UIAlertController(title: "Üzgünüz", message: "Bilgileriniz değiştirilemedi.", preferredStyle: .alert)
             action = UIAlertAction(title: "Tamam", style: .default)
        }
       
        alert.addAction(action)
        present(alert, animated: true)
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
                self.configure(data:user)
            } else {
                AlertHelper.showAlert(in: self, title: "We are sorry", message: message, primaryButtonTitle: "Ok", primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
           
        }
      
    }
    
    func configure(data: User) {
        self.nameLbl.text = data.full_name
        self.positionView.Lbl.text = data.role
       self.dateView.Lbl.text = self.dateFormat(date: data.created_at)
        self.nameView.textField.text = data.full_name
        self.emailView.textField.text = data.email
        if data.pp_url != "" {
            let url = URL(string: data.pp_url)
            self.imageview.kf.setImage(with: url)
        } else {
            self.imageview.image = UIImage(systemName: "person.fill")
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
        self.view.addSubViews(backButton, titleLbl, view1, imageview, changePhotoBtn, nameLbl, dateView, positionView, nameView, emailView, saveBtn, activity)
        setupLayout()
    }
    private func setupLayout() {
        backButton.edgesToSuperview(excluding: [.bottom,.right], insets: .top(32) + .left(23),usingSafeArea: true)
        backButton.height(21)
        backButton.width(24)
        
        titleLbl.edgesToSuperview(excluding: [.bottom, .left], insets: .top(19) + .right(24),usingSafeArea: true)
        titleLbl.leftToRight(of: backButton, offset: 24)
        titleLbl.height(48)
        
        view1.edgesToSuperview(excluding: [.top])
        view1.topToBottom(of: titleLbl, offset: 54)
        
        imageview.top(to: view1, offset: 24)
        imageview.edgesToSuperview(excluding: [.bottom, .top], insets: .left(135) + .right(135))
        imageview.height(120)
        imageview.width(120)
        
        changePhotoBtn.topToBottom(of: imageview, offset: 7)
        changePhotoBtn.edgesToSuperview(excluding: [.bottom, .top], insets: .left(100) + .right(100))
        changePhotoBtn.height(18)

        nameLbl.topToBottom(of: changePhotoBtn, offset: 7)
        nameLbl.edgesToSuperview(excluding: [.bottom, .top], insets: .left(50) + .right(50))
        nameLbl.height(36)

        dateView.topToBottom(of: nameLbl, offset: 21)
        dateView.leftToSuperview(offset: 24)
        dateView.height(52)
        dateView.width(164)

        positionView.leftToRight(of: dateView, offset: 16)
        positionView.topToBottom(of: nameLbl, offset: 21)
        positionView.height(52)
        positionView.width(164)

        nameView.topToBottom(of: dateView, offset: 20)
        nameView.edgesToSuperview(excluding: [.bottom, .top], insets: .left(24) + .right(24))
        nameView.height(74)

        emailView.topToBottom(of: nameView, offset: 16)
        emailView.edgesToSuperview(excluding: [.bottom, .top], insets: .left(24) + .right(24))
        emailView.height(74)
        
        saveBtn.edgesToSuperview(excluding: [.top], insets: .left(24) + .right(24) + .bottom(99))
        saveBtn.height(51)
        
        
        activity.centerInSuperview()
        activity.height(50)
        activity.width(50)
    }

}

extension EditProfileVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage?  {
            guard let image = image else {return}
            imageview.image = image
            guard let data = image.jpegData(compressionQuality: 0.5) else {return}
            let dataArray = [data]
            
            viewModal.uploadPhoto(images: dataArray) { status, message in
                if !status {
                    AlertHelper.showAlert(in: self, title: "We are sorry.", message: message, primaryButtonTitle: "Ok", primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
                }
            }
        }

        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
