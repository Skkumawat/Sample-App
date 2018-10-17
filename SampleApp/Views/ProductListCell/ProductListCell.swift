//
//  ProductListCell.swift
//  SampleApp
//
//  Created by Sharvan  Kumawat on 9/30/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
extension ProductListCell {
    /**
     Creates a function set the delegate and datasource of the collection view and reload data for the collection view using the generic fuction
     
     - Parameter: dataSourceDelegate & forRow
     
     - Throws:
     
     - Returns: 
     */
    func setCollectionViewDataSourceDelegate<T: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: T, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
}

