//
//  ContentView.swift
//  HowToUsePreferenceKeysToExctractValuesFromChildView
//
//  Created by ramil on 28.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text: String = "Hello, world!"
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text)
                    .navigationTitle("Navigation Title")
                    .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SecondaryScreen: View {
    
    let text: String
    
    var body: some View {
        Text(text)
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
