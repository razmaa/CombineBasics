

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        Text("Check console output")
            .onAppear {
                _ = Just("Hello, Combine!")
                    .sink { value in
                        print(value)
                    }
            }
    }
}


