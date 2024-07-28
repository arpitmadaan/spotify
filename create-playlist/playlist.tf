terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  api_key = var.spotify_api_key
}

data "spotify_search_track" "by_artist" {
  artist = var.artist_name
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Playlist"
  description = "This playlist was created by Terraform"
  public      = true

  tracks = [for i in range(0, 10) : data.spotify_search_track.by_artist.tracks[i].id]
}