//
//  MasterCollectionViewCell.swift
//  ProjectWorldFramework
//
//  Created by Naga Murala on 11/29/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import UIKit

open class MasterCollectionViewCell: UICollectionViewCell {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    public func initialize() {
//        self.backgroundColor = .red
        //NOOP
    }
    
    public func configureCell(cell: UICollectionViewCell , collectionView: UICollectionView, item: Any, indexPath: IndexPath ) -> UICollectionViewCell {
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .blue
        }
        return cell
    }
    
    
    
    
}
