//
//  MoyaManager.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Moya
import Alamofire
import Foundation

final class NetworkProvider<Target> where Target: Moya.TargetType {
    let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     session: Session.default,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    
    func cancel() {
        provider.session.cancelAllRequests()
    }
}

final public class MoyaManager: NetworkProtocol {
    
    private var currentEndpoint: Endpoint?
    private var retryCount = 0
    private var maximumRetry = 1
    
    public init() { }
    
    public func request<T: Codable, U: Endpoint>(
        _ endpoint: U, expectedType: T.Type,
        _ onResponse: @escaping (Result<T, LSError>) -> Void
    ) {
        
        Reachability().addReachabilityObserver()
        
        let provider = NetworkProvider<U>()
        
        provider.provider.session.sessionConfiguration.timeoutIntervalForRequest = endpoint.timeoutInterval
        provider.provider.session.sessionConfiguration.timeoutIntervalForResource = endpoint.timeoutInterval
        
        provideRequest(provider: provider, endpoint, expectedType: expectedType, onResponse)
    }
    
    private func provideRequest<T: Codable, U: Endpoint>(
        provider: NetworkProvider<U>, _ endpoint: U,
        expectedType: T.Type, _ onResponse: @escaping (Result<T, LSError>
        ) -> Void) {
        
        provider.provider.request(endpoint) { result in
            var errorModel = LSError()
            switch result {
            case .success(let response):
                
                if (response.statusCode == 204 && expectedType.self == EmptyResponse.self) || (response.statusCode == 201 && expectedType.self == EmptyResponse.self) {
                    guard let emptyResponse = EmptyResponse() as? T else {
                        errorModel.statusCode = LSConstants.statusCodeForParseError
                        errorModel.message?.reason = "Error decoding model"
                        errorModel.message?.detail = "API - \(endpoint.path)"
                        onResponse(.failure(errorModel))
                        return
                    }
                    onResponse(.success(emptyResponse))
                    return
                }

                if case 200..<400 = response.statusCode {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let model = try response.map(expectedType, using: decoder)
                        onResponse(.success(model))
                        
                    } catch {
                        errorModel.statusCode = LSConstants.statusCodeForParseError
                        errorModel.message?.reason = "Error decoding model"
                        errorModel.message?.detail = "API - \(endpoint.path)"
                        onResponse(.failure(errorModel))
                    }
                    
                } else {
                    
                    do {
                        errorModel.statusCode = response.statusCode
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let model = try response.map(LSErrorMessage.self, using: decoder)
                        
                        errorModel.message = model
                        onResponse(.failure(errorModel))
                        
                    } catch {
                        errorModel.statusCode = LSConstants.statusCodeForParseError
                        errorModel.message = .init(code: LSConstants.statusCodeForParseError, reason: "API - \(endpoint.path)")
                        onResponse(.failure(errorModel))
                    }
                    
                }
            case .failure(let error):
                errorModel.statusCode = error.response?.statusCode
                onResponse(.failure(errorModel))
            }
        }
    }
}
