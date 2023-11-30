//
//  ContentView.swift
//  VideoLibrary
//
//  Created by Zach Howe on 11/17/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import AVFoundation

@Observable
final class ContentModel {
    let width: CGFloat = 1800
    let height: CGFloat = 1000

    var position = CGPoint(x: 100, y: 100)
    var videoIndex: Int = 0
    var isMuted: Bool = false

    var currentVideo: Video?

    init() {
        debugPrint("[ZACH] ContentModel init")
    }

    @ObservationIgnored var player = AVPlayer()

    @ObservationIgnored var distanceToMove: CGFloat = 100
    @ObservationIgnored var objectSize: CGFloat = 100

    @ObservationIgnored var angle: CGFloat = .pi / 7

    func onAppear() {
        playVideo(Video.all[0])
    }

    func onTap() {
        withAnimation {
            var newPosition = position.moveByVector(Vector2D(angle: angle, distance: distanceToMove))

            if newPosition.x < objectSize || newPosition.x > (width - objectSize) {
                angle = .pi - angle
                newPosition = position.moveByVector(Vector2D(angle: angle, distance: distanceToMove))
            } else if newPosition.y < objectSize || newPosition.y > (height - objectSize) {
                angle = 2 * .pi - angle
                newPosition = position.moveByVector(Vector2D(angle: angle, distance: distanceToMove))
            }

            position = newPosition
        }
    }

    func toggleMuteButtonTapped() {
        player.isMuted = !player.isMuted
        isMuted = player.isMuted
    }

    func nextVideoButtonTapped() {
        videoIndex += 1

        if videoIndex >= Video.all.count {
            // restart from the first video after the end
            videoIndex = 0
        }

        let nextVideo = Video.all[videoIndex]
        playVideo(nextVideo)
    }

    private func playVideo(_ newVideo: Video) {
        let playerItem = AVPlayerItem(url: newVideo.videoUrl)

        player.replaceCurrentItem(with: playerItem)
        player.play()

        currentVideo = newVideo
    }
}

struct ContentView: View {
    var model: ContentModel

    var body: some View {
        VideoPlayerView(player: model.player)
            .overlay {
                VStack {
                    Button {
                        model.nextVideoButtonTapped()
                    } label: {
                        Label(
                            title: { Text("Next Video") },
                            icon: { Image(systemName: "play") }
                        )
                    }

                    Button {
                        model.toggleMuteButtonTapped()
                    } label: {
                        Label(
                            title: { model.isMuted ? Text("Unmute") : Text("Mute") },
                            icon: { model.isMuted ? Image("speaker.fill") : Image(systemName: "speaker.3.fill") }
                        )
                    }
                }

                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .position(model.position)
                    .onTapGesture {
                        model.onTap()
                    }
            }
            .ornament(attachmentAnchor: .scene(.top), ornament: {
                if let currentVideo = model.currentVideo {
                    Text(currentVideo.name)
                        .font(.extraLargeTitle)
                }
            })
            .onAppear(perform: model.onAppear)
            .frame(width: model.width, height: model.height)
            .fixedSize(horizontal: true, vertical: true)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView(model: ContentModel())
}
