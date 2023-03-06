//
//  PodcastViewController.swift
//  ProgrammaticPodcasts
//
//  Created by Brendon Crowe on 3/6/23.
//

import UIKit

class PodcastViewController: UIViewController {
    
    private let podcastView = PodcastView()
    
    private var podcasts = [Podcast]() {
        didSet {
            podcastView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = podcastView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Podcasts"
        podcastView.collectionView.dataSource = self
        podcastView.collectionView.delegate = self
        // register collection view cell
        // UICollectionViewCell.self is the default cell
        podcastView.collectionView.register(UINib(nibName: "PodcastCell", bundle: nil), forCellWithReuseIdentifier: "podcastCell")
        fetchPodcasts()
    }
    
    private func fetchPodcasts(_ name: String = "Swift") {
        PodcastAPIClient.fetchPodcasts(with: name) { [weak self] result in
            switch result {
            case .failure(let appError):
                print("error fetching podcasts: \(appError)")
            case .success(let podcasts):
                DispatchQueue.main.async {
                    self?.podcasts = podcasts
                }
            }
        }
    }
}

extension PodcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count - 175
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            fatalError("could not dequeue a PodcastCell")
        }
        let podcast = podcasts[indexPath.row]
        cell.configureCell(for: podcast)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        return cell
    }
}

extension PodcastViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // override the default values of the itemSize layout from the collectionView property initializer in the PodcastView
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.95 // 95% of the width of the device
        return CGSize(width: itemWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = podcasts[indexPath.row]
        
        let podcastDetailVC = UIStoryboard(name: "PodcastDetail", bundle: nil)
        
        guard let podcastDetailController = podcastDetailVC.instantiateViewController(withIdentifier: "PodcastDetailController") as? PodcastDetailController else {
            fatalError("could not load PodcastDetailController")
        }
        podcastDetailController.podcast = podcast
        navigationController?.pushViewController(podcastDetailController, animated: true)
    }
}
