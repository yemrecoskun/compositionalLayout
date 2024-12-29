//
//  ViewController.swift
//  compositionalLayout
//
//  Created by Yunus Emre Coşkun on 29.12.2024.
//

import UIKit

class ViewController: UIViewController {
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(FeaturedNewsCell.self, forCellWithReuseIdentifier: "FeaturedNewsCell")
        collectionView.register(PopularNewsCell.self, forCellWithReuseIdentifier: "PopularNewsCell")
        collectionView.register(HostingCollectionViewCell<RegularNewsCellSwiftUI>.self, forCellWithReuseIdentifier: "RegularNewsCell")
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
}
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 // Günün Haberleri
        case 1: return 5 // Popüler Haberler
        default: return 10 // Tüm Haberler
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedNewsCell", for: indexPath) as! FeaturedNewsCell
            cell.configure(with: "Günün Haberi", image: UIImage(systemName: "star")!)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularNewsCell", for: indexPath) as! PopularNewsCell
            cell.configure(with: "Popüler Haber \(indexPath.item + 1)", image: UIImage(systemName: "star")!)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegularNewsCell", for: indexPath) as! HostingCollectionViewCell<RegularNewsCellSwiftUI>
            cell.set(content: RegularNewsCellSwiftUI(title: "Haber \(indexPath.item + 1)"))
            return cell
        }
    }
}

extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
    switch sectionIndex {
            case 0:
                return self.createFeaturedSection()
            case 1:
                return self.createHorizontalSection()
            default:
                return self.createVerticalSection()
            }
        }
    }
    private func createFeaturedSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(200)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeader()] // Header ekleme
        return section
    }
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .absolute(150),
            heightDimension: .absolute(150)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    private func createVerticalSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100)))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(500)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
    }
}
