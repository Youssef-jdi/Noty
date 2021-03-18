//
//  NotysDataSource.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/3/2021.
//

import UIKit

protocol NotysTableViewUtilsProtocol: UITableViewDataSource, UITableViewDelegate {
    func set(data: [NoteModel])
}

class NotysTableViewUtils: NSObject, NotysTableViewUtilsProtocol {

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

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeFavouriteContextualAction(forRowAt: indexPath),
            makeReminderContextualAction(forRowAt: indexPath)
        ])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }

    private func makeFavouriteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let favouriteAction = UIContextualAction(style: .normal, title: "") { action, _, completion in
            completion(true)
        }
        favouriteAction.backgroundColor = .white
        favouriteAction.image = R.image.ic_heart()?.withTintColor(R.color.appLightRed()!)
        return favouriteAction
    }

    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, _, completion in
            completion(true)
        }
        deleteAction.backgroundColor = .white
        deleteAction.image = R.image.delete_icon()?.withTintColor(.red)
        return deleteAction
    }

    private func makeReminderContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let reminderAction = UIContextualAction(style: .normal, title: "") { action, _, completion in
            completion(true)
        }
        reminderAction.backgroundColor = .white
        reminderAction.image = R.image.ic_alert_blue()
        return reminderAction
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
