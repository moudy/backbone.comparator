(function(_, Collection){

  // Split on comma + space for order declaration
  var _splitter = /,\s+/;

  // Return attribute, property or method result form model
  var _getResult = function(obj, string) {
    if (string.charAt(0) === '@') return _.result(obj, string.substring(1));
    return obj.get(string);
  };

  _.extend(Collection.prototype, {

    comparator: function(a, b) {
      // Do nothing if no order is specified
      if (!this.order) return false;

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
    }

  });

}).call(this, _, Backbone.Collection);
