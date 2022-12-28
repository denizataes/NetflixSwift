//
//  CollectionViewTableViewCell.swift
//  NetflixSwift
//
//  Created by Deniz Ata Eş on 22.12.2022.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject{
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var titles: [Movie] = [Movie]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [Movie]){
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
    }
    
}
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
        guard let model = titles[indexPath.row].posterPath else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.originalTitle else{
            return
        }
        
        APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] result in
            switch(result)
            {
            case.success(let videoElement):
                let title = self?.titles[indexPath.row]
                guard let titleOverview = title?.overview else {return}
                
                guard let strongSelf = self else{return}
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            case.failure(let error):
                print(error)
            }
        }
        
        
        
        
        
    }
    
    
}
