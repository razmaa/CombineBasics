

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    let buttonPressed = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var count = 0
    
    init() {
        buttonPressed
            .sink { [weak self] in
                guard let self = self else { return }
                self.count += 1
                print("Button pressed \(self.count) times")
            }
            .store(in: &cancellables)
    }
}

struct ViewModelContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button("Press Me") {
                viewModel.buttonPressed.send()
            }
        }
    }
}
