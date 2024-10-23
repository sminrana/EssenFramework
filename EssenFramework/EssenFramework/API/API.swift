
import Foundation
import Alamofire


public protocol HttpConnection {
    func POST(url: String, params: [String: String]?, encoder: ParameterEncoder, headers: HTTPHeaders?, interceptor: RequestInterceptor?, requestModifier: URLRequest?, completion: @escaping (Bool, Any) -> ())
}

open class HttpClient: HttpConnection {
    public init() {}
    
    public func POST(url: String, params: [String: String]?, encoder: ParameterEncoder, headers: HTTPHeaders?, interceptor: RequestInterceptor?, requestModifier: URLRequest?, completion: @escaping (Bool, Any) -> ()) {
        AF.request(url,
                method: .post,
                parameters: params,
                encoder: encoder,
                headers: headers,
                interceptor: interceptor)
        .response { response in
            print("\n\n\n\n\n\n\n===========START============")
            print(url)
            print(params)
            print(response)
            
            switch response.result {
                case .success(let data):
                    completion(true, data ?? "")
                case .failure(let error):
                    print(error)
                    completion(false, error)
            }
            
            print("===========END============")
        }
    }
}

open class SOSParamEncoder: URLEncodedFormParameterEncoder {
    
}

open class API {
    public init() {}
    
    public func GET(url: String, params: [String: String]? = nil, encoder: ParameterEncoder = SOSParamEncoder.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: URLRequest? = nil, completion: @escaping (Bool, Any) -> ()) {
        AF.request(url,
                method: .get,
                parameters: params,
                   encoder: encoder,
                headers: headers,
                interceptor: interceptor
        )
        .response { response in
            print("\n\n\n\n\n\n\n===========START============")
            print(url)
            print(response)
            switch response.result {
                case .success(let data):
                    completion(true, data ?? "")
                case .failure(let error):
                    print(error)
                    completion(false, error)
            }
            
            print("===========END============")
        }
    }
    
    public func POST(url: String, params: [String: String], encoder: ParameterEncoder = SOSParamEncoder.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: URLRequest? = nil, completion: @escaping (Bool, Any) -> ()) {
        AF.request(url,
                method: .post,
                parameters: params,
                encoder: encoder,
                headers: headers,
                interceptor: interceptor)
        .response { response in
            print("\n\n\n\n\n\n\n===========START============")
            print(url)
            print(params)
            print(response)
            
            switch response.result {
                case .success(let data):
                    completion(true, data ?? "")
                case .failure(let error):
                    print(error)
                    completion(false, error)
            }
            
            print("===========END============")
        }
    }
    
    public func download(url: String, params: [String: String]? = nil, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: URLRequest? = nil, onProgress: @escaping (Any) -> (), onComplete: @escaping (Data?) -> ()) {
        AF.download(url, parameters: params, headers: headers, interceptor: interceptor)
            .downloadProgress { progress in
                onProgress(progress)
            }
            .responseData { response in
                print("\n\n\n\n\n\n\n===========START============")
                print(url)
                print(response)
                onComplete(response.value)
            }
    }
    
    public func cancelDataTasks() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
                    dataTasks.forEach {
                        print($0)
                        $0.cancel()
                    }
                }
        )
    }
}



