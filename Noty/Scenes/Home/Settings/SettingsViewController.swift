//
//  SettingsViewController.swift
//  Noty
//
//  Created by Youssef Jdidi on 9/3/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol SettingsViewControllerProtocol: class, UIViewControllerRouting {
    func set(interactor: SettingsInteractorProtocol)
    func set(router: SettingsRouterProtocol)
    func set(utilities: SettingsCollectionViewUtilitiesProtocol)

    // add the functions that are called from the presenter
    func display(config: [Config])
}

class SettingsViewController: UIViewController, SettingsViewControllerProtocol {

    // MARK: DI
    var interactor: SettingsInteractorProtocol?
    var router: SettingsRouterProtocol?

    func set(interactor: SettingsInteractorProtocol) {
        self.interactor = interactor
    }

    func set(router: SettingsRouterProtocol) {
        self.router = router
    }

    func set(utilities: SettingsCollectionViewUtilitiesProtocol) {
        self.utilities = utilities
    }
    
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    var utilities: SettingsCollectionViewUtilitiesProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        interactor?.prepareConfigDataSource()
    }
    // MARK: Actions
}

// MARK: Methods
extension SettingsViewController {

    func display(config: [Config]) {
        utilities?.set(dataSource: config)
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = utilities
        collectionView.register(
            UINib(resource: R.nib.configCell),
            forCellWithReuseIdentifier: R.reuseIdentifier.configCell.identifier)
    }
}

// MARK: UICollectionViewDelegate
extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0: Console.log(type: .success, "Share noty")
        case 1: router?.route(to: .languageAlert(self))
        case 2: Console.log(type: .success, "Report an issue")
        default: break
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 76)
    }
}

// MARK: NewLanguageSelectedDelegate
extension SettingsViewController: NewLanguageSelectedDelegate {
    func finishSaving() {
        utilities?.dataSource.removeAll()
        collectionView.reloadData()
        interactor?.prepareConfigDataSource()
    }
}
