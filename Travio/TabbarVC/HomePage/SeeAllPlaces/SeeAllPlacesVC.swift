//
//  PopularPlacesVC.swift
//  AccessTokenApi
//
//  Created by Mert Atakan on 1.09.2023.
//

import UIKit
import TinyConstraints
import Kingfisher

class SeeAllPlacesVC: UIViewController {
    
    var fromWhere:String!
    let seeAllPlacesVM = SeeAllPlacesVM()
    var buttonToggle:Bool = false
    
    private lazy var backButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.semibold32.chooseFont
        label.textColor = Color.white.chooseColor
        return label
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Color.systemWhite.chooseColor
        return containerView
    }()
    
    private lazy var sortButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ascending"), for: .normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 70, left: 24, bottom: 0, right: 24)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SeeAllPlacesCustomCell.self, forCellWithReuseIdentifier: "PopularPlacesCustomCell")
        return collectionView
    }()
    
    override func viewWillLayoutSubviews() {
        containerView.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setupViews()
    }
    
    private func setupViews() {
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Color.systemGreen.chooseColor
        
        
        self.containerView.addSubviews(collectionView, sortButton)
        
        view.addSubviews(backButton,
                         headerLabel,
                         containerView)
        
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        backButton.edgesToSuperview(excluding: [.bottom, .right], insets: .left(24) + .top(32), usingSafeArea: true)
        backButton.height(22)
        backButton.width(24)
        
        headerLabel.topToSuperview(offset:20, usingSafeArea: true)
        headerLabel.leadingToTrailing(of: backButton, offset: 24)
        
        containerView.topToBottom(of: headerLabel, offset: 60)
        containerView.edgesToSuperview(excluding: [.top])
        
        sortButton.edgesToSuperview(excluding: [.left, .bottom], insets: .top(24) + .right(24))
        sortButton.height(22)
        sortButton.width(25)
        
        collectionView.edgesToSuperview()
        
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sortButtonTapped() {
                
        buttonToggle.toggle()
        if buttonToggle {
            sortButton.setImage(UIImage(named: "descending"), for: .normal)
            seeAllPlacesVM.sortArray(ascending: true)
        } else {
            sortButton.setImage(UIImage(named: "ascending"), for: .normal)
            seeAllPlacesVM.sortArray(ascending: false)
        }
        self.collectionView.reloadData()
    }
    
    private func getData() {

        seeAllPlacesVM.place = fromWhere
        
        seeAllPlacesVM.getPlaces() { status, message in
            if status {
                self.headerLabel.text = self.seeAllPlacesVM.setTitle()
                self.collectionView.reloadData()
            } else  {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
           
        }
    }
}

extension SeeAllPlacesVC:UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (collectionView.frame.width-48), height: 90)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        let item = seeAllPlacesVM.getPlacesIndex(index: indexPath.row)
        detailVC.placeId = item.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}



extension SeeAllPlacesVC:UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seeAllPlacesVM.countOfPlaces()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularPlacesCustomCell", for: indexPath) as? SeeAllPlacesCustomCell else { return UICollectionViewCell() }
        

        let item = seeAllPlacesVM.getPlacesIndex(index: indexPath.row)
        cell.configure(item: item)
        return cell
    }
    
    
}
