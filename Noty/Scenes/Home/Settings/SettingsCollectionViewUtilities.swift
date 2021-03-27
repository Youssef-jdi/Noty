//
//  SettingsCollectionViewUtilities.swift
//  Noty
//
//  Created by Youssef Jdidi on 24/3/2021.
//

import UIKit

protocol SettingsCollectionViewUtilitiesProtocol: UICollectionViewDataSource {
    func set(dataSource: [Config])

    var dataSource: [Config] { get set }
}

class SettingsCollectionViewUtilities: NSObject, SettingsCollectionViewUtilitiesProtocol {

    var dataSource: [Config] = []
    let optionsDataSource = [
        "Enable Noty to send notifications",
        "Automatically start recording",
        "Close the app after sending or saving Note",
        "Turn off music during recording",
        "Use bluetooth microphone",
        "Enable vibrations when recording"
    ]

    func set(dataSource: [Config]) {
        self.dataSource = dataSource
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return dataSource.count
        case 1: return 1
        case 2: return optionsDataSource.count
        default: assertionFailure()
        }
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.configCell.identifier, for: indexPath) as? ConfigCell else { return UICollectionViewCell() }
            cell.configureCell(with: dataSource[indexPath.row])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.themeCell.identifier, for: indexPath) as? ThemeCell else { return UICollectionViewCell() }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.optionCell.identifier, for: indexPath) as? OptionCell else { return UICollectionViewCell() }
            cell.titleLabel.text = optionsDataSource[indexPath.row]
            return cell
        default: assertionFailure()
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: R.reuseIdentifier.settingsSectionHeader,
                for: indexPath)
                else {
                    assertionFailure("Could not get header")
                    return UICollectionReusableView()
            }
            switch indexPath.section {
            case 0: sectionHeader.titleLabel.text = "Settings"
            case 1: sectionHeader.titleLabel.text = "Theme"
            case 2: sectionHeader.titleLabel.text = "Options"
            default: break
            }
            return sectionHeader
        case UICollectionView.elementKindSectionFooter:
            guard let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: R.reuseIdentifier.settingSectionFooter.identifier, for: indexPath) as? UICollectionReusableView else {
                assertionFailure("Could not get footer")
                return UICollectionViewCell()
            }
            return sectionFooter
        default:
            return UICollectionReusableView()
        }
    }
}
