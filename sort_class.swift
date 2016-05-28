//parser class: line 411; code that does stuff: line 617

import Foundation


public class Song: Equatable {
    
    var name:             String
    var sort_name:        String
    
    var artist:           String
    var sort_artist:      String
    
    var composer:         String
    var sort_composer:    String
    
    var album:            String
    var sort_album:       String
    var track_num:        Int
    
    var album_artist:     String
    
    var time:             Int
    var release_date:     NSDate
    var date_modified:    NSDate
    var date_added:       NSDate
    var last_played_date: NSDate
    var last_skipped_date:NSDate
    
    var size:             Int
    var bit_rate:         Int
    var sample_rate:      Int
    var file_kind:        String
    
    var play_count:       Int
    var skip_count:       Int
    
    var genre:            String
    var kind:             String
    var rating:           Int
    var comments:         String
    var search_field:     String
    var location:         NSURL
    
    var status:           Bool
    var compilation:      Bool

    init(name: String, sort_name: String, artist: String, sort_artist: String, composer: String, sort_composer: String, album: String, sort_album: String, track_num: Int,
        album_artist: String, time: Int, release_date: NSDate, date_modified: NSDate, date_added: NSDate, last_played_date: NSDate, last_skipped_date: NSDate,
        size: Int, bit_rate: Int, sample_rate: Int, file_kind: String, play_count: Int, skip_count: Int, genre: String, kind: String, rating: Int,
        comments: String, search_field: String, location:NSURL, status: Bool, compilation: Bool) {
        self.name = name
        self.sort_name = sort_name
        self.artist = artist
        self.sort_artist = sort_artist
        self.composer = composer
        self.sort_composer = sort_composer
        self.album = album
        self.sort_album = sort_album
        self.track_num = track_num
        self.album_artist = album_artist
        self.time = time
        self.release_date = release_date
        self.date_modified = date_modified
        self.date_added = date_added
        self.last_played_date = last_played_date
        self.last_skipped_date = last_skipped_date
        self.size = size
        self.bit_rate = bit_rate
        self.sample_rate = sample_rate
        self.file_kind = file_kind
        self.play_count = play_count
        self.skip_count = skip_count
        self.genre = genre
        self.kind = kind
        self.rating = rating
        self.comments = comments
        self.search_field = search_field
        self.location = location
        self.status = status
        self.compilation = compilation
    }
    
    func contains(filter: String) -> Bool {
        if self.name.localizedCaseInsensitiveContainsString(filter) || self.artist.localizedCaseInsensitiveContainsString(filter) || self.album.localizedCaseInsensitiveContainsString(filter) || self.composer.localizedCaseInsensitiveContainsString(filter) || self.genre.localizedCaseInsensitiveContainsString(filter) || self.search_field.localizedCaseInsensitiveContainsString(filter) || self.comments.localizedCaseInsensitiveContainsString(filter) {
            return true
        }
        else {
            return false
        }
    }
}

//implement equatable
public func ==(fs: Song, ss: Song) -> Bool {
    return fs.location.isEqual(ss.location)
}

public struct Library {
    public var songs = [Song]()
    
    public enum song_order : String {
        case name
        case artist
        case composer
        case album
        case time
        case date_released
        case date_modified
        case date_added
        case date_last_played
        case size
        case bit_rate
        case sample_rate
        case kind
        case play_count
        case skip_count
        case genre
        case rating
        case comments
        case search_field
        case status
    }
    
