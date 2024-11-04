//
//  ShapeType.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//


public enum ShapeType: CaseIterable {
    case circle
    case square
    case triangle
    case star
}


extension ShapeType {
    public static func random() -> ShapeType {
        allCases.randomElement() ?? .circle
    }
}
