//
//  SettingsCollectionViewUtilities.swift
//  Noty
//
//  Created by Youssef Jdidi on 24/3/2021.
//

import UIKit

protocol SettingsCollectionViewUtilitiesProtocol: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func set(dataSource: [Config])
}

class SettingsCollectionViewUtilities: NSObject, SettingsCollectionViewUtilitiesProtocol {

    var dataSource: [Config] = []

    func set(dataSource: [Config]) {
        self.dataSource = dataSource
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.configCell.identifier, for: indexPath) as? ConfigCell else { return UICollectionViewCell() }
        cell.configureCell(with: dataSource[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 76)
    }
}
