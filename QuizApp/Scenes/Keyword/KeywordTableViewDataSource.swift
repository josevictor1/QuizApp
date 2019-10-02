//
//  KeywordTableViewDataSource.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 29/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class KeywordTableViewDataSource: NSObject {
    
    let tableView: UITableView
    
    init?(tableView: UITableView) {
        self.tableView = tableView
    }
    
    var words = [String]()
    
    func addKeyword(_ keyword: String) {
        words.append(keyword)
        updateTableView()
    }
    
    func updateTableView() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: words.count - 1, section: 0)],
                             with: .top)
        tableView.endUpdates()
    }
    
    func removeAllKeywords() {
        words.removeAll()
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource
extension KeywordTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(KeywordTableViewCell.self)", for: indexPath) as? KeywordTableViewCell else {
            fatalError("")
        }
        cell.fill(with: words[indexPath.row])
        return cell
    }
    
}
