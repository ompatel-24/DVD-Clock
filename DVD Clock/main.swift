//
//  main.swift
//  DVD Clock
//
//  Created by Om Patel on 2023-04-27.
//

import Foundation
import ScreenSaver

class MyScreenSaverView: ScreenSaverView {
    
    let clockLabel = NSTextField()
    let backgroundView = NSView()

    var position = CGPoint.zero
    var velocity = CGPoint(x: 3, y: 2)

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        // Set up the clock label
        clockLabel.stringValue = getCurrentTime()
        clockLabel.font = NSFont.systemFont(ofSize: 100)
        clockLabel.textColor = NSColor.white
        clockLabel.isEditable = false
        clockLabel.isSelectable = false
        clockLabel.isBordered = false
        clockLabel.sizeToFit()
        
        // Set up the background view
        backgroundView.frame = clockLabel.frame.insetBy(dx: -20, dy: -20)
        backgroundView.wantsLayer = true
        backgroundView.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.3).cgColor
        backgroundView.layer?.cornerRadius = 100
        
        // Add the clock label and background view to the view
        self.addSubview(backgroundView)
        self.addSubview(clockLabel)
        
        // Set the animation time interval to 60 Hertz
        animationTimeInterval = 1.0/120.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: NSRect) {
        // Draw the background
        NSColor.black.setFill()
        NSBezierPath.fill(bounds)
    }
        
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: Date()) + " " + "PM"
    }
    
    override func animateOneFrame() {
        // Update the position and velocity of the clock label
        position.x += velocity.x
        position.y += velocity.y
        
        // Bounce off the edges of the screen
        if position.x < 0 || position.x + clockLabel.frame.width >= frame.width {
            velocity.x *= -1
            clockLabel.textColor = NSColor.random()
        }
        if position.y < 0 || position.y + clockLabel.frame.height >= frame.height {
            velocity.y *= -1
            clockLabel.textColor = NSColor.random()
        }
        
        // Set the new position of the clock label
        clockLabel.frame.origin = position
        
        // Update the clock label text
        clockLabel.stringValue = getCurrentTime()
    }
}

extension NSColor {
    static func random() -> NSColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        repeat {
            red = CGFloat.random(in: 0...1)
            green = CGFloat.random(in: 0...1)
            blue = CGFloat.random(in: 0...1)
        } while (red + green + blue < 1.5) // exclude black and grey
        
        return NSColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
