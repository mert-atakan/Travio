//
//  AddTravelVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 19.08.2023.
//

import UIKit
import TinyConstraints
import CoreLocation
class AddTravelVC: UIViewController{
    
    var imageClosure: (()->())?
    
    let viewModal = AddTravelVM()
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    var currentIndex: IndexPath?
    var delegate: Reloader?
    var tempImage = [UIImage()] {
        didSet {
            guard let imageClosure = imageClosure else { return}
            imageClosure()
        }
    }
    
    var reloadMapVC: (()->())?
    
    private lazy var placeView: CustomView = {
        let v = CustomView()
        v.textField.attributedPlaceholder = NSAttributedString(string: "date", attributes: v.attributes)
        v.titleLabel.text = "Place Name"
        return v
    }()
    
    private lazy var descView: CustomView = {
        let v = CustomView()
        v.textField.attributedPlaceholder = NSAttributedString(string: "Lorem ipsum blah blah", attributes: v.attributes)
        v.titleLabel.text = "Visit Description"
        return v
    }()
    
    private lazy var countryView: CustomView = {
        let v = CustomView()
        v.titleLabel.text = "City, Country"
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        cv.register(AddTravelCollectionCell.self, forCellWithReuseIdentifier: "addTravel")
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.backgroundColor = .clear
        return cv
    }()

    
        private lazy var addBtn: CustomButton = {
            let btn = CustomButton()
            btn.setTitle("Add Place", for: .normal)
            btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
            return btn
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        guard let latitude = latitude, let longitude = longitude else { return}

        getCityAndCountryName(latitude: latitude, longitude: longitude)
        
        iniVM()
        
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.roundCornersWithShadow([.topLeft, .bottomLeft], radius: 16)
    }
    
    @objc func addTapped() {
        // resimleri secerken tempImage arrayine image tipinde attık. CollectionCell'lerini doldurabilmek için. burada da tek satır kodla hızlıca data tipinde bir array'e dönüştürdük.  ve uploadImage fonksiyonuna data tipinde atmış olduk.
        let imageData = tempImage.compactMap { $0.jpegData(compressionQuality:0.5)}
        
        viewModal.uploadImage(images: imageData)
        var body = [String:Any]()
        guard let place = countryView.textField.text, let title = placeView.textField.text, let desc = descView.textField.text else {return}

        body["place"] = place
        body["title"] = title
        body["description"] = desc
        body["cover_image_url"] = "https://i2.milimaj.com/i/milliyet/75/0x0/5c8e330a45d2a097ac0f94ae.jpg"
        body["latitude"] = latitude
        body["longitude"] = longitude

        viewModal.body = body
        
    }
    
    func iniVM() {
        viewModal.dismiss = {
            self.dismiss(animated: true) {
                self.delegate?.reloadMap()
            }
        }
    }
    
    func getCityAndCountryName(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
            } else if let placemark = placemarks?.first {
                
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                self.countryView.textField.text = city + ", " + country
               
            } else {
            }
        }
    }
    private func setupView() {
        view.backgroundColor = Color.systemWhite.chooseColor
        view.addSubViews(placeView,descView,countryView,addBtn,collectionView)
        setupLayout()
    }
    
    private func setupLayout() {
        placeView.edgesToSuperview(excluding: [.bottom], insets: .top(40) + .left(23) + .right(23))
        placeView.height(74)
        
        descView.topToBottom(of: placeView, offset: 16)
        descView.edgesToSuperview(excluding: [.bottom,.top], insets: .left(23) + .right(23))
        descView.height(215)
        
        countryView.topToBottom(of: descView, offset: 16)
        countryView.edgesToSuperview(excluding: [.bottom,.top], insets: .left(23) + .right(23))
        countryView.height(74)
        
        collectionView.topToBottom(of: countryView, offset: 16)
        collectionView.bottomToTop(of: addBtn, offset: -16)
        collectionView.edgesToSuperview(excluding: [.bottom,.top],insets: .left(8) + .right(0))
        
        addBtn.edgesToSuperview(excluding: [.top], insets: .bottom(24) + .right(24) + .left(24))
        addBtn.height(54)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Attention", message: "You can upload up to 3 pictures to gallery.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }



}


extension AddTravelVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        currentIndex = indexPath
        if tempImage.count < 4 {
            present(vc, animated: true)
        } else {
            showAlert()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {// size vermemiz gereikyor çünkkü ve genişlik ve yükseklik değerlerinie ihiyacımız var.
        let size = CGSize(width: 342, height: (collectionView.frame.height))
        return size
    }
}

extension AddTravelVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addTravel", for: indexPath) as? AddTravelCollectionCell else {return UICollectionViewCell()}

        return cell
    }
}


extension AddTravelVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage?  {
            guard let image = image else {return}
            let data = image.jpegData(compressionQuality: 0.5)
            tempImage.append(image)
            
            guard let cell = collectionView.cellForItem(at: currentIndex!) as? AddTravelCollectionCell else { return }
            cell.configure(image: tempImage.last!)
            
            

        }

        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
