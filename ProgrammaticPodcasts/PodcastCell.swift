//
//  PodcastCell.swift
//  ProgrammaticPodcasts
//
//  Created by Brendon Crowe on 3/6/23.
//

import UIKit
import ImageKit

class PodcastCell: UICollectionViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastNameLabel: UILabel!
    @IBOutlet weak var podcastCollectionLabel: UILabel!
    
    
    func configureCell(for podcast: Podcast) {
        podcastNameLabel.text = podcast.artistName
        podcastCollectionLabel.text = podcast.collectionName
        podcastImageView.getImage(with: podcast.artworkUrl100) { [weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.podcastImageView.image = UIImage(systemName: "mic.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImageView.image = image
                }
            }
        }
        podcastImageView.layer.cornerRadius = 8
    }
    
    
}
