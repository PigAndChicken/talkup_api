# TalkUp API 

### Routes
---

Our API is rooted at /api/v0.1/ and has the following subroutes:
   
* `GET transaction/t_id ` - Get the details of a transaction. 
* `POST transaction` - Post the transaction into database.
* `GET transactions` - Get the id of all transaction.

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