//
//  VisitVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
import NVActivityIndicatorView

class VisitVC: UIViewController {
    
    let visitViewModal = VisitVM()
    
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 3
        label.text = "My Visits"
        label.font = Font.semibold24.chooseFont
        label.textColor = Color.white.chooseColor
        return label
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Color.systemWhite.chooseColor
        return containerView
    }()
    
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.systemWhite.chooseColor
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VisitCell.self, forCellReuseIdentifier: "VisitCell")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        initVM()
        
        NotificationCenterManager.shared.addObserver(self, name: Notification.Name("visitChanged"), selector: #selector(visitChanged))
    }
    
    deinit {
        NotificationCenterManager.shared.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        containerView.roundCorners(corners: .topLeft, radius: 80)
        tableView.roundCornersWithShadow([.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupView() {
        self.view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(containerView,headerLabel,activity)
        containerView.addSubViews(tableView)
        setupLayout()
    }
    
    private func setupLayout() {
        headerLabel.edgesToSuperview(excluding:[.bottom,.right], insets: .left(24) + .top(24),usingSafeArea: true)
        headerLabel.height(52)
        headerLabel.width(165)
        
        activity.centerInSuperview()
        activity.height(40)
        activity.width(40)
        
        containerView.edgesToSuperview( insets: .top(129))
        
        tableView.edgesToSuperview( insets: .top(45) + .right(22) + .left(22) + .bottom(0), usingSafeArea: true)
    }
    
    func initVM() {
        visitViewModal.onDataFetch = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activity.startAnimating()
                   
                } else {
                    self?.activity.stopAnimating()
                    
                }
            }
        }

        visitViewModal.fetchTravels {
                self.tableView.reloadData()
        }
    }
    
    @objc func visitChanged() {
        visitViewModal.fetchTravels {
                self.tableView.reloadData()
        }
    }
        func pushNav(visitId:String, placeId: String) {
            let detailVC = DetailVC()
            detailVC.placeId = placeId
            navigationController?.pushViewController(detailVC, animated: true)
        }

//     func setupView() {
//        self.view.backgroundColor = Color.systemGreen.chooseColor
//        view.addSubViews(containerView,headerLabel,activity)
//        containerView.addSubViews(tableView)
//        setupLayout()
//    }
//     func setupLayout() {
//        headerLabel.edgesToSuperview(excluding:[.bottom,.right], insets: .left(24) + .top(24),usingSafeArea: true)
//        headerLabel.height(52)
//        headerLabel.width(165)
//        
//        activity.centerInSuperview()
//        activity.height(40)
//        activity.width(40)
//        
//        containerView.edgesToSuperview( insets: .top(129))
//        
//        tableView.edgesToSuperview( insets: .top(45), usingSafeArea: true)
//
//    }
    
  
}






extension VisitVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitViewModal.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell", for: indexPath) as? VisitCell else {return UITableViewCell()}
        guard let item = visitViewModal.getObjectForRowAt(indexpath: indexPath) else {return UITableViewCell()}
        cell.configure(item: item.place)
        return cell
    }
}
extension VisitVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 219
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let visitInfo = visitViewModal.getObjectForRowAt(indexpath: indexPath) else {return}
        self.pushNav(visitId:visitInfo.id ,placeId: visitInfo.place_id)
        
    }
}
