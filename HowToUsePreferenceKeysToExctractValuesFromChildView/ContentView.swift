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
                    .customTitle("New Value")
                    //.preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
    }
}

extension View {
    
    func customTitle(_ text: String) -> some View {
        self
            .preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SecondaryScreen: View {
    
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear {
                getDataFromDatabase()
            }
            .customTitle(newValue)
    }
    
    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW VALUE FROM DB"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
