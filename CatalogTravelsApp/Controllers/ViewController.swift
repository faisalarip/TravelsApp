//
//  ViewController.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 20/12/20.
//

import UIKit

class TopPopularVC: UIViewController {
    
    let sections = Bundle.main.decode([Section].self, from: "TravelsData.json")
    
    var collectionView: UICollectionView? = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, App>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionlayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = .systemBackground
        guard let collectView = collectionView else { return }
        view.addSubview(collectView)
        
        registeredCells()
        diffableDataSource()
        reloadDiffableData()
    }
    
    private func registeredCells() {
        collectionView?.register(TopPopularCell.self, forCellWithReuseIdentifier: TopPopularCell.reuseableIdentifier)
    }
    
    private func diffableDataSource() {
        guard let collectView = collectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectView, cellProvider: { (collectionView, indexPath, app) in
            
            switch self.sections[indexPath.section].type {
            case "Top Popular":
                return self.configureCells(TopPopularCell.self, with: app, for: indexPath)
            default :
                return self.configureCells(TopPopularCell.self, with: app, for: indexPath)
            }
            
        })
        
    }
    
    private func reloadDiffableData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func configureCells<T: ConfiguringCell>(_ cellType: T.Type, with app: App, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: cellType.reuseableIdentifier, for: indexPath) as? T else { fatalError("Unable dequeu cells") }
        
        cell.configureCellLayout(with: app)
        
        return cell
    }
    
    private func createCompositionlayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section = self.sections[sectionIndex]
            switch section.type {
            case "Top Popular":
                return self.createTopPopularLayout(using: section)
            default:
                return self.createTopPopularLayout(using: section)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config
        
        return layout
    }
    
    private func createTopPopularLayout(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .estimated(250))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])
        
        let layoutSection = NSCollectionLayoutSection(group: groupLayout)
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        return layoutSection
    }
}

