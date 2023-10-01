//
//  InsightManager.swift
//  Weather-App
//
//  Created by Matt Sullivan on 25/08/2023.
//

import SwiftUI

struct TemperatureInsights {
    let maxTemperature: Double
    let minTemperature: Double
}

class InsightManager: ObservableObject {
    static let shared = InsightManager()
    
    @Published var weekTempInsights: TemperatureInsights?
    @Published var maxUVForWeek: Int?
    @Published var maxWindForWeek: Double?
    
    func updateInsights() async {
        let (tempInsights, uvForWeek, windForWeek) = await calculateInsights()
        updateData(tempInsights, uvForWeek, windForWeek)
    }
    
    private func updateData(_ tempInsights: TemperatureInsights?, _ uvForWeek: Int?, _ windForWeek: Double?) {
        DispatchQueue.main.async {
            self.weekTempInsights = tempInsights
            self.maxUVForWeek = uvForWeek
            self.maxWindForWeek = windForWeek
        }
    }
    
    private func calculateInsights() async -> (TemperatureInsights?, Int?, Double?) {
        guard let dailyForecast = await WeatherData.shared.dailyForecast else {
            return (nil, nil, nil)
        }
        
        let highTempArray = dailyForecast.map { $0.highTemperature.value.rounded(.toNearestOrEven) }
        let lowTempArray = dailyForecast.map { $0.lowTemperature.value.rounded(.toNearestOrEven) }
        let uvArray = dailyForecast.map { $0.uvIndex.value }
        let windArray = dailyForecast.map { $0.wind.speed.value.rounded(.toNearestOrEven) }
        
        let maxTemp = highTempArray.max() ?? 0.0
        let minTemp = lowTempArray.min() ?? 0.0
        let tempInsights = TemperatureInsights(maxTemperature: maxTemp, minTemperature: minTemp)
        let uvForWeek = uvArray.max()
        let windForWeek = windArray.max()
        
        return (tempInsights, uvForWeek, windForWeek)
    }
}
