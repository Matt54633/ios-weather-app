//
//  WeatherData.swift
//  Weather-App
//
//  Created by Matt Sullivan on 05/08/2023.
//

import Foundation
import WeatherKit
import CoreLocation

@MainActor
class WeatherData: ObservableObject {
    static let shared = WeatherData()
    let service = WeatherService.shared
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyForecast: Forecast<HourWeather>?
    @Published var dailyForecast: Forecast<DayWeather>?
    @Published var minuteForecast: Forecast<MinuteWeather>?
    @Published var isLoading: Bool = true

    func updateCurrentWeather(userLocation: CLLocation) async {
        self.isLoading = true

        Task.detached(priority: .userInitiated) {
            do {
                let oneDayFuture = Date().addingTimeInterval(86400)
                let forecast = try await self.service.weather(
                    for: userLocation,
                    including: .hourly(startDate: Date(), endDate: oneDayFuture), .daily, .current, .minute, .alerts)
                DispatchQueue.main.async {
                    self.hourlyForecast = forecast.0
                    self.dailyForecast = forecast.1
                    self.currentWeather = forecast.2
                    self.minuteForecast = forecast.3
                    self.isLoading = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadCurrentWeatherData() {
        guard let userLocation = LocationManager.shared.userLocation else {
            return
        }
        Task.detached { @MainActor in
            await WeatherData.shared.updateCurrentWeather(userLocation: userLocation)
        }
    }
    
    func loadSearchLocationData() {
        guard let searchLocation = LocationManager.shared.searchLocation else {
            return
        }
        Task.detached { @MainActor in
            await WeatherData.shared.updateCurrentWeather(userLocation: searchLocation)
        }
    }
}
