//
// FlickrViewModel.swift
//  FlickerSearch
//
//  Created by Jai Timsina on 2/5/25.
//


import Foundation
import Combine

class FlickrViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var customError:ApiError?

    
    private var cancellables = Set<AnyCancellable>()
    
    private let apiManager: APIManagerContract
    init(apiManager: APIManagerContract) {
        self.apiManager = apiManager
    }
    
    func fetchImages(for apiLink: String) {
        guard !apiLink.isEmpty else {
            self.photos = []
            return
        }
        
        
        guard let url = URL(string: apiLink) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        apiManager.getDataFromNetworkLayer(url: url, modelType: FlickrResponse.self)
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch completion{
                            case .finished:
                                print("In finished case")
                                self.isLoading = false
                            case .failure(let error):
                                switch error{
                                case is URLError:
                                    self.customError = ApiError.invalidRequest
                                case is DecodingError:
                                    self.customError = ApiError.parsingError
                                case ApiError.parsingError:
                                    self.customError = ApiError.parsingError
                                case ApiError.invalidRequest:
                                    self.customError = ApiError.invalidResponse
                                case ApiError.responseError:
                                    self.customError = ApiError.responseError
                                default:
                                    self.customError = ApiError.dataNotFound
                                }
                                print(error.localizedDescription)
                                self.errorMessage = "No data received \(error.localizedDescription)"
                                self.isLoading = false
                            }
                        } receiveValue: { flickerRespones in
                            self.photos = flickerRespones.items
                            self.isLoading = false
                        }.store(in: &cancellables)
        
    }
}

