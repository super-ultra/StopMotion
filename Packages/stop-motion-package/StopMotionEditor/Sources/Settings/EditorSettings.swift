//
//  EditorSettings.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 02.11.2024.
//

import Observation


protocol EditorSettings: AnyObject, Observable {
    var animationFPS: Int { get set }
}
