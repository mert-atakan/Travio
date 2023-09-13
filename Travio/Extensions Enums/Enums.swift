//
//  Enums.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//
//300 -> regular
//400 -> medium
//500 -> semibold
//600 -> bold
//Regular -> 400
//Medium -> 500
//SemiBold -> 600
//Bold -> 700

import UIKit
import Alamofire


enum Font {
    case light14
    case regular10
    case regular12
    case regular14
    case regular16
    case semibold24
    case semibold20
    case semibold16
    case semibold14
    case semibold12
    case semibold32
    case bold36
    case bold32
    case bold30
    case bold24
    case bold16
    case bold14
    case medium14
    var chooseFont: UIFont {
        switch self {
        case .light14:
            return UIFont(name: "Poppins-Light", size: 14)!
        case .regular10:
            return UIFont(name: "Poppins-Regular", size: 10)!
        case .regular12:
            return UIFont(name: "Poppins-Regular", size: 12)!
        case .regular14:
            return UIFont(name: "Poppins-Regular", size: 14)!
        case .regular16:
            return UIFont(name: "Poppins-Regular", size: 16)!
        case .bold14:
            return UIFont(name: "Poppins-Bold", size: 14)!
        case .semibold32:
            return UIFont(name: "Poppins-SemiBold", size: 32)!
        case .semibold24:
            return UIFont(name: "Poppins-SemiBold", size: 24)!
        case .semibold20:
            return UIFont(name: "Poppins-SemiBold", size: 20)!
        case .semibold16:
            return UIFont(name: "Poppins-SemiBold", size: 16)!
        case .semibold14:
            return UIFont(name: "Poppins-SemiBold", size: 14)!
        case .semibold12:
            return UIFont(name: "Poppins-SemiBold", size: 12)!
        case .bold36:
            return UIFont(name: "Poppins-Bold", size: 36)!
        case .bold30:
            return UIFont(name: "Poppins-Bold", size: 30)!
        case .medium14:
            return UIFont(name: "Poppins-Medium", size: 14)!
        case .bold24:
            return UIFont(name: "Poppins-Bold", size: 24)!
        case .bold16:
            return UIFont(name: "Poppins-Bold", size: 16)!
        case .bold32:
            return UIFont(name: "Poppins-Bold", size: 32)!
        }
    }
}

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

