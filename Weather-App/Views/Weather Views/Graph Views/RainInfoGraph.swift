import SwiftUI
import WeatherKit

struct RainInfoGraph: View {
    let hourData: Slice<Forecast<HourWeather>>.Element?
    let dayData: Slice<Forecast<DayWeather>>.Element?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "cloud.rain.fill")
                Text("Rainfall")
            }
            Spacer()
            Text((hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)! > 0 ? "\((hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)?.formatted() ?? "") mm" : "")
                .font(.system(size: 44))
                .fontWeight(.semibold)
            if (hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value)! <= 0 {
                Gauge(value: ((hourData?.precipitationChance ?? dayData?.precipitationChance) ?? 0) * 100, in: 0.0...100.0) {
                    Image(systemName: "gauge.medium")
                        .font(.system(size: 50.0))
                } currentValueLabel: {
                    Text("\((Int((hourData?.precipitationChance ?? dayData?.precipitationChance ?? 0) * 100)))")
                }
                .gaugeStyle(RainGaugeStyle())
            }
            Spacer()
            Text("\(hourData?.precipitationAmount.value ?? dayData?.precipitationAmount.value ?? 0 > 0 ? "Amount of rain" : "Chance of rain")" + "\((hourData != nil ? " for the hour" : " for the day"))")
                .font(.system(size: 14))
        }
        .modifier(GlassCard())
        .modifier(SymbolFill())
    }
}

//#Preview {
//    RainInfoGraph()
//}
