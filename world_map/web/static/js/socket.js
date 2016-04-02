// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect();

var playerLocations = {};

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("updates:join", {})
channel.on("updates:set_location", payload => {
  var locationToUpdate = document.getElementById(payload.current_city.host);
  var p = document.createElement("P"); 
  var t = document.createTextNode(payload.name);
  p.appendChild(t)
  locationToUpdate.appendChild(p);

  var players = playerLocations[payload.current_city.host] || []; 
  players.push({player: payload, location: p});
  playerLocations[payload.current_city.host] = players;
});

channel.on("updates:remove_location", payload => {
  var p = getCurrentLocation(payload);
  if(p == null) {
    return;
  }
  var locationToUpdate = p.location
  locationToUpdate.parentNode.removeChild(locationToUpdate);

  var players = playerLocations[payload.current_city.host] || []; 
  players.splice(players.indexOf(p), 1);
  playerLocations[payload.current_city.host] = players;
});

function getCurrentLocation(player) {
  var locations = playerLocations[player.current_city.host];
  if(locations == null) {
    return null;
  }
  for(var i = 0; i < locations.length; i++) {
    var p = locations[i];
    if(p.player.secret == player.secret) {
      return p;
    }
  }
  return null;
}

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp); channel.push("ping", {}); })
  .receive("error", resp => { console.log("Unable to join", resp) })


export default socket
