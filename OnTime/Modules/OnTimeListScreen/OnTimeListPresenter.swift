//
//  OnTimeListPresenter.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import Combine

class OnTimeListPresenter: OnTimeListPresenterProtocol {
    @Published var onTime = [OnTime]()
    @Published var isLoading = false
    @Published var selectedName: String = ""
    private let interactor: OnTimeListInteractorProtocol
    private var router: OnTimeListRouter
    
    private var cancellables = Set<AnyCancellable>()
    init(interactor: OnTimeListInteractorProtocol, router: OnTimeListRouter) {
        self.interactor = interactor
        self.router = router
    }

    /// Load onTime using the interactor
    func loadOnTimes() {
        isLoading = true
        interactor.fetchOnTimes()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    // TODO: Handle error more effectively
                case .finished:
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] onTime in
                self?.onTime = onTime
                self?.selectedName = onTime.first?.name ?? ""

            }
            .store(in: &cancellables)
    }
    
    func makeDetailsView(for onTime: OnTime) -> OnTimeDetailsView {
        self.router.makeDetailsView(for: onTime)
        
    }
    
    
}
