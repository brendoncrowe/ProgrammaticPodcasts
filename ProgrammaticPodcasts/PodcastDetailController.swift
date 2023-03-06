//
//  PodcastDetailController.swift
//  ProgrammaticPodcasts
//
//  Created by Brendon Crowe on 3/6/23.
//

import UIKit

class PodcastDetailController: UIViewController {
    
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastNameLabel: UILabel!
    
    var podcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    private func updateUI() {
        if let podcast = podcast {
            podcastImageView.getImage(with: podcast.artworkUrl600) { [weak self] result in
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
            podcastNameLabel.text = podcast.collectionName
            podcastImageView.layer.borderWidth = 3
            podcastImageView.layer.cornerRadius = 24
        }
    }
}
