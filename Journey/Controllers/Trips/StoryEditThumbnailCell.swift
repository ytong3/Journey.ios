//
//  StoryEditsUICollectionViewCell.swift
//  Journey
//
//  Created by Yue Tong on 6/7/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit

class StoryEditThumbnailCell: UICollectionViewCell {
    @IBOutlet weak var picture: UIImageView!
    var delegate: StoryEditDelegate?
    var index: Int = 0
}

protocol StoryEditDelegate {
    func mediaDeleted(index: Int)
}
