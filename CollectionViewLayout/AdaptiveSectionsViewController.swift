//
//  ViewController.swift
//  CollectionViewLayout
//
//  Created by Дарья Носова on 14.03.2022.
//

import UIKit

class AdaptiveSectionsViewController: UIViewController {

    enum Section {
        case main
    }
//    enum Section: Int, CaseIterable {
//        case list
//        case grid3
//        case grid5
//
//        func columnCount(for width: CGFloat) -> Int {
//            let wideMode = width > 700
//            switch self {
//            case .list:
//                return wideMode ? 2 : 1
//            // если экран в горизонтальном положении, то будет 2 колонки, а если в вертикальном то 1 колонка
//            case .grid3:
//                return wideMode ? 6 : 3
//            case .grid5:
//                return wideMode ? 10 : 5
//            }
//        }
//    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 2
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/3.0),
            heightDimension: .fractionalHeight(1.0))
        // Ширина элемента равна 1/3 от ширины группы, а высота равна высоте группы
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing
        )
        // Устанавливаем contentInset у элемента, таким образом ячейка со всех сторон имеет отступ равый spacing

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0/3.0)
            // Ширина группы равна ширине секции, а высота равна 1/3 ширины  секции,
            // т.к. ширина группы совпадает с шириной секции, получаем элементы с равной шириной и высотой
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layautEnvironment) -> NSCollectionLayoutSection? in
//            // Принимает 2 параметра - первый это номер секции, второй окружение. Возвращает блок лайаут для данной секции.
//
//            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
//            // sectionKind будет равен экземпляру list, grid3 или grid5 в зависимости от индекса секции
//            let columns = sectionKind.columnCount(for: layautEnvironment.container.effectiveContentSize.width)
//            // Мы можем смотреть ширину в container.effectiveContentSize у layoutEnvironment
//            // и проставлять нужное количество колонок для секции
//
//            let itemSize = NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//            let groupHeight = layautEnvironment.traitCollection.verticalSizeClass == .compact ?
//            NSCollectionLayoutDimension.absolute(44) :
//            NSCollectionLayoutDimension.fractionalWidth(0.2)
//            // При вертикальном положении экрана verticalSizeClass будет .regular,
//            // а при горизонтальном .compact
//
//            let groupSize = NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: groupHeight)
//            let group = NSCollectionLayoutGroup.horizontal(
//                layoutSize: groupSize,
//                subitem: item,
//                count: columns)
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
//            return section
//        }
//        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        // Создаем collectionView по размеру границ экрана, на основании того layout, который вернет функция createLayout
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Добавляем autoresize при повороте экрана
        collectionView.backgroundColor = .systemBackground
        let nib = UINib(nibName: CustomCell.reuseIdentifier, bundle: nil)
        // Создаем экземпляр нашей кастомной ячейки в формате nib
        collectionView.register(nib, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
        // Регистрируем nib файл для использования при создании новых ячеек коллекции
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseIdentifier, for: indexPath) as? CustomCell else { fatalError("Cannot create the cell") }
            
            cell.textLabel.text = "\(itemIdentifier)"
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<100))
        dataSource.apply(snapshot, animatingDifferences: false)
//        let itemsPerSection = 6
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
//        Section.allCases.forEach {
//            snapshot.appendSections([$0])
//            let itemOffset = $0.rawValue * itemsPerSection
//            let itemUpperbound = itemOffset + itemsPerSection
//            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
//        }
//        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
}

