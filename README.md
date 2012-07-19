# Fulcrum API Test

[Fulcrum][fulcrum] is a cloud based data collection service with clients for iPhone, iPad and Android devices. Additionally, you can integrate Fulcrum into your own applications by using the public [Fulcrum API][api]. Fulcrum’s developer API exposes access to your data & pictures, form elements, account setup info and more through our RESTful API. Using your API key, you have full access to create, read, update, and delete the primitive elements that make up individual forms in your account.

This sample demonstrates using [AFNetworking][af] to implement the [Fulcrum API][api] in an iOS application. This is not a complete implementation, but demonstrates the use of:

* Creating, Reading, Updating, Deleting of [Choice Lists][choicelists]
* Creating, Reading, Updating, Deleting of [Classification Sets][classificationsets]
* Reading of [Forms][forms]

## Instructions

In order for the example to run, you need to add your API key to the SNFulcrumAPIClient.m file by replacing the PASTE_YOUR_KEY_HERE string with your actual API token.

	#define FulcrumAPIToken @"PASTE_YOUR_KEY_HERE"

Your API key is available on your [profile page][profile]. As an example, if your API key was "abcdefghijklmnopqrstuvwxyz1234567890", the above line of code would look like this:

	#define FulcrumAPIToken @"abcdefghijklmnopqrstuvwxyz1234567890"	

Check out the [ Fulcrum documentation][docs] for more information on using Fulcrum in general.

[fulcrum]: http://fulcrumapp.com/ "Fulcrum" 
[api]: http://developer.fulcrumapp.com/api/fulcrum-api.html  "Fulcrum API"
[af]: https://github.com/AFNetworking/AFNetworking/ "AFNetworking on Github"
[forms]: http://developer.fulcrumapp.com/api/fulcrum-api.html#forms "Forms"
[choicelists]: http://developer.fulcrumapp.com/api/fulcrum-api.html#choice_lists "Choice Lists"
[classificationsets]: http://developer.fulcrumapp.com/api/fulcrum-api.html#classification_sets "Classification Sets"
[profile]: http://web.fulcrumapp.com/users/api "profile page"
[docs]: http://docs.fulcrumapp.com/ "documentation"
