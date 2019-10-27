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
    var groups: [ToolGroup] = [] {
        didSet {
            self.tableViewDriver?.tableViewModel = TableViewController.viewModel(forState: groups
            )
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tools"
        self.tableViewDriver = TableCoordinator(tableView: self.tableView)

        self.groups = [
            ToolGroup(
                name: "OLD TOOLS",
                tools: [Tool(type: .wrench), Tool(type: .hammer), Tool(type: .clamp), Tool(type: .nutBolt), Tool(type: .crane)]
            ),
            ToolGroup(
                name: "NEW TOOLS",
                tools: [Tool(type: .wrench), Tool(type: .hammer), Tool(type: .clamp), Tool(type: .nutBolt), Tool(type: .crane)]
            ),
        ]
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.addTool()
        }
    }

    func addTool() {
        self.groups[0].tools.append(Tool.randomTool())
    }
}

// MARK: View Model Provider

extension TableViewController {

    /// Pure function mapping new state to a new `TableViewModel`.  This is invoked each time the state updates
    /// in order for ReactiveLists to update the UI.
    static func viewModel(forState groups: [ToolGroup]) -> TableModel {
        let sections: [TableSectionModel] = groups.map { group in
            let cellViewModels = group.tools.map { ToolTableCellModel(tool: $0) }
            return TableSectionModel(id: group.name, cellViewModels: cellViewModels, headerTitle: group.name)
        }
        return TableModel(sections: sections)
    }
}

final class ToolTableCell: UITableViewCell {}

struct ToolTableCellModel: TableCellViewModel {
    var id: String {
        return self.tool.uuid.uuidString
    }
    let tool: Tool
    let registrationInfo = ViewRegistrationInfo(classType: ToolTableCell.self)
    let height = Float(44.0)
    
    var didSelect: DidSelectClosure? = {
        print("Tool Tapped!")
    }
    
    func apply(to cell: UITableViewCell) {
        guard let tableCell = cell as? ToolTableCell else { return }
        tableCell.textLabel?.text = tool.type.name
    }
}
