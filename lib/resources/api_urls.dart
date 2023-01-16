class ApiURLS {
  static const baseUrl = "http://localhost:4000/";

  //Auth apis
  static const signupURL = "${baseUrl}auth/register";
  static const loginURL = "${baseUrl}auth/login";

  //Location Details
  static const addLocationDetailsURL = "${baseUrl}addLocationDetails";
  static const getNearbyLocationsURL = "${baseUrl}getNearbyUsers";

  //Friends flow APis
  static const sendFriendRequestURL = "${baseUrl}friends/sendFriendRequest";
  static const getFriendStatusURL = "${baseUrl}friends/getFriendStatus";
  static const removeFromFriendURL = "${baseUrl}friends/removeFromFriend";
  static const acceptFriendRequestURL = "${baseUrl}friends/acceptFriendRequest";
  static const declineFriendRequestURL =
      "${baseUrl}friends/declineFriendRequest";
  static const cancelFriendRequestURL = "${baseUrl}friends/cancelFriendRequest";
  static const getFriendListURL = "${baseUrl}friends/getFriendList";
  //friends/removeFromFriend
  //friends/acceptFriendRequest
  //friends/declineFriendRequest
  //friends/cancelFriendRequest
  //friends/getFriendList
}
