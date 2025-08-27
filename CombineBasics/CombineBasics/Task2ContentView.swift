
import SwiftUI
import Combine

struct SecondContentView: View {
    var body: some View {
        Text("Check console after 2 seconds")
            .onAppear {
                _ = Future<String, Never> { promise in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        promise(.success("Hello, Combine with Future!"))
                    }
                }
                .sink { value in
                    print(value)
                }
            }
    }
}
