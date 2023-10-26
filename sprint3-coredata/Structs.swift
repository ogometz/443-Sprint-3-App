//
//  Structs.swift
//  sprint3-coredata
//
//  Created by Owen Gometz on 10/25/23.
//

import Foundation

struct Chords {
    let chord_id: UUID
    let chord_name: String
    let quality: String
    let difficulty: String
    let diagram_image: String
    let audio_file: String
}

struct UserInfo {
    let user_id: UUID
    let user_name: String
    let day_streak: Int
    let num_chords_completed: Int
    let num_songs_unlocked: Int
}

struct ChordCompletionStatus {
    let chord_completion_status_id: UUID
    let user_id: UUID
    let chord_id: UUID
    let completed: Bool
}

struct Songs {
    let song_id: UUID
    let title: String
    let artist: String
    let album: String
    let audio_file: String
}

struct SongLockStatus {
    let song_lock_status_id: UUID
    let user_id: UUID
    let song_id: UUID
    let locked: Bool
}

struct SongChordInstanceStruct {
    let song_chord_instance_id: UUID
    let song_id: UUID
    let chord_id: UUID
    let start_time: Float
    let end_time: Float
}

struct Quotes {
    let quote_id: UUID
    let quote: String
    let author: String
}
