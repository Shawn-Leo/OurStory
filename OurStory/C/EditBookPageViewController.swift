//
//  EditBookPageViewController.swift
//  OurStory
//
//  Created by Momo on 2020/9/2.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class EditBookPageViewController: UIViewController {
    
    @IBOutlet weak var editToolBar: UIToolbar!
    @IBOutlet weak var bgBarButton: UIBarButtonItem!
    @IBOutlet weak var stickerBarButton: UIBarButtonItem!
    @IBOutlet weak var imageBarButton: UIBarButtonItem!
    
    var stickerCollectionView: UICollectionView!
    var stickerCollectionViewLayout: UICollectionViewFlowLayout!
    
    var stickers: [String]? {
        // store the name of tickers
        didSet {
            stickerCollectionView?.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStickers(plist: "Stickers")
        setupToolBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupStickerCollectionViewLayout()
    }
    
    private func setupNavBar() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UICollectionViewDelegate

extension EditBookPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // for stickers
        print("didSelect \(stickers![indexPath.row])")
    }
}

// MARK: UICollectionViewDataSource
extension EditBookPageViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // for stickers
        if let stickers = stickers {
            return stickers.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // for stickers
        let cell = stickerCollectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
        
        cell.stickerImageView.image = UIImage(named: stickers![indexPath.row])
        return cell
    }
}

// MARK: Sticker helper
extension EditBookPageViewController {
    
    private func setupStickerCollectionViewLayout() {
        if stickerCollectionViewLayout == nil {
            stickerCollectionViewLayout = UICollectionViewFlowLayout()
            
            let numberOfStickerPerRow: CGFloat = 4
            let lineSpacing: CGFloat = 5
            let interStickerSpacing: CGFloat = 5
            
            // Note the cornerRadius
            var stickerWidth: CGFloat = self.view.bounds.width - (numberOfStickerPerRow - 1) * interStickerSpacing - 20
            stickerWidth = stickerWidth / numberOfStickerPerRow
            let stickerHeight = stickerWidth
            
            stickerCollectionViewLayout.scrollDirection = .vertical
            stickerCollectionViewLayout.itemSize = CGSize(width: stickerWidth, height: stickerHeight)
            stickerCollectionViewLayout.minimumInteritemSpacing = lineSpacing
            stickerCollectionViewLayout.minimumInteritemSpacing = interStickerSpacing
            stickerCollectionViewLayout.sectionInset = UIEdgeInsets(
                  top: 10,
                  left: 10,
                  bottom: 0,
                  right: 10
            )
        }
    }
    
    private func setupStickerCollectionView(){
        if stickerCollectionView == nil {
            
            // - 有问题，一开始没有全部初始化，一部分内容被截掉了
            stickerCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: self.view.bounds.height - editToolBar.bounds.height - self.view.safeAreaInsets.bottom - 200 - 5, width: self.view.bounds.width, height: 200),
            collectionViewLayout: stickerCollectionViewLayout)
            
            // Set up properties
            stickerCollectionView.backgroundColor = .black
            let corners: UIRectCorner = [.topLeft, .topRight]
            stickerCollectionView.clickCorner(corners: corners, cornerRadius: 10)
            
            stickerCollectionView.delegate = self
            stickerCollectionView.dataSource = self
            let stickerNib = UINib(nibName: "StickerCell", bundle: nil)
            stickerCollectionView.register(stickerNib, forCellWithReuseIdentifier: "StickerCell")
            
        }
    }
    
    private func loadStickers(plist: String) {
        stickers = [String]()
        if let path = Bundle.main.path(forResource: plist, ofType: "plist") {
            // Get data from plist file
            let rawData = try! Data(contentsOf: URL(fileURLWithPath: path))
            if let array = try! PropertyListSerialization.propertyList(from: rawData, format: nil) as? NSArray {
                for string in array as! [String] {
                    // Create stickers
                    stickers! += [string]
                }
            }
        }
    }
    
    
}

// MARK: Toolbar helper
extension EditBookPageViewController {
    private func setupToolBar() {
        bgBarButton.action = #selector(btn_bgClick)
        stickerBarButton.action = #selector(btn_stickerClick)
        imageBarButton.action = #selector(btn_imageClick)
    }
    
    @objc private func btn_bgClick(){
        print("bg click")
    }
    
    @objc private func btn_stickerClick(){
        print("sticker click")
        setupStickerCollectionView()
        self.view.addSubview(stickerCollectionView)
    }
    
    @objc private func btn_imageClick(){
        print("image click")
    }
}
