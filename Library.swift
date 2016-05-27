//
//  Library.swift
//  shitTunes
//
//  Created by John Moody on 4/25/16.
//  Copyright © 2016 John Moody. All rights reserved.
//

import Foundation
import AppKit


public struct Song: Equatable {
    
    let name:             String
    let sort_name:        String
    
    let artist:           String
    let sort_artist:      String
    
    let composer:         String
    let sort_composer:    String
    
    let album:            String
    let sort_album:       String
    let track_num:        Int
    
    let album_artist:     String
    
    let time:             Int
    let release_date:     NSDate
    let date_modified:    NSDate
    let date_added:       NSDate
    let last_played_date: NSDate
    let last_skipped_date:NSDate
    
    let size:             Int
    let bit_rate:         Int
    let sample_rate:      Int
    let file_kind:        String
    
    let play_count:       Int
    let skip_count:       Int
    
    let genre:            String
    let kind:             String
    let rating:           Int
    let comments:         String
    let search_field:     String
    let location:         NSURL
    
    let status:           Bool
    let compilation:      Bool
    
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











