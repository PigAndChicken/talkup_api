# TalkUp API 

[ ![Codeship Status for PigAndChicken/talkup_api](https://app.codeship.com/projects/a050fb50-399c-0136-2546-36a36e9263f1/status?branch=master)](https://app.codeship.com/projects/289957)

### Routes
---

Our API is rooted at /api/v0.1/ and has the following subroutes:

* `GET accounts/username` - Get the details of account.   
* `GET issue/issue_id ` - Get the details of a issue. 
* `GET issues` - Get the id of all issues.


### Install
Install this API by cloning the relevant branch and installing required gems from Gemfile.lock:

```  ruby
bundle install
```
### Test
Run the test script:
```  ruby
rake spec
```