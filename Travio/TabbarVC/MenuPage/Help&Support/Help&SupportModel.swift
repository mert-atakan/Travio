//
//  Help&SupportModel.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 5.09.2023.
//

import Foundation
import UIKit

struct CellDataModel {
    let title: String
    let description: String
    let buttonImage: UIImage
    var isExpanded = false
    
    static let mockedData: [CellDataModel] = [
        CellDataModel(title: "How can I create a new account on Travio?", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "helpAndSupportButton")),
        CellDataModel(title: "How can I save a visit?", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "helpAndSupportButton")),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "helpAndSupportButton")),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "helpAndSupportButton")),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "helpAndSupportButton")),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "helpAndSupportButton")),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "helpAndSupportButton"))
    ]
    
}
