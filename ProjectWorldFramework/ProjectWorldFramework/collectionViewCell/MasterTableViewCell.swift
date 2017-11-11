//
//  MasterTableViewCell.swift
//  ProjectWorldFramework
//
//  Created by Naga Murala on 9/27/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import Foundation
import UIKit

open class MasterTableViewCell: UITableViewCell {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //method is used to customize UITableViewCell
    open func configureCell(item: Any, tableView:UITableView ,indexPath:IndexPath, cell: UITableViewCell = UITableViewCell()) -> UITableViewCell {
        return cell
    }
}
