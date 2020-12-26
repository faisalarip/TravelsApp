//
//  ViewController.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 20/12/20.
//

import UIKit

class TravelsVC: UIViewController {
    
    let sections = Bundle.main.decode([Section].self, from: "TravelsData.json")
    
    var collectionView: UICollectionView? = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Travel>? = nil
    var hasTapped = [Int]()
    
    private let favoriteImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    private let favoriteImageFill = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionlayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = .systemBackground
        collectionView?.delegate = self
        guard let collectView = collectionView else { return }
        view.addSubview(collectView)
        
        self.registeredCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.diffableDataSource()
        self.appendingDiffableDataSourceSnapshot()
    }
    
    private func registeredCells() {
        collectionView?.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.identifier)
        collectionView?.register(FeaturedTableCell.self, forCellWithReuseIdentifier: FeaturedTableCell.reuseableIdentifier)
        collectionView?.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.reuseableIdentifier)
        collectionView?.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseableIdentifier)
    }
    
    private func configureCells<T: ConfiguringCell>(_ cellType: T.Type, with travel: Travel, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: cellType.reuseableIdentifier, for: indexPath) as? T else { fatalError("Unable dequeu cells") }
        
        cell.configureCellLayout(with: travel)
        
        return cell
    }
    
    private func createCompositionlayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = self.sections[sectionIndex]
            switch section.type {
            case "smallTable":
                return self.createSmallTableLayout(using: section)
            case "mediumTable":
                return self.createMediumTableLayout(using: section)
            default:
                return self.createFeatureLayout(using: section)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config
        
        return layout
    }
    
    @objc private func didTapFavoriteButton(_ sender: UIButton) {
                
        let item = sections[0].items[sender.tag]
        print(item)
        
        if sender.isSelected {
            sender.zoomOutWithEasing(duration: 0.3, easingOffset: 0.3)
            sender.setImage(favoriteImage, for: .selected)
        } else {
            let alertController = UIAlertController(title: "Confirm", message: "Would you like to added \(item.name) on a Favorite?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                print("These travel's has added to favorite")
                sender.isSelected = true
                self.hasTapped.append(sender.tag)
                sender.zoomInWithEasing(duration: 0.3, easingOffset: 0.3)
                sender.setImage(self.favoriteImageFill, for: .selected)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertController, animated: true, completion: nil)            
        }
        
    }
    
}

// MARK: - Diffable Data Source Setup

extension TravelsVC {
    private func diffableDataSource() {
        guard let collectView = collectionView else { return }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Travel>(collectionView: collectView, cellProvider: { (_, indexPath, app) in
            let section = self.sections[indexPath.section]
            switch section.type {
            case "smallTable":
                return self.configureCells(SmallTableCell.self, with: app, for: indexPath)
            case "mediumTable":
                return self.configureCells(MediumTableCell.self, with: app, for: indexPath)
            default :
                let featureCell = self.configureCells(FeaturedTableCell.self, with: app, for: indexPath)
                print(self.hasTapped)
                print(indexPath.row)
                for n in self.hasTapped {
                    if n == indexPath.row {
                        print("Got a travel's \(section.items[indexPath.row])")
                        featureCell.favoriteButton.isSelected = true
                        featureCell.favoriteButton.zoomInWithEasing(duration: 0.3, easingOffset: 0.3)
                        featureCell.favoriteButton.setImage(self.favoriteImageFill, for: .selected)
                    }
                }
                featureCell.favoriteButton.tag = indexPath.row
                featureCell.favoriteButton.addTarget(self, action: #selector(self.didTapFavoriteButton(_:)), for: .touchUpInside)                
                return featureCell
            }
            
        })
        
        /// Configuring supplementary view provider for section header
        dataSource?.supplementaryViewProvider = { collectionView, kind, IndexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.identifier, for: IndexPath) as? SectionHeaderReusableView else { fatalError("Unable to dequeu") }
            
            guard let firstItem = self.dataSource?.itemIdentifier(for: IndexPath),
                  let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: firstItem) else { return nil }
            
            if section.title.isEmpty {
                return nil
            }
            
            sectionHeader.title.text = section.title
            sectionHeader.subtitle.text = section.subtitle

            return sectionHeader
        }
        
    }
    
    private func appendingDiffableDataSourceSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Travel>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
}

// MARK: - Compositional Layout Setup

extension TravelsVC {
    private func createFeatureLayout(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .estimated(300))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])
        
        let layoutSection = NSCollectionLayoutSection(group: groupLayout)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return layoutSection
    }
    
    private func createMediumTableLayout(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .fractionalWidth(0.87))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])
        
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.interGroupSpacing = 15
        sectionLayout.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let sectionHeaderLayout = createSectionHeaderLayout()
        sectionLayout.boundarySupplementaryItems = [sectionHeaderLayout]
        
        return sectionLayout
    }
    
    private func createSmallTableLayout(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.30))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50),
                                               heightDimension: .estimated(200))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [itemLayout])
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let layoutSectionHeader = createSectionHeaderLayout()
        section.boundarySupplementaryItems = [layoutSectionHeader]
        
        return section
    }
    
    private func createSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
}

// MARK: - Collection View Delegate

extension TravelsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        print("Selected item at \(sections[indexPath.section].items[indexPath.row])\n \(indexPath.row)")
        
    }
    
}
