//
//  BreweryViewController.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import CoreData

// MARK: - Factory

final class BreweryViewControllerFactory {
    private(set) weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
    
    func makeBreweryViewController(useCases: UseCases, delegate: BreweryViewControllerDelegate?) -> BreweryViewController {
        let vc = BreweryViewController(viewModel: BreweryViewModelFactory.makeBreweryViewModel(useCases: useCases))
        vc.delegate = delegate
        coordinator.flatMap { vc.setCoordinator($0) }
        return vc
    }
}

protocol BreweryViewControllerDelegate: AnyObject {
    func breweryViewControllerDidTapWebSiteLink(_ vc: BreweryViewController, brewery: BreweryModel?)
    func breweryViewControllerShowOnMap(_ vc: BreweryViewController, brewery: BreweryModel?)
}

class BreweryViewController: BaseViewController, FRCMakeable {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    let viewModel: BreweryViewModel
    weak var delegate: BreweryViewControllerDelegate?
    private var frc: NSFetchedResultsController<BreweryCD>?
    lazy var delegateFRC = TableViewFRCObservable(tableView: tableView)
    
    // MARK: - Life cycle
    
    init(viewModel: BreweryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: R.nib.breweryViewController.name, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        print(#function)
    }
    
    // MARK: - Setup
    
    private func setup() {
        title = R.string.localizable.breweryTitle()
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.contentInset.top = -1
        tableView.register(R.nib.breweryTVC)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        reactive.activity <~ viewModel.dataSource.isFetchInProgress
        reactive.errors <~ viewModel.dataSource.fetchedError.signal
        reactive.makeBindingTarget { vc, _ in
            vc.tableView.reloadData()
            } <~ viewModel.dataSource.successFetch.signal.skip(while: { $0 == false })
        firstFetchBreweries()
        setupFRC()
        setupSearchController()
        tableView.scrollIndicatorInsets.top = searchController.searchBar.frame.height
        viewModel.isFetchedTotalResults <~ viewModel.dataSource.isFetchTotalResults.signal
    }
    
     // MARK: - Helper methods
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        definesPresentationContext = false
        searchController.obscuresBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = R.color.green()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.backgroundImage = UIImage()
    }
    
    private func setupFRC() {
        frc = setupFetchedResultsController(with: BreweryCD.fetchRequest(), in: CoreDataStack.shared.mainManagedObjectContext)
        frc?.delegate = delegateFRC
    }
    
    private func firstFetchBreweries() {
        if viewModel.useCases.database.isAllowFirstfetch() {
            viewModel.dataSource.fetchBreweries()
        }
    }
}

// MARK: - UITableViewDataSource

extension BreweryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.state {
        case .search:
            return viewModel.dataSource.currentCount
        case .list:
            return frc?.fetchedObjects?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.breweryTVC, for: indexPath)!
        var brewery: BreweryModel
        switch viewModel.state {
        case .search:
            brewery = viewModel.dataSource.brewery(at: indexPath.row)
        case .list:
            guard let breweryCD = frc?.fetchedObjects?[indexPath.row] else { return BreweryTVC() }
            brewery = BreweryModelImpl(breweryCD)
        }
        cell.delegate = self
        cell.configure(with: brewery)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch viewModel.state {
        case .search:
            if indexPath.row == viewModel.dataSource.currentCount - 1 && !viewModel.isFetchedTotalResults.value {
                guard let name = viewModel.breweryName else { return }
                viewModel.dataSource.fetchSearchedBreweries(name: name)
            }
        case .list:
            guard let breweries = frc?.fetchedObjects else { return }
            if indexPath.row == breweries.count - 1 && !viewModel.isFetchedTotalResults.value {
                viewModel.dataSource.fetchBreweries()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension BreweryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - BreweryTVCDelegate

extension BreweryViewController: BreweryTVCDelegate {
    func breweryTVCDidTapWebSiteLink(_ cell: BreweryTVC) {
        guard let cellIndexPath = tableView.indexPath(for: cell) else {
            return
        }
        var brewery: BreweryModel
        switch viewModel.state {
        case .search:
            brewery = viewModel.dataSource.brewery(at: cellIndexPath.row)
        case .list:
            guard let breweryCD = frc?.fetchedObjects?[cellIndexPath.row] else { return }
            brewery = BreweryModelImpl(breweryCD)
        }
        delegate?.breweryViewControllerDidTapWebSiteLink(self, brewery: brewery)
    }
    
    func breweryTVCDidTapShowOnMap(_ cell: BreweryTVC) {
        guard let cellIndexPath = tableView.indexPath(for: cell) else {
                return
        }
        var brewery: BreweryModel
        switch viewModel.state {
        case .search:
            brewery = viewModel.dataSource.brewery(at: cellIndexPath.row)
        case .list:
            guard let breweryCD = frc?.fetchedObjects?[cellIndexPath.row] else { return }
            brewery = BreweryModelImpl(breweryCD)
        }
        
        delegate?.breweryViewControllerShowOnMap(self, brewery: brewery)
    }
}

// MARK: - UISearchBarDelegate

extension BreweryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}

extension BreweryViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.state = .search
        viewModel.dataSource.removeAll()
        frc?.delegate = nil
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        guard text.isEmpty else {
            viewModel.state = .search
            tableView.reloadData()
            return
        }
        viewModel.state = .list
        frc?.delegate = delegateFRC
        tableView.reloadData()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.state = .list
        frc?.delegate = delegateFRC
        viewModel.dataSource.currentPageForSearch = 1
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }
        let breweryName = BreweryName(name: name)
        viewModel.breweryName = breweryName
        viewModel.dataSource.fetchSearchedBreweries(name: breweryName)
    }
}
