
import SwiftUI
import Combine

struct DoublePublisherContentView: View {
    var body: some View {
        Text("Check console output")
            .onAppear {
                let namePublisher = Just("john")
                    .map { $0.uppercased() }
                
                let surnamePublisher = Just("doe")
                    .map { $0.capitalized }
                
                _ = namePublisher
                    .combineLatest(surnamePublisher)
                    .map { "\($0) \($1)" }
                    .sink { print($0) }
            }
    }
}
