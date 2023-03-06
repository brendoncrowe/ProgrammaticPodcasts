//
//  Podcast.swift
//  ProgrammaticPodcasts
//
//  Created by Brendon Crowe on 3/6/23.
//

import Foundation

struct PodcastSearch: Codable {
   let results: [Podcast]
 }

 struct Podcast: Codable {
   let artistName: String
   let collectionName: String
   let artworkUrl100: String
   let artworkUrl600: String
 }