    func contentsOrderedBy(orderedBy:song_order, ascending:Bool) -> [Song] {
        let startTime = NSDate()
        let sortedSongs: [Song]
        switch orderedBy {
        case .album:
            sortedSongs = songs.sort {
                if $0.sort_album == $1.sort_album {
                    if $0.track_num == $1.track_num {
                        if $0.sort_artist == $1.sort_artist {
                            return ($0.date_added < $1.date_added)
                        }
                        else {
                            return ($0.sort_artist < $1.sort_artist)
                        }
                    }
                    else {
                        return ($0.track_num < $1.track_num)
                    }
                }
                else {
                    return ascending ? ($0.sort_album < $1.sort_album) : ($0.sort_album > $1.sort_album)
                }
            }
        case .artist:
            sortedSongs = songs.sort {
                if $0.sort_artist == $1.sort_artist {
                    if $0.sort_album == $1.sort_album {
                        if $0.track_num == $1.track_num {
                            return $0.date_added < $1.date_added
                        }
                        else {
                            return $0.track_num < $1.track_num
                        }
                    }
                    else {
                        return ($0.sort_album < $1.sort_album)
                    }
                }
                else {
                    return ascending ? ($0.sort_artist < $1.sort_artist) : ($0.sort_artist > $1.sort_artist)
                }
            }
        case .name:
            sortedSongs = songs.sort {
                if $0.name == $1.name {
                    return $0.artist < $1.artist
                }
                else {
                    return ascending ? ($0.sort_name < $1.sort_name) : ($0.sort_name > $1.sort_name)
                }
            }
        case .bit_rate:
            sortedSongs = songs.sort {
                if $0.bit_rate == $1.bit_rate {
                    return ascending ? ($0.sort_name < $1.sort_name) : ($0.sort_name > $1.sort_name)
                }
                else {
                    return ascending ? ($0.bit_rate < $1.bit_rate) : ($0.bit_rate > $1.bit_rate)
                }
            }
        case .date_added:
            sortedSongs = songs.sort {
                if $0.date_added == $1.date_added {
                    if $0.sort_artist == $1.sort_artist {
                        if $0.sort_album == $1.sort_album {
                            if $0.track_num == $1.track_num {
                                return $0.date_modified < $1.date_modified
                            }
                            else {
                                return $0.track_num < $1.track_num
                            }
                        }
                        else {
                            return $0.sort_album < $1.sort_album
                        }
                    }
                    else {
                        return $0.sort_artist < $1.sort_artist
                    }
                }
                else {
                    return ascending ? ($0.date_added < $1.date_added) : ($0.date_added > $1.date_added)
                }
            }
        case .date_modified:
            sortedSongs = songs.sort {
                if $0.date_modified == $1.date_modified {
                    if $0.sort_artist == $1.sort_artist {
                        if $0.sort_album == $1.sort_album {
                            if $0.track_num == $1.track_num {
                                return $0.date_added < $1.date_added
                            }
                            else {
                                return $0.track_num < $1.track_num
                            }
                        }
                        else {
                            return $0.sort_album < $1.sort_album
                        }
                    }
                    else {
                        return $0.sort_artist < $1.sort_artist
                    }
                }
                else {
                    return ascending ? ($0.date_modified < $1.date_modified) : ($0.date_modified > $1.date_modified)
                }
            }
        case .comments:
            sortedSongs = songs.sort {
                if $0.comments == $1.comments {
                    if $0.sort_artist == $1.sort_artist {
                        if $0.sort_album == $1.sort_album {
                            if $0.track_num == $1.track_num {
                                return $0.date_added < $1.date_added
                            }
                            else {
                                return $0.track_num < $1.track_num
                            }
                        }
                        else {
                            return $0.sort_album < $1.sort_album
                        }
                    }
                    else {
                        return $0.sort_artist < $1.sort_artist
                    }

                }
                else {
                    return ascending ? ($0.comments < $1.comments ) : ($0.comments > $1.comments)
                }
            }
        case .kind:
            sortedSongs = songs.sort {
                if $0.kind == $1.kind {
                    if $0.sort_artist == $1.sort_artist {
                        if $0.sort_album == $1.sort_album {
                            if $0.track_num == $1.track_num {
                                return $0.date_added < $1.date_added
                            }
                            else {
                                return $0.track_num < $1.track_num
                            }
                        }
                        else {
                            return $0.sort_album < $1.sort_album
                        }
                    }
                    else {
                        return $0.sort_artist < $1.sort_artist
                    }
                }
                else {
                    return ascending ? ($0.kind < $1.kind) : ($0.kind > $1.kind)
                }
            }
        case .date_last_played:
            sortedSongs = songs.sort {
                if $0.last_played_date == $1.last_played_date {
                    if $0.sort_artist == $1.sort_artist {
                        if $0.sort_album == $1.sort_album {
                            if $0.track_num == $1.track_num {
                                return $0.date_added < $1.date_added
                            }
                            else {
                                return $0.track_num < $1.track_num
                            }
                        }
                        else {
                            return $0.sort_album < $1.sort_album
                        }
                    }
                    else {
                        return $0.sort_artist < $1.sort_artist
                    }
                }
                else {
                    return ascending ? ($0.last_played_date < $1.last_played_date) : ($0.last_played_date > $1.last_played_date)
                }
            }
        case .play_count:
            sortedSongs = songs.sort {
                if $0.play_count == $1.play_count {
                    if $0.sort_artist == $1.sort_artist {
                        if $0.sort_album == $1.sort_album {
                            if $0.track_num == $1.track_num {
                                return $0.date_added < $1.date_added
                            }
                            else {
                                return $0.track_num < $1.track_num
                            }
                        }
                        else {
                            return $0.sort_album < $1.sort_album
                        }
                    }
                    else {
                        return $0.sort_artist < $1.sort_artist
                    }
                }
                else {
                    return ascending ? ($0.play_count < $1.play_count) : ($0.play_count > $1.play_count)
                }
            }
        case .date_released:
            sortedSongs = songs.sort {
                if $0.release_date == $1.release_date {
                    if $0.sort_artist == $1.sort_artist {
                        if $0.sort_album == $1.sort_album {
                            if $0.track_num == $1.track_num {
                                return $0.date_added < $1.date_added
                            }
                            else {
                                return $0.track_num < $1.track_num
                            }
                        }
                        else {
                            return $0.sort_album < $1.sort_album
                        }
                    }
                    else {
                        return $0.sort_artist < $1.sort_artist
                    }
                }
                else {
                    return ascending ? ($0.release_date < $1.release_date) : ($0.release_date > $1.release_date)
                }
            }
        default:
            sortedSongs = songs.sort {
                if $0.release_date == $1.release_date {
                    if $0.sort_artist == $1.sort_artist {
                        if $0.sort_album == $1.sort_album {
                            if $0.track_num == $1.track_num {
                                return $0.date_added < $1.date_added
                            }
                            else {
                                return $0.track_num < $1.track_num
                            }
                        }
                        else {
                            return $0.sort_album < $1.sort_album
                        }
                    }
                    else {
                        return $0.sort_artist < $1.sort_artist
                    }
                }
                else {
                    return ascending ? ($0.release_date < $1.release_date) : ($0.release_date > $1.release_date)
                }
            }
        }
        let endTime = NSDate()
        let timeElapsed = endTime.timeIntervalSinceDate(startTime)
        print("sort time:")
        print(timeElapsed)
        return sortedSongs

    }
}

