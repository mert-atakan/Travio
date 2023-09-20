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
        label.text = "My Visits"
        label.font = Font.poppins(fontType: .semibold, size: 36).font
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
        tableView.showsVerticalScrollIndicator = false
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
    
    @objc func visitChanged() {
        visitViewModal.fetchTravels { status, message in
            if status {
                self.tableView.reloadData()
            } else {
                AlertHelper.showAlert(in: self, title: .information, message: message, primaryButtonTitle: .ok)
            }
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(containerView,headerLabel,activity)
        containerView.addSubViews(tableView)
        setupLayout()
    }
    
    private func setupLayout() {
        headerLabel.edgesToSuperview(excluding:[.bottom], insets: .left(24) + .top(24) + .right(201),usingSafeArea: true)
        headerLabel.height(52)
        
        activity.centerInSuperview()
        activity.height(40)
        activity.width(40)
        
        containerView.topToBottom(of:headerLabel, offset: 52)
        containerView.edgesToSuperview(excluding: [.top])
        
        tableView.edgesToSuperview( insets: .top(45) + .right(22) + .left(24) + .bottom(101), usingSafeArea: true)
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
        
        visitViewModal.fetchTravels { status, message in
            if status {
                self.tableView.reloadData()
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok)
            }
            
        }
    }
    
    func pushNav(visitId:String, placeId: String) {
        let detailVC = DetailVC()
        detailVC.placeId = placeId
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
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
