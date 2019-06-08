//
//  StoryEditViewController.swift
//  Journey
//
//  Created by Aaron Tong on 5/31/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit
import AVFoundation
import YPImagePicker

class StoryEditViewController: UIViewController {
    @IBOutlet var toolbarView: UIView!
    @IBOutlet weak var story: UITextView!
    @IBOutlet weak var media: UICollectionView!
    @IBOutlet weak var location: UILabel!
    
    let notePlaceholder = NSLocalizedString("What's your story?", comment: "Placeholde text")
    
    var images: [UIImage] = []
    
    override var canBecomeFirstResponder: Bool{
        get {
            return true
        }
    }
    
    override var inputAccessoryView: UIView {
        get {
            return self.toolbarView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        story.inputAccessoryView = toolbarView
        story.text = notePlaceholder
        story.textColor = UIColor.lightGray
        story.delegate = self
        media.dataSource = self
        media.delegate = self
        
        becomeFirstResponder()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoPickerAction(_ sender: Any) {
        // Show the image picker
        var config = YPImagePickerConfiguration()
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = true
        config.showsFilters = false
        config.shouldSaveNewPicturesToAlbum = false
        config.albumName = "Journey"
        config.startOnScreen = YPPickerScreen.library
        config.screens = [.library, .photo]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.cappedTo(size: 1920)
        config.overlayView = UIView()
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = .lightContent
        
        config.library.options = nil
        config.library.onlySquare = false
        config.library.minWidthForItem = nil
        config.library.mediaType = .photo
        config.library.maxNumberOfItems = 8
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = true
        
        config.video.compression = AVAssetExportPresetMediumQuality
        config.video.fileType = .mov
        config.video.recordingTimeLimit = 30.0
        config.video.libraryTimeLimit = 30.0
        config.video.minimumTimeLimit = 3.0
        config.video.trimmerMaxDuration = 30.0
        config.video.trimmerMaxDuration = 3.0
        
        // build a pciker
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            self.images = []
            for item in items {
                switch item {
                case .photo(let photo):
                    print(photo.fromCamera)
                    print(photo.image)
                    
                    self.images.append(photo.image)
                
                
                case .video(let video):
                    print(video)
                }
            }
            
            self.refreshMediaWindow()
            //close picker
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true)
    }
    
    // MARK: - Navigation
    
    func refreshMediaWindow() {
        if (images.count > 0) {
            media.backgroundColor = .white
        }
        else{
            media.backgroundColor = .lightGray
        }
        
        media.reloadData()
    }
}

extension StoryEditViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("shouldChangeTextIn called")
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // if updated text view is empty, add the placeholder and set the cursor to the begining of the text view
        if updatedText.isEmpty {
            textView.text = notePlaceholder
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = .black
            textView.text = text
        }
        
        else {
            return true
        }
        
        return false
    }
}

// MARK: - CollectionView stuff
extension StoryEditViewController: UICollectionViewDelegate {
    
}

extension StoryEditViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! StoryEditThumbnailCell
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.picture.image = images[indexPath.row]
        
        cell.picture.layer.cornerRadius = 12.0
        cell.picture.clipsToBounds = true
        
        return cell
    }
}

extension StoryEditViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = images[indexPath.row]
        
        let s = image.size
        let w = (s.width/s.height) * 200
        
        print("w \(w), h \(200)")
        
        return CGSize(width: w, height: 200)
    }
}

extension StoryEditViewController : StoryEditDelegate{
    func mediaDeleted(index: Int) {
        print("Deleted media: \(index)")
        
        images.remove(at: index)
        refreshMediaWindow()
    }
}
