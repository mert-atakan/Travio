//
//  HomeVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import TinyConstraints
import NVActivityIndicatorView

protocol GoToDetail: AnyObject {
    func pushVC(vc: UIViewController)
}

class HomeVC: UIViewController,GoToDetail {
    
    let viewModal = HomeVM()
    
    var popularArray: [PlaceItem]?
    var newPlaces: [PlaceItem]?
    var myVisits: [PlaceItem]?
    var myTravels: [Visits]?
    private lazy var activity: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: .zero, type: .pacman, color: Color.systemGreen.chooseColor, padding: 0)
        return activity
    }()
    
    private lazy var topImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "homeTopImage")
        return iv
    }()
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = Color.systemWhite.chooseColor
        return v
    }()
    
    
    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.backgroundColor = Color.systemWhite.chooseColor
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.register(HomeTableCell.self, forCellReuseIdentifier: "tableCell")
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
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
        view1.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    @objc func showDetail(_ button:UIButton){
        let seeAllVC = SeeAllPlacesVC()
        
        if button.tag == 0 {
            seeAllVC.fromWhere = "popularPlaces"
        } else if button.tag == 1 {
            seeAllVC.fromWhere = "newPlaces"
        } else if button.tag == 2 {
            seeAllVC.fromWhere = "myVisits"
        }
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    @objc func visitChanged() {
        viewModal.getMyVisits {status, message in
            if status {
                self.tableView.reloadData()
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
        }
    }
    
    func initVM() {
        
        activity.startAnimating()

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        viewModal.getPopularPlaces { status, message in
            if status {
                dispatchGroup.leave()
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
           
        }

        dispatchGroup.enter()
        viewModal.getLastPlaces {status, message in
            if status {
                dispatchGroup.leave()
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
        }

        dispatchGroup.enter()
        viewModal.getMyVisits {status, message in
            if status {
                dispatchGroup.leave()
            } else {
                AlertHelper.showAlert(in: self, title: .sorry, message: message, primaryButtonTitle: .ok, primaryButtonAction: nil, secondaryButtonTitle: nil, secondaryButtonAction: nil)
            }
        }
        
        viewModal.closure = { array in
            dispatchGroup.notify(queue: .main) {
                DispatchQueue.main.async {
                    guard let popularPlaces = self.viewModal.popularPlaces,
                          let newPlaces = self.viewModal.newPlaces
                    else {return}

                    self.popularArray = popularPlaces
                    self.newPlaces = newPlaces
                    self.myVisits = array
                    self.activity.stopAnimating()

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
    }
       
    }
    
    func pushVC(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupView() {
        self.view.backgroundColor = Color.systemGreen.chooseColor
        self.view.addSubviews(view1,topImageview,activity)
        view1.addSubviews(tableView)
        setupLayout()
    }
    
    private func setupLayout() {
        topImageview.edgesToSuperview(excluding: [.bottom,.right], insets: .top(28) + .left(16),usingSafeArea: true)
        topImageview.height(62)
        topImageview.width(172)
        
        view1.topToBottom(of: topImageview, offset: 35)
        view1.edgesToSuperview(excluding: [.top])
        
        tableView.top(to: view1,offset: 15)
        tableView.edgesToSuperview()
        
        activity.centerInSuperview()
        activity.height(50)
        activity.width(50)
        
        topImageview.layoutSubviews()
    }
    
    private func headerButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(Color.systemBlue.chooseColor, for: .normal)
        button.titleLabel?.font = Font.poppins(fontType: .semibold, size: 14).font
        button.frame = CGRect(x: 327, y: 28, width: 47, height: 21)
        button.addTarget(self, action: #selector(showDetail(_:)), for: .touchUpInside)
        return button
    }
    
    private func headerLabel(section:Int, headerView:UIView) -> UILabel {
        let label = UILabel()
        label.frame = CGRect.init(x: 24, y: 20, width: headerView.frame.width-10, height: 30)
        label.text = viewModal.getHeaderNameForSection(section: section)
        label.font = Font.poppins(fontType: .semibold, size: 20).font
        label.textColor = Color.systemblack.chooseColor
        return label
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 52))
        headerView.backgroundColor = Color.systemWhite.chooseColor
        
        let label = headerLabel(section: section,headerView: headerView)
        
        let button = headerButton()
        
        button.tag = section
        
        headerView.addSubview(label)
        headerView.addSubview(button)
        
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? HomeTableCell else {return UITableViewCell()}
        cell.delegate = self
        
        guard let popularArray = popularArray, let newPlaces = newPlaces, let myVisits = myVisits else {return cell}
        
        switch indexPath.section {
        case 0:
            cell.configure(item: popularArray)
        case 1:
            cell.configure(item: newPlaces)
        case 2:
            cell.configure(item: myVisits)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModal.sectionNames.count
    }
}
