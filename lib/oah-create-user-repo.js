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

var callback= function(err, res) {
  if(err)
  {
    console.log(err)
  }
  else {
    console.log(res)
  }
}

// Then we instantiate a client with or without a token (as show in a later section)

var ghme           = client.me();
var ghuser         = client.user(github_username);


console.log("About to create repo "+ repo_name +" in namespace "+ github_username)

ghme.repo({
  "name": repo_name,
  "description": repo_name,
  "homepage": "https://github.com",
  "private": false,
  "has_issues": true,
  "has_wiki": true,
  "has_downloads": true
}, callback); //repo
