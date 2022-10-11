//
//  ApiService.swift
//  WeatherApp
//
//  Created by Tony Mut on 10/8/22.
//

import Foundation

class ApiService {
    
    func fetchCurrentWeather(latitude: String, longitude: String, completionHandler: @escaping (ApiResponse) -> Void) {
        
        let urlString = "weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(Constants.apiKey)"
        callApi(urlString: urlString, completionHandler: completionHandler);
    }
    
    func fetchWeatherForecast(latitude: String, longitude: String, completionHandler: @escaping (ForecastResponse) -> Void) {
        
        let urlString = "forecast/?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(Constants.apiKey)&unit=metric&cnt=5"
        callApi(urlString: urlString, completionHandler: completionHandler);
    }
    
    private func callApi(urlString: String, completionHandler: @escaping (ApiResponse) -> Void){
        
        let url = Constants.baseUrl + urlString
        guard let url = URL(string: url)
            else {
                print("Invalid Url")
                return
            }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error = error {
                print("Error fetching data \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response \(String(describing: response))")
                return
            }
            
            if let data = data,
               let apiRespose = try? JSONDecoder().decode(ApiResponse.self, from: data) {
                print("Success.....")
                completionHandler(apiRespose)
            }
            
        }.resume()
    }
    
    func callApi(urlString: String, completionHandler: @escaping (ForecastResponse) -> Void){
        
        let url = Constants.baseUrl + urlString
        guard let url = URL(string: url)
            else {
                print("Invalid Url")
                return
            }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error = error {
                print("Error fetching data \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response \(String(describing: response))")
                return
            }
            
            if let data = data,
               let apiRespose = try? JSONDecoder().decode(ForecastResponse.self, from: data) {
                print("Success.....")
                completionHandler(apiRespose)
            }
            
        }.resume()
    }
}
