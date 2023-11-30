//
//  VideoPlayerView.swift
//  VideoLibrary
//
//  Created by Zach Howe on 11/30/23.
//

import SwiftUI
import AVFoundation

struct VideoPlayerView: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> ViewController {
        let controller = ViewController()
        controller.playerLayer.player = player
        return controller
    }

    func updateUIViewController(_ controller: ViewController, context: Context) {
        controller.playerLayer.player = player
    }
}

extension VideoPlayerView {
    final class ViewController: UIViewController {
        lazy var playerLayer = AVPlayerLayer()

        init() {
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.layer.addSublayer(playerLayer)
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            playerLayer.frame = view.layer.bounds
        }
    }
}
