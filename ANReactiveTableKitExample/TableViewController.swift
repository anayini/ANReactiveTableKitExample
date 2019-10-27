//
//  TableViewController.swift
//  ANReactiveTableKitExample
//
//  Created by Arjun Nayini on 9/27/19.
//  Copyright © 2019 Arjun Nayini. All rights reserved.
//

import Foundation
import UIKit
import ANReactiveTableKit

final class TableViewController: UITableViewController {

    var tableViewDriver: TableCoordinator?
    var groups: [TeaGroup] = [] {
        didSet {
            self.tableViewDriver?.tableViewModel = TableViewController.viewModel(forState: groups
            )
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Teas"
        self.tableViewDriver = TableCoordinator(tableView: self.tableView)

        self.groups = [
            TeaGroup.chineseTeas,
            TeaGroup.japaneseTeas
        ]
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.addTea()
        }
    }

    func addTea() {
        let randomTea = Tea.randomTea()
        switch randomTea.region {
        case .chinese:
            self.groups[0].teas.append(randomTea)
        case .japanese:
            self.groups[0].teas.append(randomTea)
        }
    }
}

// MARK: View Model Provider

extension TableViewController {

    /// Pure function mapping new state to a new `TableViewModel`.  This is invoked each time the state updates
    /// in order for ReactiveLists to update the UI.
    static func viewModel(forState groups: [TeaGroup]) -> TableModel {
        let sections: [TableSectionModel] = groups.map { group in
            let cellViewModels = group.teas.map { TeaTableCellModel(tea: $0) }
            return TableSectionModel(id: group.name, cellViewModels: cellViewModels, headerTitle: group.name)
        }
        return TableModel(sections: sections)
    }
}

final class TeaTableCell: UITableViewCell {}

struct TeaTableCellModel: TableCellViewModel {
    var id: String {
        return self.tea.uuid.uuidString
    }
    let tea: Tea
    let registrationInfo = ViewRegistrationInfo(classType: TeaTableCell.self)
    let height = Float(44.0)
    
    var didSelect: DidSelectClosure? = {
        print("Tea Tapped!")
    }
    
    func apply(to cell: UITableViewCell) {
        guard let tableCell = cell as? TeaTableCell else { return }
        tableCell.textLabel?.text = tea.name
    }
}
