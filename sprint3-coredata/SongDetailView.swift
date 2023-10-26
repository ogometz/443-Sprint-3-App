//
//  SongDetailView.swift
//  sprint3-coredata
//
//  Created by Owen Gometz on 10/26/23.
//

import SwiftUI
import CoreData

struct SongDetailView: View {
    let song: Song
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var songChordInstances: [SongChordInstance] = []
    
    var body: some View {
        List(songChordInstances, id: \.self) { instance in
            Text(instance.chord_name ?? "Unknown Chord")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let fetchRequest: NSFetchRequest<SongChordInstance> = SongChordInstance.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "song == %@", song)

        
        do {
            songChordInstances = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch song chord instances: \(error)")
        }
    }
}
