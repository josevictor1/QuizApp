//
//  CountdownTimer.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 28/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public class CountdownTimer {
    
    // MARK: - Properties
    
    private var timer: Timer?

    private var timeLimit: Double
    private var startTime: Double
    private var currentTime: Double = .zero
        
    public var onStart: (() -> Void)?
    public var onStop: (() -> Void)?
    public var onTick: ((Double) -> Void)?
    public var onFinish: (() -> Void)?
    
    // MARK: - Initializer

    /// Intitialize timer object with a start time and end time
    /// - Parameter startTime: the initial value that time counter will start with
    /// - Parameter endTime: the limit value that time counter can reach
    public init(startTime: Double = .zero, timeLimit: Double = .zero) {
        self.startTime = startTime
        self.timeLimit = timeLimit
    }
    
    /// Creates a timer and schedules it on the current run loop in the default mode, passing a handler for each tick and a handler when stop
    /// - Parameter timeInterval: The number of seconds between firings of the timer.
    /// - Parameter repeats: If true, the timer will repeatedly reschedule itself until invalidated. If false, the timer will be invalidated after it fires.
    public func schedule(timeInterval: Double = 1, repeats: Bool = true) {
        currentTime = startTime
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: { [unowned self] _ in
            guard self.currentTime > self.timeLimit else {
                self.finish()
                return
            }
            
            self.currentTime -= 1
            self.onTick?(self.currentTime)
        })
    }
    
    /// Called when timer stops
    public func stop() {
        onStop?()
        onTick?(startTime)
        timer?.invalidate()
    }
    
    /// Called when timer finish
    public func finish() {
        onFinish?()
        onTick?(startTime)
        timer?.invalidate()
    }
    
    /// Called when timer start
    public func start() {
        onStart?()
        schedule()
    }
    
}
