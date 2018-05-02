# TalkUp API 

### Routes
---

Our API is rooted at /api/v0.1/ and has the following subroutes:
   
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