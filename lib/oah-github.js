
// arguments in node start from 2
var repo_name = process.argv[2];
var github_username=process.argv[3]
var github_password=process.argv[4]
var github_org=process.argv[5]


var github = require('octonode');

var client = github.client({
  username: github_username,
  password: github_password
});


// Then we instantiate a client with or without a token (as show in a later section)

var ghme           = client.me();
var ghuser         = client.user(github_username);
var ghorg          = client.org(github_org);
