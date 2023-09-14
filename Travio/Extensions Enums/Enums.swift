//
//  Enums.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit
import Alamofire


enum Color {
    case systemGreen
    case systemblack
    case systemWhite
    case systemBlue
    case white
    case systemgray
    case barItemColor
    
    var chooseColor: UIColor {
        switch self {
        case .systemGreen:
            return #colorLiteral(red: 0.2196078431, green: 0.6784313725, blue: 0.662745098, alpha: 1)
        case .systemblack:
            return #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)
        case .systemWhite:
            return #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        case .white:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .systemgray:
            return #colorLiteral(red: 0.662745098, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
        case .barItemColor:
            return #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        case .systemBlue:
            return #colorLiteral(red: 0.09019607843, green: 0.7529411765, blue: 0.9215686275, alpha: 1)
        }
    }
}



enum FontType:String {
    case semibold = "SemiBold"
    case bold    = "Bold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
}

enum Font {
    
    case poppins(fontType:FontType,size:CGFloat)
    
    var font:UIFont? {
        switch self {
        case .poppins(let type, let size):
            return UIFont(name: "Poppins-\(type.rawValue)", size: size)
        }
    }
}

