//
//  ExpandableInteractor.swift
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

protocol ExpandableBusinessLogic {
    func doSomething(request: Expandable.Something.Request)
}

protocol ExpandableDataStore {
    //var name: String { get set }
}

class ExpandableInteractor: ExpandableBusinessLogic, ExpandableDataStore {
    var presenter: ExpandablePresentationLogic?
    var worker: ExpandableWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Expandable.Something.Request) {
        worker = ExpandableWorker()
        worker?.doSomeWork()
        
        let response = Expandable.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
