# Backbone Comparator

A comparator method that allows for declaring the order of a Backbone
collection much like you would declare order in SQL.

* * *

Define an order property on the collection. This can be a string or a
function that returns a string.

To sort by a model's attribute `sort: 'lastName'`

To sort by the result of a method on the model and an '@' `sort: '@fullName'`

To fall back to another value in case of a tie add 1 or more fallback
values seperated by a comma `sort: 'lastName, firstName'`

The order is ascending by default. To make it descending add 'desc' to
the value `sort: 'lastName desc'`

You can change the order direction fallback values as well `sort:
'lastName, firstName desc'`


```javascript
var User = Backbone.Model.extend({
  karma: function () {
    return this.get('points') + this.get('upvotes');
  }
});

var Users = Backbone.Collection.extend({

  // By firstName attribute in ascending order
  order: 'firstName'

  // By firstName attribute in descending order
  order: 'firstName desc'

  // By firstName in ascending order and fallback to last name in descending order
  order: 'firstName, lastName desc'

  // By method
  order: '@karma'

  // By method in descending order and fall back to attribute
  order: '@karma desc, lastName'

});

```
