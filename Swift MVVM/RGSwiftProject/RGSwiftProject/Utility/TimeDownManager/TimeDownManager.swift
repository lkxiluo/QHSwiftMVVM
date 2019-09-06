//
//  TimeDownManager.swift
//  Zaful
//
//  Created by QianHan on 2018/6/20.
//  Copyright © 2018年 karl.luo. All rights reserved.
//

import UIKit

final class TimeDownManager: NSObject {
    override init() {
        super.init()
    }
    // countdown each time，default 1 second
    var duration: TimeInterval = 1.0
    static let timeChange      = "kTimeChangeNotice"
    private var startClockMarks: [String: TimeInterval] = [String: TimeInterval]()
    private var timeInterval: TimeInterval = 0.0
    static let shared = TimeDownManager()
    private var timer: Timer?
    
    @objc private func timeDown() {
        timeInterval += duration
        NotificationCenter.default.post(name: Notification.Name.init(TimeDownManager.timeChange), object: nil)
    }
    
    func start(_markKey key: String) -> Void {
        startClockMarks[key] = timeInterval
        if timer == nil {
            timer = Timer(timeInterval: TimeDownManager.shared.duration, target: self, selector: #selector(TimeDownManager.shared.timeDown), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
        }
    }
    
    func end(_markKey key: String) -> Void {
        startClockMarks.removeValue(forKey: key)
        if startClockMarks.count <= 0 {
            timer!.invalidate()
            timeInterval = 0.0
            timer = nil
        }
    }
    
    func timeInterval(_markKey key: String) -> TimeInterval {
        return timeInterval - startClockMarks[key]!
    }
}
