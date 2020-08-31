//
//  CountryDetailView.swift
//  Covid19Stats
//
//  Created by Alfian Losari on 22/08/20.
//

import SwiftUI

struct CountryDetailView: View {
    
    @EnvironmentObject var watchlist: WatchlistObservableObject
    @StateObject var countrySummary = CountrySummaryObservableObject()
    let country: Country
    
    
  
    var body: some View {
        ZStack {
            if let totalCase = countrySummary.totalCase, let cases = countrySummary.cases {
                List {
                    Section(header: Text("Lifetime Stats")) {
                        Text(totalCase.date, style: .date)
                            .font(.headline)
                        CasePieRow(totalCount: .init(title: country.iso.flag, confirmed: totalCase.confirmed, death: totalCase.deaths, recovered: totalCase.recovered), date: totalCase.date)
                        CaseStatGrid(totalCount: totalCase.totalCaseCount)
                            .frame(height: 140)
                            .cornerRadius(8)
                            .padding(.vertical)
                    }
                    
                    if let dailyCases = cases.dailyCases {
                        Section(header: Text("Charts")) {
                            MultiLineChartView(
                                data: [
                                    (dailyCases.confirmed.map { $0.1 }, GradientColor(start: confirmedColor, end: confirmedColor)),
                                    (dailyCases.deaths.map { $0.1 }, GradientColor(start: deathColor, end: deathColor)),
                                    (dailyCases.recovered.map { $0.1 }, GradientColor(start: recoveredColor, end: recoveredColor))],
                                
                                title: "Last 90 Days",
                                style: Styles.lineChartStyleOne,
                                form: ChartForm.large,
                                dropShadow: false
                            )
                            
                            BarChartView(
                                data: ChartData(
                                    values: dailyCases.confirmed.suffix(10).map { (Utils.dateFormatter.string(from: $0.0), $0.1) }),
                                title: "Confirmed - Last 10 days",
                                style: ChartStyle(
                                    backgroundColor: Color.white,
                                    accentColor: confirmedColor,
                                    secondGradientColor: confirmedColor,
                                    textColor: Color.black,
                                    legendTextColor: Color.gray,
                                    dropShadowColor: Color.gray),
                                dropShadow: false
                            )
                            .padding(.vertical)
                            
                            BarChartView(
                                data: ChartData(
                                    values: dailyCases.deaths.suffix(10).map { (Utils.dateFormatter.string(from: $0.0), $0.1) }),
                                title: "Death - Last 10 days",
                                style: ChartStyle(
                                    backgroundColor: Color.white,
                                    accentColor: deathColor,
                                    secondGradientColor: deathColor,
                                    textColor: Color.black,
                                    legendTextColor: Color.gray,
                                    dropShadowColor: Color.gray),
                                dropShadow: false
                            )
                            .padding(.vertical)
                            
                            BarChartView(
                                data: ChartData(
                                    values: dailyCases.recovered.suffix(10).map { (Utils.dateFormatter.string(from: $0.0), $0.1) }),
                                title: "Recovered - Last 10 days",
                                style: ChartStyle(
                                    backgroundColor: Color.white,
                                    accentColor: recoveredColor,
                                    secondGradientColor: recoveredColor,
                                    textColor: Color.black,
                                    legendTextColor: Color.gray,
                                    dropShadowColor: Color.gray),
                                dropShadow: false
                            )
                            .padding(.vertical)
                            
                            
                        }
                        
                    }
                    
               
                   
                    

                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            watchlist.toggle(country: country)
                        }, label: {
                             Image(systemName: watchlist.isAddedToWatchlist(country: country) ? "star.fill" : "star")
                        })
                )
            } else {
                ProgressView()
            }
            
        }
        .navigationTitle(country.name)
        .onAppear {
            countrySummary.fetchSummary(countryId: country.id)
        }
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: .init(id: "", name: "", iso: ""))
    }
}

