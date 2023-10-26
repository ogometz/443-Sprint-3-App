//
//  Chords.swift
//  sprint3-coredata
//
//  Created by Owen Gometz on 10/25/23.
//

import CoreData
import Foundation

class ChordDataInitializer {
  
  let easy_chords: [String] = ["A", "Am", "C", "D", "Dm", "E", "Em", "G"]
  let medium_chords: [String] = ["F", "Fm", "F#", "F#m", "Gm", "G#", "G#m"]
  let hard_chords: [String] = ["A#", "A#m", "B", "Bm", "Cm", "C#", "C#m", "D#", "D#m"]
  
  var all_chords: [[String]] {
    [easy_chords, medium_chords, hard_chords]
  }
  
  func initializeChordData(into context: NSManagedObjectContext) {
    for (index, chords) in all_chords.enumerated() {
      for chord in chords {
        
        let quality: String
        if chord.hasSuffix("m") {
          quality = "Minor"
        } else {
          quality = "Major"
        }
        
        let difficulty: String
        switch index {
        case 0:
          difficulty = "Easy"
        case 1:
          difficulty = "Medium"
        case 2:
          difficulty = "Hard"
        default:
          difficulty = "Unknown"
        }
        
        // Assuming image and audio file names follow a specific pattern, e.g., A_Image and A_Audio. Adjust as needed.
        let diagram_image = "\(chord)_Image"
        let audio_file = "\(chord)_Audio"
        
        let chord_instance = Chord(context: context)
        chord_instance.chord_id = UUID()
        chord_instance.chord_name = chord
        chord_instance.quality = quality
        chord_instance.difficulty = difficulty
        chord_instance.diagram_image = diagram_image
        chord_instance.audio_file = audio_file
        
      }
    }
    do {
      try context.save()
    } catch {
      print("Failed to save context after importing: \(error)")
    }
  }
  
}
