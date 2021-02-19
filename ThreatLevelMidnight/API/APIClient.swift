//
//  APIClient.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class APIClient {

	private static func request<T: Codable> (_ route: URLRequestConvertible) -> Observable<T> {
		return Observable<T>.create { observer in
			let request = AF.request(route).responseDecodable { (response: AFDataResponse<T>) in

				switch response.result {
				case .success(let value):
					observer.onNext(value)
					observer.onCompleted()

				case .failure(let error):
					switch response.response?.statusCode {
					case 403:
						observer.onError(APIError.tlmn_forbidden)
					case 404:
						observer.onError(APIError.tlmn_notFound)
					case 500:
						observer.onError(APIError.tlmn_internalServerError)
					default:
						guard NetworkReachabilityManager()?.isReachable ?? false else {
							observer.onError(APIError.noInternet)
							return
						}
						observer.onError(error)
					}
				}
			}

			return Disposables.create {
				request.cancel()
			}
		}
	}

	static func getTVShow() -> Observable<TVShow> {
		return request(TMDBRouter.getShow)
	}
	
	static func getSeason(season: Int) -> Observable<Season> {
		return request(TMDBRouter.getSeason(season: season))
	}
	
	static func getEpisode(season: Int, episode: Int) -> Observable<Episode> {
		return request(TMDBRouter.getEpisode(season: season, episode: episode))
	}
}
