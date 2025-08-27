
import SwiftUI
import Combine

struct DebounceContentView: View {
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        Text("Check console after typing simulation")
            .onAppear {
                let typingSequence = ["H", "He", "Hel", "Hello"].publisher
                
                cancellable = typingSequence
                    .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                    .sink { print($0) }
            }
    }
}
