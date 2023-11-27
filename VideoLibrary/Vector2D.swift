//
//  Vector2D.swift
//  VideoLibrary
//
//  Created by Zach Howe on 11/26/23.
//

import Foundation

struct Vector2D {
    let angle: CGFloat
    let distance: CGFloat
}

extension CGPoint {
    func moveByVector(_ vector2d: Vector2D) -> Self {
        ///If p is your point, D is the distance, and θ is the heading-angle from the X-axis,

        ///pnew.x = pold.x + D * cos(θ)
        ///pnew.y = pold.y + D * sin(θ)

        var pnew = CGPoint.zero
        pnew.x = x + vector2d.distance * cos(vector2d.angle)
        pnew.y = y + vector2d.distance * sin(vector2d.angle)

        return pnew
    }
}
