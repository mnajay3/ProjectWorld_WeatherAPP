//
//  MasterCollectionView.swift
//  ProjectWorldFramework
//
//  Created by Naga Murala on 11/27/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import UIKit

public protocol MMCollectionItemDelegate {
    func itemSelected(_ sender: Any, item: Any, itemIdentifier: String?, indexPath: IndexPath)
}

open class MasterCollectionViewCellFactory: NSObject {
    public var cellCreator: ((Any, IndexPath) -> UICollectionViewCell)?
    override init() {
        super.init()
    }
    public init(cellCreator: @escaping (Any, IndexPath) -> UICollectionViewCell) {
        self.cellCreator = cellCreator
    }
    public func createCell(item: Any, indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cellCreator = self.cellCreator else { return UICollectionViewCell() }
        return cellCreator(item, indexPath)
    }
}

open class MasterCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public var list: [Int: [Any]] = [Int:[Any]]()
    public var collectionItemDelegate: MMCollectionItemDelegate?
    public var cellFactory: MasterCollectionViewCellFactory = MasterCollectionViewCellFactory()
    
    let defaultCell       = "defaultCell"
    let defaultHeaderCell = "defaultHeaderCell"
    let defaultFooterCell = "defaultFooterCell"
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.delegate = self
        self.dataSource = self
        
        self.register(MasterCollectionViewCell.self, forCellWithReuseIdentifier: defaultCell)
        self.register(MasterCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader   , withReuseIdentifier: defaultHeaderCell)
        self.register(MasterCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: defaultFooterCell)
        
        cellFactory.cellCreator = self.createCellConfiguration
        self.showsHorizontalScrollIndicator = false
    }
    
    public func createCellConfiguration (item: Any, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: defaultCell, for: indexPath)
        return MasterCollectionViewCell().configureCell(cell: cell, collectionView: self, item: item, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemsInSection = self.list[section] else { return 0 }
        return itemsInSection.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.list.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let listSecion = self.list[indexPath.section] else { return MasterCollectionViewCell() }
        let item = listSecion[indexPath.item]
        return self.cellFactory.createCell(item:item, indexPath:indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = list[indexPath.section]?[indexPath.item] else { return  }
        guard let itemDelegate = collectionItemDelegate else { return }
        guard let cell = cellForItem(at: indexPath)?.description else { return }
        itemDelegate.itemSelected(collectionView, item: item, itemIdentifier: cell, indexPath: indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind
        kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            print("It's Header")
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: defaultHeaderCell, for: indexPath)
            reusableView?.backgroundColor = .gray
            
        }
        else if kind == UICollectionElementKindSectionFooter {
            print("It's Footer")
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: defaultFooterCell, for: indexPath)
            reusableView?.backgroundColor = .cyan
        }
        return reusableView!
    }
    //MARK:- Mandatory methods to set Header | Footer
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    //MARK:- Overridable flowlayout delegate methods
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