func itemComparator<T:Comparable>(fs: T, ss: T, ascending: Bool) -> Bool {
    return ascending ? (fs < ss) : (fs > ss)
}


extension NSDate: Comparable {
    
}

public func ==(fs: NSDate, ss: NSDate) -> Bool {
    if fs.compare(ss) == .OrderedSame {
        return true
    }
    return false
}

public func <(fs: NSDate, ss: NSDate) -> Bool {
    if fs.compare(ss) == .OrderedAscending {
        return true
    }
    return false
}

class iTunesLibraryParser {
    let libDict = NSMutableDictionary(contentsOfFile: "/Volumes/Macintosh HD/CS/shittyTunes/shitTunes/shitTunes/iTunes Library.xml")
    let masterArray = NSArray()
    let trackDict = NSDictionary()
    var masterPlaylistDictList = [NSDictionary()]
    
    func makeLibrary() -> Library {
        var library = Library()
        let playlistArray = libDict!.objectForKey("Playlists") as! NSArray
        let masterDict = playlistArray[0] as! NSDictionary
        let masterArray = masterDict.objectForKey("Playlist Items") as! NSArray
        let trackDict = libDict!.objectForKey("Tracks") as! NSDictionary
        for item in masterArray {
            let id = item.objectForKey("Track ID")?.description
            let individualTrackDict = trackDict.objectForKey(id!)
            masterPlaylistDictList.append(individualTrackDict as! NSDictionary)
            var name, sort_name, artist, sort_artist, composer, sort_composer, album, sort_album, file_kind, genre, kind, comments, search_field, album_artist: String
            var track_num, time, size, bit_rate, sample_rate, play_count, skip_count, rating: Int
            var date_released, date_modified, date_added, date_last_played, date_last_skipped: NSDate
            var status, compilation: Bool
            var location: NSURL
            if (individualTrackDict!.objectForKey("Track Type") != nil) {
                kind = individualTrackDict!.objectForKey("Track Type") as! String
            }
            else {
                kind = ""
            }
            if (individualTrackDict!.objectForKey("Skip Date") != nil) {
                date_last_skipped = individualTrackDict!.objectForKey("Skip Date") as! NSDate
            }
            else {
                date_last_skipped = NSDate.distantPast()
            }
            if (individualTrackDict!.objectForKey("Sample Rate") != nil) {
                sample_rate = individualTrackDict!.objectForKey("Sample Rate") as! Int
            }
            else {
                sample_rate = 0
            }
            if (individualTrackDict!.objectForKey("Kind") != nil) {
                file_kind = individualTrackDict!.objectForKey("Kind") as! String
            }
            else {
                file_kind = ""
            }
            if (individualTrackDict!.objectForKey("Comments") != nil) {
                comments = individualTrackDict!.objectForKey("Comments") as! String
            }
            else {
                comments = ""
            }
            if (individualTrackDict!.objectForKey("Play Date UTC") != nil) {
                date_last_played = individualTrackDict!.objectForKey("Play Date UTC") as! NSDate
            }
            else if (individualTrackDict!.objectForKey("Play Date") != nil) {
                date_last_played = individualTrackDict!.objectForKey("Play Date") as! NSDate
            }
            else {
                date_last_played = NSDate.distantPast()
            }
            if (individualTrackDict!.objectForKey("Track Number") != nil) {
                track_num = individualTrackDict!.objectForKey("Track Number") as! Int
            }
            else {
                track_num = 0
            }
            if (individualTrackDict!.objectForKey("Date Added") != nil) {
                date_added = individualTrackDict!.objectForKey("Date Added") as! NSDate
            }
            else {
                date_added = NSDate.distantPast()
            }
            if (individualTrackDict!.objectForKey("Name") != nil) {
                name = individualTrackDict!.objectForKey("Name") as! String
            }
            else {
                name = ""
            }
            if (individualTrackDict!.objectForKey("Size") != nil) {
                size = individualTrackDict!.objectForKey("Size") as! Int
            }
            else {
                size = 0
            }
            if (individualTrackDict!.objectForKey("Location") != nil) {
                location = NSURL(string: individualTrackDict?.objectForKey("Location") as! String)!
            }
            else {
                location = NSURL(fileURLWithPath: "/")
            }
            if (individualTrackDict!.objectForKey("Artist") != nil) {
                artist = individualTrackDict!.objectForKey("Artist") as! String
            }
            else {
                artist = ""
            }
            if (individualTrackDict!.objectForKey("Album Artist") != nil) {
                album_artist = individualTrackDict!.objectForKey("Album Artist") as! String
            }
            else {
                album_artist = ""
            }
            if (individualTrackDict!.objectForKey("Skip Count") != nil) {
                skip_count = individualTrackDict!.objectForKey("Skip Count") as! Int
            }
            else {
                skip_count = 0
            }
            if (individualTrackDict!.objectForKey("Play Count") != nil) {
                play_count = individualTrackDict!.objectForKey("Play Count") as! Int
            }
            else {
                play_count = 0
            }
            if (individualTrackDict!.objectForKey("Bit Rate") != nil) {
                bit_rate = individualTrackDict!.objectForKey("Bit Rate") as! Int
            }
            else {
                bit_rate = 0
            }
            if (individualTrackDict!.objectForKey("Total Time") != nil) {
                time = individualTrackDict!.objectForKey("Total Time") as! Int
            }
            else {
                time = 0
            }
            if (individualTrackDict!.objectForKey("Date Modified") != nil) {
                date_modified = individualTrackDict!.objectForKey("Date Modified") as! NSDate
            }
            else {
                date_modified = NSDate.distantPast()
            }
            if (individualTrackDict!.objectForKey("Album") != nil) {
                album = individualTrackDict!.objectForKey("Album") as! String
            }
            else {
                album = ""
            }
            if (individualTrackDict!.objectForKey("Sort Album") != nil) {
                sort_album = individualTrackDict!.objectForKey("Sort Album") as! String
            }
            else {
                sort_album = album
            }
            if (individualTrackDict!.objectForKey("Genre") != nil) {
                genre = individualTrackDict!.objectForKey("Genre") as! String
            }
            else {
                genre = ""
            }
            if (individualTrackDict!.objectForKey("Rating") != nil) {
                rating = individualTrackDict!.objectForKey("Rating") as! Int
            }
            else {
                rating = 0
            }
            if (individualTrackDict!.objectForKey("Sort Name") != nil) {
                sort_name = individualTrackDict!.objectForKey("Sort Name") as! String
            }
            else {
                sort_name = name
            }
            if (individualTrackDict!.objectForKey("Release Date") != nil) {
                date_released = individualTrackDict!.objectForKey("Release Date") as! NSDate
            }
            else {
                date_released = NSDate.distantPast()
            }
            if (individualTrackDict!.objectForKey("Composer") != nil) {
                composer = individualTrackDict!.objectForKey("Composer") as! String
            }
            else {
                composer = ""
            }
            if (individualTrackDict!.objectForKey("Sort Composer") != nil) {
                sort_composer = individualTrackDict!.objectForKey("Sort Composer") as! String
            }
            else {
                sort_composer = ""
            }
            if (individualTrackDict!.objectForKey("Disabled") != nil) {
                status = individualTrackDict!.objectForKey("Disabled") as! Bool
            }
            else {
                status = true
            }
            if (individualTrackDict!.objectForKey("Sort Artist") != nil) {
                sort_artist = individualTrackDict!.objectForKey("Sort Artist") as! String
            }
            else {
                sort_artist = artist
            }
            if (individualTrackDict!.objectForKey("Compilation") != nil) {
                compilation = individualTrackDict!.objectForKey("Compilation") as! Bool
            }
            else {
                compilation = false
            }
            search_field = ""
            let the_song = Song(name: name, sort_name: sort_name, artist: artist, sort_artist: sort_artist, composer: composer, sort_composer: sort_composer, album: album, sort_album: sort_album, track_num: track_num, album_artist: album_artist, time: time, release_date: date_released, date_modified: date_modified, date_added: date_added, last_played_date: date_last_played, last_skipped_date: date_last_skipped, size: size, bit_rate: bit_rate, sample_rate: sample_rate, file_kind: file_kind, play_count: play_count, skip_count: skip_count, genre: genre, kind: kind, rating: rating, comments: comments, search_field: search_field, location: location, status: status, compilation: compilation)
            library.songs.append(the_song)
        }
        return library
    }
}

let parse = iTunesLibraryParser()
var library = parse.makeLibrary()
/* sort options:
    public enum song_order : String {
        case name
        case artist
        case composer
        case album
        case time
        case date_released
        case date_modified
        case date_added
        case date_last_played
        case size
        case bit_rate
        case sample_rate
        case kind
        case play_count
        case skip_count
        case genre
        case rating
        case comments
        case search_field
        case status
    }
*/
//examples:
library.songs = library.contentsOrderedBy(.name, ascending: true)
library.songs = library.contentsOrderedBy(.date_added, ascending: true)
library.songs = library.contentsOrderedBy(.bit_rate, ascending: false)
library.songs = library.contentsOrderedBy(.bit_rate, ascending: true)

