//
//  SongDataInitializer.swift
//  sprint3-coredata
//
//  Created by Owen Gometz on 10/25/23.
//

import Foundation
import CoreData

class SongDataInitializer {
  
    func initializeSongData(into context: NSManagedObjectContext) {
        // Define the base path for the uspopLabels directory
        guard let intermediatePath = Bundle.main.resourceURL?.appendingPathComponent("Chord-Annotations-master copy") else {
            print("Failed to find intermediate path")
            return
        }

        let basePath = intermediatePath.appendingPathComponent("uspopLabels")

        print("Base path: \(basePath.path)")

        
        // List of artists
        let artists = try? FileManager.default.contentsOfDirectory(at: basePath, includingPropertiesForKeys: nil)
        print("artists:")
        
        for artistURL in artists ?? [] {
            let albums = try? FileManager.default.contentsOfDirectory(at: artistURL, includingPropertiesForKeys: nil)
            
            for albumURL in albums ?? [] {
                let songs = try? FileManager.default.contentsOfDirectory(at: albumURL, includingPropertiesForKeys: nil, options: [])
                
              for songURL in songs ?? [] {
                  if songURL.pathExtension == "lab" {
                      let songTitleWithID = songURL.deletingPathExtension().lastPathComponent
                      let songTitle = String(songTitleWithID.split(separator: "-")[1])  // Removes the ID prefix
                      
                      let song = Song(context: context)
                      song.song_id = UUID()
                      song.title = songTitle
                      song.artist = artistURL.lastPathComponent
                      song.album = albumURL.lastPathComponent
                      song.audio_file = "\(songTitle).wav"  // Assuming audio file name format

                      // Parse the .lab file
                      if let fileContents = try? String(contentsOf: songURL), !fileContents.isEmpty {
                          let lines = fileContents.split(separator: "\n")

                          for line in lines {
                              let components = line.split(separator: "\t")
                              
                              if components.count == 3 { // Ensuring we have all three components: start_time, end_time, chord_name
                                  let startTime = Float(components[0]) ?? 0.0
                                  let endTime = Float(components[1]) ?? 0.0
                                  let chordName = String(components[2])
                                  
                                let songChordInstance = SongChordInstance(context: context)
                                  songChordInstance.song_chord_instance_id = UUID()
                                  songChordInstance.song = song
                                  songChordInstance.start_time = startTime
                                  songChordInstance.end_time = endTime
                                  songChordInstance.chord_name = chordName
                              }
                          }
                      }
                  }
              }

            }
        }
      
        
        do {
            try context.save()
        } catch {
            print("Failed to save context after importing: \(error)")
        }
    }
}

