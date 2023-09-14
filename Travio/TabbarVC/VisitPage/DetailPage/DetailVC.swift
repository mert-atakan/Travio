//
//  DetailVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import UIKit
import TinyConstraints
import MapKit
class DetailVC: UIViewController {
    
    var placeId:String?
    
    let detailViewModal = DetailVM()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = self.view.center
        activityIndicator.backgroundColor = .white
        return activityIndicator
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: "collectionImage")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var visitedButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.systemGreen.chooseColor
        button.addTarget(self, action: #selector(visitedButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundStyle = .prominent
        pageControl.pageIndicatorTintColor = UIColor(white: 1, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.currentPage = 0
        return pageControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Color.systemWhite.chooseColor
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = Color.systemWhite.chooseColor
        return contentView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = Font.poppins(fontType: .bold, size: 30).font
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Font.poppins(fontType: .medium, size: 14).font
        return label
    }()
    
    private lazy var creatorLabel: UILabel = {
        let label = UILabel()
        label.font = Font.poppins(fontType: .regular, size: 12).font
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.backgroundColor = Color.systemWhite.chooseColor
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Font.poppins(fontType: .regular, size: 12).font
        descriptionLabel.text = " "
        guard let text = descriptionLabel.text else { return descriptionLabel}
        let attributedText = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 20
        paragraphStyle.alignment = .justified
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        descriptionLabel.attributedText = attributedText
        return descriptionLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initVM()
    }
    
    override func viewDidLayoutSubviews() {
        let height = descriptionLabel.frame.height + descriptionLabel.frame.origin.y
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
    }
    

    override func viewWillLayoutSubviews() {
        mapView.roundCorners(corners: [.topLeft, .topRight ,.bottomLeft], radius: 16)
        visitedButton.roundCorners(corners: [.topLeft, .topRight ,.bottomLeft], radius: 16)
    }
    
    private func setupView() {
        view.backgroundColor = Color.systemWhite.chooseColor
        view.addSubViews(collectionView,pageControl,visitedButton, scrollView,backButton)
        scrollView.addSubViews(contentView)
        
        contentView.addSubViews(cityLabel,dateLabel,creatorLabel,mapView,descriptionLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        
        collectionView.edgesToSuperview(excluding: [.bottom],usingSafeArea: false)
        collectionView.height(249)
        
        backButton.edgesToSuperview(excluding: [.bottom, .right], insets: .left(24) + .top(55))
        backButton.width(40)
        backButton.height(40)
        
        visitedButton.edgesToSuperview(excluding: [.left, .bottom], insets: .top(50) + .right(24), usingSafeArea: false)
        visitedButton.height(50)
        visitedButton.width(50)
        
        pageControl.bottom(to: collectionView)
        pageControl.centerXToSuperview()
        pageControl.height(44)
        
        scrollView.topToBottom(of: collectionView)
        scrollView.leftToSuperview()
        scrollView.rightToSuperview()
        scrollView.bottomToSuperview()
        
        contentView.edgesToSuperview()
        contentView.widthToSuperview()
        
        cityLabel.edgesToSuperview(excluding: [.bottom], insets: .top(24) + .left(24) + .right(24))
        
        dateLabel.topToBottom(of: cityLabel)
        dateLabel.left(to: cityLabel)
        
        creatorLabel.topToBottom(of: dateLabel)
        creatorLabel.left(to: cityLabel)
        
        
        mapView.topToBottom(of: creatorLabel, offset: 9)
        mapView.edgesToSuperview(excluding: [.top,.bottom], insets: .left(16) + .right(16))
        mapView.height(227)
        
        descriptionLabel.topToBottom(of: mapView, offset: 24)
        descriptionLabel.edgesToSuperview(excluding: [.top,.bottom], insets: .left(16) + .right(16))
        descriptionLabel.bottomToSuperview()
        
        contentView.layoutSubviews()
    }
    
    @objc func backBtnTapped() {
            self.navigationController?.popViewController(animated: true)
    }
    
    @objc func visitedButtonClicked () {
        
        detailViewModal.checkVisit { check in
            if check {
                    AlertHelper.showAlert(in: self, title: .information, message: "Are you sure you delete your visit ?", primaryButtonTitle: .no, primaryButtonAction: {
                        self.dismiss(animated: true)
                    }, secondaryButtonTitle: .yes) {
                        self.detailViewModal.deleteVisitItem { status, message in
                            if status {
                                self.visitedButton.setImage(UIImage(named: "unvisited"), for: .normal)
                                NotificationCenterManager.shared.postNotification(name: Notification.Name("visitChanged"))
                            } else {
                                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok)
                            }
                        }
                    }
                    
                
            } else {
                self.detailViewModal.postVisit { status, message in
                    if status {
                    self.visitedButton.setImage(UIImage(named: "visited"), for: .normal)
                    NotificationCenterManager.shared.postNotification(name: Notification.Name("visitChanged"))
                        AlertHelper.showAlert(in: self, title: .information, message: "Your visit was added successfully!", primaryButtonTitle: .ok)
                    } else {
                        AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil)
                    }
                }
            }
        }
    }
    
    

   
    func initVM() {
        guard let placeId = placeId else { return }
        detailViewModal.placeId = placeId
        
        detailViewModal.checkVisit { check in
            if check {
                self.visitedButton.setImage(UIImage(named: "visited"), for: .normal)
            } else {
                self.visitedButton.setImage(UIImage(named: "unvisited"), for: .normal)
            }
        }
        
        detailViewModal.getVisit { place, status, message in
            if status {
                guard let place = place else {return}
                self.configure(place: place)
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
            
        }

        detailViewModal.getGalleryItems() { status, message in
            if status {
                let count = self.detailViewModal.getNumberOfRowsInSection()
                self.pageControl.numberOfPages = count
                self.collectionView.reloadData()
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
           
        }
        
        
    }
    
    func configure(place: Place) {
        cityLabel.text = place.title
        descriptionLabel.text = place.description
        
        let date = convertDateString(place.updated_at)
        dateLabel.text = date
        
        creatorLabel.text = "added by @\(place.creator)"
        configureMapView(place: place)
    }
    
    func configureMapView(place: Place) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        annotation.title = place.title
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        
        mapView.setRegion(region, animated: false)
    }
    
    
    private func convertDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = FormatType.longFormat.rawValue
    
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "tr_TR")
            outputFormatter.dateFormat = FormatType.dayMonthYear.rawValue
    
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        }
        return nil
    }
}


extension DetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {// size vermemiz gereikyor çünkkü ve genişlik ve yükseklik değerlerinie ihiyacımız var.
        let size = CGSize(width: (collectionView.frame.width), height: 249)
        return size
    }
}

extension DetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailViewModal.getNumberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionImage", for: indexPath) as? CustomCollectionCell else {return UICollectionViewCell()}
        guard let imageItem = detailViewModal.getCellForRowAt(indexpath: indexPath) else {return UICollectionViewCell()}
        
        cell.configure(imageUrl: imageItem.image_url)
        return cell
    }
}

extension DetailVC: UIPageViewControllerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}





