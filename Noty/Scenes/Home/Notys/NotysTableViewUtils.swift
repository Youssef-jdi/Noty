//
//  NotysDataSource.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/3/2021.
//

import UIKit

protocol NotysTableViewUtilsProtocol: UITableViewDataSource, UITableViewDelegate {
    func set(data: [NoteModel])
    
    var delegate: NoteUtilsDelegate? { get set }
    var data: [NoteModel] { get set }
}

protocol NoteUtilsDelegate: class {
    func delete(note: NoteModel, at indexPath: IndexPath)
    func setReminder(on note: NoteModel, at indexPath: IndexPath)
    func setFavorite(on note: NoteModel, at indexPath: IndexPath)
}

class NotysTableViewUtils: NSObject, NotysTableViewUtilsProtocol {

    // MARK: Properties
    var data: [NoteModel] = []
    weak var delegate: NoteUtilsDelegate?

    func set(data: [NoteModel]) {
        self.data = data
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.noteCell.identifier, for: indexPath) as? NoteCell
        else { assertionFailure("Couldn't create cell"); return UITableViewCell() }
        cell.configure(with: data[indexPath.row].title)
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
        let favouriteAction = UIContextualAction(style: .normal, title: "") {[weak self] _, _, completion in
            guard let self = self else { return }
            Console.log(type: .success, "\(self.data[indexPath.row].text)")
            self.delegate?.setFavorite(on: self.data[indexPath.row], at: indexPath)
            completion(true)
        }
        favouriteAction.backgroundColor = .white
        favouriteAction.image = self.data[indexPath.row].isFavorite ? R.image.heart_filled()?.withTintColor(R.color.appLightRed()!) : R.image.heart()
        return favouriteAction
    }

    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: "") {[weak self] _, _, completion in
            guard let self = self else { return }
            self.delegate?.delete(note: self.data[indexPath.row], at: indexPath)
            completion(true)
        }
        deleteAction.backgroundColor = .white
        deleteAction.image = R.image.delete_icon()?.withTintColor(.red)
        return deleteAction
    }

    private func makeReminderContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let reminderAction = UIContextualAction(style: .normal, title: "") {[weak self] _, _, completion in
            guard let self = self else { return }
            Console.log(type: .success, "\(self.data[indexPath.row].text)")
            self.delegate?.setReminder(on: self.data[indexPath.row], at: indexPath)
            completion(true)
        }
        reminderAction.backgroundColor = .white
        reminderAction.image = data[indexPath.row].isReminded ? R.image.ic_alert_green() :  R.image.ic_alert_blue()
        return reminderAction
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
