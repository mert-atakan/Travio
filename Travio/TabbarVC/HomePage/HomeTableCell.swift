//
//  HomeTableCell.swift
//  AccessTokenApi
//
//  Created by Kullanici on 1.09.2023.
//

import UIKit
import TinyConstraints
class HomeTableCell: UITableViewCell {
    
    var item: [PlaceItem]?

    weak var delegate: GoToDetail?

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = Color.systemWhite.chooseColor
        return cv
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(item: [PlaceItem]) {
        self.item = item
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func setupView() {
        self.contentView.backgroundColor = Color.systemWhite.chooseColor
        self.contentView.addSubviews(collectionView)
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.edgesToSuperview()
    }
    
    func pushNav(item: PlaceItem) {
        let detailVC = DetailVC()
        detailVC.placeId = item.id
        delegate!.pushVC(vc:detailVC)
    }
    
}


extension HomeTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 309, height: (collectionView.frame.height))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = item else {return}
        pushNav(item: item[indexPath.row])
    }
}

extension HomeTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeCollectionViewCell else {return UICollectionViewCell()}
        guard let item = item else {return cell}
        cell.configure(item: item[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let item = item else {return 0 }
        return item.count
    }
}

