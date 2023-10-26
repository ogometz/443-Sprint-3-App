// ContentView.swift

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Chord.entity(),
        sortDescriptors: [NSSortDescriptor(key: "chord_name", ascending: true)],
        animation: .default)
    private var chords: FetchedResults<Chord>

    @FetchRequest(
        entity: Song.entity(),
        sortDescriptors: [NSSortDescriptor(key: "title", ascending: true)],
        animation: .default)
    private var songs: FetchedResults<Song>

    var body: some View {
        TabView {
            // Chords Tab
            NavigationView {
                List(chords) { chord in
                    NavigationLink(destination: ChordDetailView(chord: chord)) {
                        VStack(alignment: .leading) {
                            Text(chord.chord_name ?? "")
                            Text(chord.quality ?? "").font(.subheadline).foregroundColor(.gray)
                            Text(chord.difficulty ?? "").font(.subheadline).foregroundColor(.blue)
                        }
                    }
                }
                .navigationTitle("Chords")
            }
            .tabItem {
                Label("Chords", systemImage: "music.note.list")
            }
            
            // Songs Tab
            NavigationView {
                List(songs) { song in
                    NavigationLink(destination: SongDetailView(song: song)) {
                        VStack(alignment: .leading) {
                            Text(song.title ?? "")
                            Text(song.album ?? "").font(.subheadline).foregroundColor(.gray)
                            Text(song.artist ?? "").font(.subheadline).foregroundColor(.blue)
                        }
                        .padding()
                    }
                }
                .navigationTitle("Songs")
            }
            .tabItem {
                Label("Songs", systemImage: "music.note")
            }
        }
    }
}
