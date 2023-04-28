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

    var position = CGPoint.zero
    var velocity = CGPoint(x: 1, y: 1)

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        // Set up the clock label
        clockLabel.stringValue = getCurrentTime()
        clockLabel.font = NSFont.systemFont(ofSize: 100)
        clockLabel.textColor = NSColor.white
        clockLabel.backgroundColor = NSColor.clear
        clockLabel.isEditable = false
        clockLabel.isSelectable = false
        clockLabel.isBordered = false
        clockLabel.sizeToFit()
        
        // Add the clock label to the view
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
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: Date())
    }
    
    override func animateOneFrame() {
        // Update the position and velocity of the clock label
        position.x += velocity.x
        position.y += velocity.y
        
        // Bounce off the edges of the screen
        if position.x < 0 || position.x + clockLabel.frame.width > frame.width {
            velocity.x *= -1
            clockLabel.textColor = NSColor.random()
        }
        if position.y < 0 || position.y + clockLabel.frame.height > frame.height {
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
