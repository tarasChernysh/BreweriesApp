//
//  TableViewFRCObservable.swift
//  Breweries
//
//  Created by Taras Chernysh on 16.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit
import CoreData

class TableViewFRCObservable: NSObject, NSFetchedResultsControllerDelegate {
    
    // MARK: Properties
    
    private let tableView: UITableView
    
    // MARK: Init
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .right)
        case .delete: guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .middle)
        case .move: guard let indexPath = indexPath, let newIndex = newIndexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.insertRows(at: [newIndex], with: .right)
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
