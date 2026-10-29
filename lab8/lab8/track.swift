import Foundation

struct Track {
    let title: String
    let artist: String
    let fileName: String
    let coverImageName: String
}
struct TrackLibrary {
    static let tracks: [Track] = [

        Track(
            title: "Finland",
            artist: "TrackTribe",
            fileName: "finland",
            coverImageName: "cover_finland"
        ),

        Track(
            title: "Then A Left Turn",
            artist: "Jeremy Korpas",
            fileName: "then_a_left_turn",
            coverImageName: "cover_then_a_left_turn"
        ),

        Track(
            title: "Once",
            artist: "Silent Partner",
            fileName: "once",
            coverImageName: "cover_once"
        ),

        Track(
            title: "Cockpit",
            artist: "Silent Partner",
            fileName: "cockpit",
            coverImageName: "cover_cockpit"
        ),

        Track(
            title: "Open Wide",
            artist: "Silent Partner",
            fileName: "open_wide",
            coverImageName: "cover_open_wide"
        ),

        Track(
            title: "Just In Case",
            artist: "Silent Partner",
            fileName: "just_in_case",
            coverImageName: "cover_just_in_case"
        ),

        Track(
            title: "No Talk",
            artist: "VYEN",
            fileName: "no_talk",
            coverImageName: "cover_no_talk"
        ),

        Track(
            title: "Give",
            artist: "Silent Partner",
            fileName: "give",
            coverImageName: "cover_give"
        ),

        Track(
            title: "Cue",
            artist: "Silent Partner",
            fileName: "cue",
            coverImageName: "cover_cue"
        ),

        Track(
            title: "South",
            artist: "Silent Partner",
            fileName: "south",
            coverImageName: "cover_south"
        )
    ]
}
