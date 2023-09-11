//
//  CustomLabel.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit

class CustomLabel: UILabel {
    var fontType: Font = .semibold14 {
            didSet {
                self.font = fontType.chooseFont
            }
        }
    init() {
       
        super.init(frame: .zero) // neden bunu yapıyorum. ezbere yapıyorum?
        self.font = fontType.chooseFont
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
