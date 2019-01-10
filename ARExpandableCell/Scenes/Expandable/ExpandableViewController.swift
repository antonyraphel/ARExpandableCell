//
//  ExpandableViewController.swift
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

protocol ExpandableDisplayLogic: class {
    func displayInitial(viewModel: Expandable.Initial.ViewModel)
}

class ExpandableViewController: UIViewController, ExpandableDisplayLogic {
    var interactor: ExpandableBusinessLogic?
    var router: (NSObjectProtocol & ExpandableRoutingLogic & ExpandableDataPassing)?
    var summary: [Expandable.Initial.ViewModel.ProductViewModel] = []
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ExpandableInteractor()
        let presenter = ExpandablePresenter()
        let router = ExpandableRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandableTableView?.estimatedRowHeight = 100
        expandableTableView?.rowHeight = UITableView.automaticDimension
        expandableTableView?.sectionHeaderHeight = 70
        expandableTableView?.separatorStyle = .none
        expandableTableView?.register(HeaderFooterView.nib, forHeaderFooterViewReuseIdentifier: HeaderFooterView.identifier)
        doInitial()
    }
    
    // MARK: Do Initial
    
    @IBOutlet weak var expandableTableView: UITableView!
    
    func doInitial() {
        let request = Expandable.Initial.Request()
        interactor?.doInitial(request: request)
    }
    
    func displayInitial(viewModel: Expandable.Initial.ViewModel) {
        summary = viewModel.summary
        expandableTableView.reloadData()
    }
}

extension ExpandableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return summary.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var retRows = 0
        switch summary[section].type {
        case .iPhone:
            retRows = summary[section].state == true ? summary[section].products.count : 0
        case .iPad:
            retRows = summary[section].state == true ? summary[section].products.count : 0
        case .mac:
            retRows = summary[section].state == true ? summary[section].products.count : 0
        case .watch:
            retRows = summary[section].state == true ? summary[section].products.count : 0
        case .tv:
            retRows = summary[section].state == true ? summary[section].products.count : 0
        }
        return retRows
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderFooterView.identifier) as? HeaderFooterView {
            headerView.product = summary[section]
            headerView.delegate = self
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = summary[indexPath.section].products[indexPath.row].title
        return cell
    }
}

extension ExpandableViewController: HeaderViewDelegate {
    func toggleSection(state: Bool, section: SectionType) {
        let request = Expandable.Update.Request(state: state, type: section)
        interactor?.update(request: request)
    }
}
