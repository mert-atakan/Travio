//
//  Help&SupportVM.swift
//  AccessTokenApi
//
//  Created by Kaan Acikgoz on 5.09.2023.
//

import Foundation
import UIKit

class HelpAndSupportVM {
    
    var mockedData: [CellDataModel] = [
        CellDataModel(title: "How can I create a new account on Travio?", description: "Lorem Ipsum is simply dummy text  and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "Vector 1"), isExpanded: false),
        CellDataModel(title: "How can I save a visit?", description: "Lorem Ipsum is simply dummy text and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "Vector 1"), isExpanded: false),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text  and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "Vector 1"), isExpanded: false),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text  and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "Vector 1"), isExpanded: false),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "Vector 1"), isExpanded: false),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "Vector 1"), isExpanded: false),
        CellDataModel(title: "How does Travio work?", description: "Lorem Ipsum is simply dummy text and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown took a galley of type and scrambled it to make a type specimen book", buttonImage: #imageLiteral(resourceName: "Vector 1"), isExpanded: false)
    ]

    func getObject(indexPath: IndexPath) -> CellDataModel {
        return mockedData[indexPath.row]
    }
    
    func getCellForSection() -> Int {
        return mockedData.count
    }
    
}

