//
//  EdgeBorder.swift
//  Covid19StatsWidgetExtension
//
//  Created by Alfian Losari on 24/08/20.
//

import SwiftUI

extension View {
    func border(width: CGFloat, edge: Edge, color: Color) -> some View {
        ZStack {
            self
            EdgeBorder(width: width, edge: edge).foregroundColor(color)
        }
    }
}

struct EdgeBorder: Shape {
    
    var width: CGFloat
    var edge: Edge
    
    func path(in rect: CGRect) -> Path {
        var x: CGFloat {
            switch edge {
            case .top, .bottom, .leading: return rect.minX
            case .trailing: return rect.maxX - width
            }
        }
        
        var y: CGFloat {
            switch edge {
            case .top, .leading, .trailing: return rect.minY
            case .bottom: return rect.maxY - width
            }
        }
        
        var w: CGFloat {
            switch edge {
            case .top, .bottom: return rect.width
            case .leading, .trailing: return self.width
            }
        }
        
        var h: CGFloat {
            switch edge {
            case .top, .bottom: return self.width
            case .leading, .trailing: return rect.height
            }
        }
        
        return Path( CGRect(x: x, y: y, width: w, height: h) )
    }
}
