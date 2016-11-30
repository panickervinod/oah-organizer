
// arguments in node start from 2
var repo_name = process.argv[2];

var github_username=process.argv[3]

var github_password=process.argv[4]

var Github = require('../lib/github');

var github = new Github({
  username: github_username,
  password: github_password,
  auth: "basic"
});


console.log("About to create repo "+ repo_name +" in namespace "+ github_username)
var user = github.getUser();

user.createRepo({
  "name": repo_name,
  "description": repo_name,
  "homepage": "https://github.com",
  "private": false,
  "has_issues": true,
  "has_wiki": true,
  "has_downloads": true
}, function(err, res) {
  if(err)
  {
    console.log(err)
  }
  else {
    console.log(res)
  }
});
