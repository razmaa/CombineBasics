

import SwiftUI
import Combine

struct FlatMapContentView: View {
    private let subject = PassthroughSubject<Int, Never>()
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        Text("Check console output")
            .onAppear {
                cancellable = subject
                    .flatMap { number in
                        Just(number * number)
                    }
                    .sink { print($0) }
                
                subject.send(2)
                subject.send(3)
                subject.send(4)
            }
    }
}
