//
//  ExpandablePresenter.swift
//  ARExpandableCell
//
//  Created by Antony Raphel on 09/01/19.
//  Copyright (c) 2019 Antony Raphel. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ExpandablePresentationLogic {
    func presentSomething(response: Expandable.Something.Response)
}

class ExpandablePresenter: ExpandablePresentationLogic {
    weak var viewController: ExpandableDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Expandable.Something.Response) {
        let viewModel = Expandable.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}