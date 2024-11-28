//
//  ContentView.swift
//  WeSplit
//
//  Created by Mitchell Desjardins on 2024-11-27.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfSplits = 2
    @State private var tipAmount = 20
    @FocusState private var amountFocus : Bool
    
    let tipPercentages = [10, 15, 20, 25, 30]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfSplits + 2)
        let tipSelected = Double(tipAmount)
        
        let tip = checkAmount / 100 * tipSelected
        let total = checkAmount + tip
        
        return total / peopleCount
        
    }
    
    var body: some View {
        NavigationStack{
        Form {
            Section{
                TextField("Check Amount", value: $checkAmount, format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.numberPad)
                    .focused($amountFocus)
                
                Picker("Number of People", selection: $numberOfSplits){
                    ForEach(2..<100){
                        Text("\($0) people")
                    }
                }
            }
            
            Section("Tip Percentage"){
                Picker("Tip Percentage", selection: $tipAmount){
                    ForEach(tipPercentages, id: \.self){
                        Text($0, format: .percent)
                    }
                }.pickerStyle(.segmented)
            }
            Section{
                Text(totalPerPerson, format:.currency(code: Locale.current.currency?.identifier ?? "USD") )
            }
        }.navigationTitle("WeSplit")
                .toolbar{
                    if amountFocus{
                            Button("Done"){
                                amountFocus = false
                            }
                        }
                    }
                }
        }
    }


#Preview {
    ContentView()
}
