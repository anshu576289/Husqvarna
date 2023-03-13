//
//  SettingsView.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import SwiftUI

struct Settings: View {
    var settings: [String] = ["terms_and_conditions".localizedString,
                              "privacy_policy".localizedString,
                              "help_and_support".localizedString]
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.darkGray).edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    HStack {
                        Text("settings".localizedString)
                            .font(.largeTitle)
                        Spacer()
                    }
                    .padding(.bottom, Padding.extraSmall)
                    .padding(.leading, Padding.small)
                    
                    VStack {
                        ForEach(0..<settings.count, id: \.self) { element in
                            HStack {
                                HStack {
                                    Text("\(settings[element])").foregroundColor(.black)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .contentShape(Rectangle())
                                .cornerRadius(CornerRadius.cardViewRadius)
                            }
                            .padding([.top, .bottom], Padding.extraSmall)
                            .padding([.trailing, .leading], Padding.small)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
