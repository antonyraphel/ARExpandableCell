//
//  HeaderFooterView.swift
//  ARExpandableCell
//
//  Created by Antony Raphel on 10/01/19.
//  Copyright © 2019 Antony Raphel. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: NSObjectProtocol {
    func toggleSection(state: Bool, section: SectionType)
}

class HeaderFooterView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    
    weak var delegate: HeaderViewDelegate?
    var product: Expandable.Initial.ViewModel.ProductViewModel? {
        didSet {
            guard let product = product else {
                return
            }
            
            titleLabel?.text = product.title
            arrowLabel?.transform = CGAffineTransform(rotationAngle: product.state ? 0.0 : .pi)
        }
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    @objc private func didTapHeader(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.toggleSection(state: product?.state ?? false, section: product?.type ?? .iPhone)
    }
}
