---
title: Tweeting from C#
---

Tweeting from any chunk of code has a slight increase in difficulty since all authentication to twitter must now be done with OAuth. Luckily there's a wide variety of libraries out there to help us out. For C# there is [Twitterizer](http://www.twitterizer.net/) (among [others](http://dev.twitter.com/pages/libraries#dotnet)). I will be going over how to do this from a desktop application, there is a [web example](http://www.twitterizer.net/tutorials/getting-started-with-oauth/) on the Twitterizer website. 

Posting a tweet to twitter is basically a three step process. Though if you store some values along the way you won't have to repeat these steps. 

Note that you will need the following two lines:

```
using Twitterizer;
using System.Web;
```

1) Get the Twitter PIN from the user

```
public void getPin() {
	OAuthTokenResponse response = OAuthUtility.GetRequestToken(consumerKey, consumerSecret, "oob");
	responseToken = response.Token;

	// open up a browser window to display the twitter token to the user
	System.Diagnostics.Process.Start("http://twitter.com/oauth/authorize?oauth_token=" + responseToken); 

	twitterPin.Show(); // this window asks for the user to enter the pin
	Form3 twitterPin = new Form3(); // form 3 calls authenticate
}
```

2) Authenticate with Twitter using the user entered PIN

```
public bool authenticate(string pin) {
	OAuthTokenResponse response = OAuthUtility.GetAccessToken(consumerKey, consumerSecret, responseToken, pin); 
	accessToken = response.Token;
	accessTokenSecret = response.TokenSecret;
	screenName = response.ScreenName; // screenName of the authenticated user (useful for display)
}
```

3) Make a post to twitter

```
public bool postUpdates() {
	OAuthTokens tokens = new OAuthTokens();
	tokens.AccessToken = accessToken;
	tokens.AccessTokenSecret = accessTokenSecret;
	tokens.ConsumerKey = consumerKey;
	tokens.ConsumerSecret = consumerSecret;

	// send our tweet to twitter
	TwitterResponse<TwitterStatus> tweetResponse = TwitterStatus.Update(tokens, "Tweeting from C#");
	if (tweetResponse.Result == RequestResult.Success) {
		return true;
	}

	return false;
}
```

All in all it's a relatively simple process thanks to Twitterizer. The only thing that really bugs me and breaks up a nice easy program flow is the need to open a browser for a user to get a PIN and then the user entering it. Sadly, this isn't something that can easily be helped with Twitter's OAuth requirement. This is exactly why you will want to save the access tokens to make sure you don't have to do the process more than once which is something you can do really easily with C#'s [Settings](http://msdn.microsoft.com/en-us/library/aa730869%28v=vs.80%29.aspx).