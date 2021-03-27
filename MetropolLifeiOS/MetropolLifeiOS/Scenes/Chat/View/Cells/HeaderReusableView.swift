//
//  HeaderReusableView.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation
import MessageKit
import Foundation
import SnapKit

class HeaderReusableView: MessageReusableView {

    private var label: UILabel!
    private var labelContainer: UIView!
    
    static var height: CGFloat {
        return 40
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createUI()
    }

    func setup(with date: Date) {
        
        if date.getFormattedDate(format: "MMM dd") == Date().getFormattedDate(format: "MMM dd") {
            label.text = "Сегодня"
        } else {
            label.text = date.getFormattedDate(format: "MMM dd")
        }
    }

    override func prepareForReuse() {
        label.text = nil
    }

    private func createUI() {
        label = UILabel()
        label.preferredMaxLayoutWidth = frame.width
        label.numberOfLines = 1
        label.textAlignment = .center
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6509803922, green: 0.6509803922, blue: 0.6509803922, alpha: 1)
        
        labelContainer = UIView()
        labelContainer.backgroundColor = .clear
        labelContainer.layer.cornerRadius = 14
        
        labelContainer.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-24)
            maker.leading.equalToSuperview().offset(24)
        }
        
        addSubview(labelContainer)
        labelContainer.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.height.equalTo(28)
        }
    }
}
