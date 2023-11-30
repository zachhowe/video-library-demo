//
//  Video.swift
//  VideoLibrary
//
//  Created by Zach Howe on 11/30/23.
//

import Foundation

struct Video {
    let name: String
    let videoUrl: URL
}

extension Video {
    static var all: [Video] {
        [
            Video(
                name: "A Beach",
                videoUrl: URL(string: "http://playgrounds-cdn.apple.com/assets/beach/index.m3u8")!
            ),
            Video(
                name: "By the Lake",
                videoUrl: URL(string: "http://playgrounds-cdn.apple.com/assets/lake/index.m3u8")!
            ),
            Video(
                name: "Camping in the Woods",
                videoUrl: URL(string: "http://playgrounds-cdn.apple.com/assets/camping/index.m3u8")!
            ),
            Video(
                name: "Mystery Creek",
                videoUrl: URL(string: "http://playgrounds-cdn.apple.com/assets/creek/index.m3u8")!
            ),
            Video(
                name: "The Rolling Hills",
                videoUrl: URL(string: "http://playgrounds-cdn.apple.com/assets/hillside/index.m3u8")!
            ),
            Video(
                name: "Ocean Breeze",
                videoUrl: URL(string: "http://playgrounds-cdn.apple.com/assets/ocean/index.m3u8")!
            ),
        ]
    }
}
