import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class Spotify {
  final String clientId = dotenv.env['CLIENT_ID'] ?? '';

  playSong() async {
    var res = await SpotifySdk.connectToSpotifyRemote(
        clientId: clientId,
        redirectUrl: "YOUR_APP_NAME://",
        scope:
            "app-remote-control,user-modify-playback-state,playlist-read-private");
    print(res);
    var trackId = "0ct6r3EGTcMLPtrXHDvVjc";
    SpotifySdk.play(spotifyUri: "spotify:track:$trackId");
  }
}
