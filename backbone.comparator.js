(function(_, Collection){
  'use strict';

  // Split on comma + space for order declaration
  var _splitter = /,\s+/;

  // Return attribute, property or method result form model
  var _getResult = function(obj, string) {
    if (string.charAt(0) === '@') return _.result(obj, string.substring(1));
    return obj.get(string);
  };

  var _defaultComparator = function(a, b) {
    var orders = _.result(this, 'order').split(_splitter)
      , order, direction, aResult, bResult;

    // Loop through order declarations until condition is satisfied
    // Will only run through loop more than once if equal values are encountered
    while(orders.length) {
      // Split on space to get value and order direction
      order = orders.shift().split(' ');

      // Default to ascending order
      direction = order[1] === 'desc' ? 1 : -1;

      // Get desired comparator value
      aResult = _getResult(a, order[0]);
      bResult = _getResult(b, order[0]);

      // Do the actual comparison
      if (aResult < bResult) {
        return direction;
      } else if (aResult > bResult) {
        return -direction;
      }

    }

    return 0;
  };

  var _Collection = Backbone.Collection;

  Backbone.Collection = _Collection.extend({
    constructor: function () {
      if (this.order) this.comparator = _defaultComparator;
      _Collection.apply(this, Array.prototype.slice.call(arguments));
    }
  });

}).call(this, _, Backbone.Collection);
