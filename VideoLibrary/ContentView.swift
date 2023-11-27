//
//  ContentView.swift
//  VideoLibrary
//
//  Created by Zach Howe on 11/17/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

@Observable
final class ContentModel {
    let width: CGFloat = 1800
    let height: CGFloat = 1000

    var position = CGPoint(x: 100, y: 100)

    @ObservationIgnored var distanceToMove: CGFloat = 100
    @ObservationIgnored var objectSize: CGFloat = 100

    @ObservationIgnored var angle: CGFloat = .pi / 7

    func _onTapInner() {
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

    func onTap() {
        withAnimation {
            _onTapInner()
        }
    }
}

struct ContentView: View {
    var model: ContentModel

    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .position(model.position)
                .onTapGesture {
                    model.onTap()
                }
        }
        .frame(width: model.width, height: model.height)
        .fixedSize(horizontal: true, vertical: true)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView(model: ContentModel())
}
