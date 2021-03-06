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
    func doInitial(request: Expandable.Initial.Request)
    func update(request: Expandable.Update.Request)
}

protocol ExpandableDataStore {
    var state: [SectionType: Bool] { get set }
}

class ExpandableInteractor: ExpandableBusinessLogic, ExpandableDataStore {
    var presenter: ExpandablePresentationLogic?
    var worker: ExpandableWorker?
    var state: [SectionType: Bool] = [.iPhone: false,
                                      .iPad: false,
                                      .mac: false,
                                      .watch: false,
                                      .tv: false] // setting default expand state as false
    
    // MARK: Do Initial
    
    func doInitial(request: Expandable.Initial.Request) {
        let products = getProductResponse()
        let response = Expandable.Initial.Response(summary: products)
        presenter?.presentInitial(response: response)
    }
    
    func update(request: Expandable.Update.Request) {
        state[request.type] = !request.state
        let products = getProductResponse()
        let response = Expandable.Initial.Response(summary: products)
        presenter?.presentInitial(response: response)
    }
    
    // MarkL Private func
    
    private func getProductResponse() -> [Expandable.Initial.Response.ProductResponse] {
        var products: [Expandable.Initial.Response.ProductResponse] = []
        products += [Expandable.Initial.Response.ProductResponse(state: state[.iPhone] ?? false,
                                                                 type: .iPhone,
                                                                 title: Title.iPhone.rawValue,
                                                                 products: getiPhoneProducts())]
        return products
    }
    
    private func getiPhoneProducts() -> [Expandable.Initial.Response.ProductResponse.AppleProductResponse] {
        var iPhones: [Expandable.Initial.Response.ProductResponse.AppleProductResponse] = []
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone XR")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone Xs")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone Xs Max")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone X")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone 8 Plus")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone 8")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone 7 Plus")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone 7")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone 6s")]
        iPhones += [Expandable.Initial.Response.ProductResponse.AppleProductResponse(title: "iPhone 6")]
        return iPhones
    }
}
