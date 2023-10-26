//
//  ChordDetailView.swift
//  sprint3-coredata
//
//  Created by Owen Gometz on 10/26/23.
//

// ChordDetailView.swift

import SwiftUI

struct ChordDetailView: View {
    let chord: Chord

    var body: some View {
        VStack(spacing: 20) {
            Text(chord.chord_name ?? "")
                .font(.title)
            Text(chord.quality ?? "")
            Text(chord.difficulty ?? "")
            // You can add more fields or visuals related to the chord here
        }
        .padding()
    }
}
