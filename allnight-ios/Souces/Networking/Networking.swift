//
//  Networking.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import Moya

typealias AllNightNetworking = Networking<AllNightAPI>

final class Networking<Target: TargetType>: MoyaProvider<Target> {

  init(plugins: [PluginType] = []) {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 10

    let manager = Manager(configuration: configuration)
    manager.startRequestsImmediately = false
    super.init(manager: manager, plugins: plugins)
  }

  @discardableResult
  func request(
    _ target: Target,
    completionHandler: @escaping (Response) -> Void,
    errorHandler: @escaping (MoyaError) -> Void
  ) -> Cancellable {
    let requestString = "\(target.method) \(target.path)"

    log.debug("Request : \(requestString)")

    return self.request(target) { result in
      switch result {
      case let .success(response):
        do {
          let filteredResponse = try response.filterSuccessfulStatusCodes()
          completionHandler(filteredResponse)
        }
        catch {
          log.warning("Failure : \(requestString) (\(response.statusCode))")

          errorHandler(MoyaError.statusCode(response))
        }
      case let .failure(error):
        if let response = error.response {
          if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
            log.warning("Failure : \(requestString) (\(response.statusCode))\n\(jsonObject)")
          } else if let rawString = String(data: response.data, encoding: .utf8) {
            log.warning("Failure : \(requestString) (\(response.statusCode))\n\(rawString)")
          } else {
            log.warning("Failure : \(requestString) (\(response.statusCode))")
          }
        }
        errorHandler(error)
      }
    }
  }
}
