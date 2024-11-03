//
//  PlaybackSettingsViewModel.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//


@MainActor
protocol PlaybackSettingsViewModel {
    var fpsSliderModel: SliderViewModel { get }
}
