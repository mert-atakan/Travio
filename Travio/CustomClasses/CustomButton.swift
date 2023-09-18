//
//  CustomButton.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {

        super.init(frame: .zero)
        self.backgroundColor = Color.systemGreen.chooseColor
        
    }
    
    override func layoutSubviews() {
        self.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
        super.layoutSubviews()
        self.setTitleColor(.white, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
