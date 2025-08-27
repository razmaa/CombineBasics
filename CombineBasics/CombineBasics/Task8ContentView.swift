
import SwiftUI
import Combine

class Loader: ObservableObject {
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $isLoading
            .sink { print("Loading state changed:", $0) }
            .store(in: &cancellables)
    }
}

struct LoaderContentView: View {
    @StateObject private var loader = Loader()
    
    var body: some View {
        VStack {
            Button("Toggle Loading") {
                loader.isLoading.toggle()
            }
        }
    }
}
