//
//  ContentView.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 01/08/20.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
        Button("Reload all timelines") {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
