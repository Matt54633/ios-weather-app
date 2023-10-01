//
//  WeatherInsights.swift
//  Weather-App
//
//  Created by Matt Sullivan on 15/08/2023.
//

import SwiftUI
import WeatherKit


struct WeatherInsights: View {
    @StateObject var insightDataHelper = InsightManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("WEEKLY WEATHER INSIGHTS")
                .modifier(CalloutTextStyle())
            Spacer(minLength: 20)
            HStack {
                if let weekTempInsights = insightDataHelper.weekTempInsights {
                    Insight(title: "Max Temp", value: "\(weekTempInsights.maxTemperature.formatted())°", unit: nil)
                    Spacer(minLength: 10)
                    Insight(title: "Min Temp", value: "\(weekTempInsights.minTemperature.formatted())°", unit: nil)
                }
                Spacer(minLength: 10)
                if let maxUVForWeek = insightDataHelper.maxUVForWeek {
                    Insight(title: "Max UV", value: maxUVForWeek.formatted(), unit: nil)
                }
                Spacer(minLength: 10)
                if let maxWindForWeek = insightDataHelper.maxWindForWeek {
                    Insight(title: "Max Wind", value: maxWindForWeek.formatted(), unit: "mph")
                }
                
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    WeatherInsights()
}
