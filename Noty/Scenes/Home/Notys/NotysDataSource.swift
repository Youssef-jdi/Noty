//
//  NotysDataSource.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/3/2021.
//

import UIKit

protocol NotysDataSourceProtocol: UITableViewDataSource {
    func set(data: [NoteModel])
}

class NotysDataSource: NSObject, NotysDataSourceProtocol {

    // MARK: Properties
    var data: [NoteModel] = []

    func set(data: [NoteModel]) {
        self.data = data
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.noteCell.identifier, for: indexPath) as? NoteCell
        else { assertionFailure("Couldn't create cell"); return UITableViewCell() }
        cell.configure(with: data[indexPath.row].text)
        return cell
    }
}
