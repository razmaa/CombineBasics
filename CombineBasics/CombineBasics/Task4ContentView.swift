
import SwiftUI
import Combine

struct PassthroughContentView: View {
    private let subject = PassthroughSubject<Int, Never>()
    
    var body: some View {
        Text("Check console output")
            .onAppear {
                _ = subject
                    .filter { $0 % 2 == 0 }
                    .sink { print($0) }
                
                subject.send(1)
                subject.send(2)
                subject.send(3)
                subject.send(4)
            }
    }
}
