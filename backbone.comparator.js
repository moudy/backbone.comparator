
/*global require: false, define: false, exports: fasle, module: false*/

(function (root, factory) {
  'use strict';

  if (typeof exports === "object" && exports) {
    var underscore = require('underscore')
      , backbone = require('backbone');
    module.exports = factory(underscore, backbone); // CommonJS
  } else {
    if (typeof define === "function" && define.amd) {
      define(['underscore', 'backbone'], factory); // AMD
    } else {
      factory.call(this, _, Backbone); // <script>
    }
  }
}(this, function (_, Backbone) {
  'use strict';

  // Split on comma + space for order declaration
  var splitter = /,\s+/;

  // Return attribute, property or method result form model
  var getResult = function(obj, string) {
    if (string.charAt(0) === '@') return _.result(obj, string.substring(1));
    return obj.get(string);
  };

  Backbone.Comparator = {
    comparator: function(a, b) {
      var order, direction, aResult, bResult;

      var orders = _.result(this, 'order');
      if (typeof orders === 'undefined') throw new Error("No order value was found for Backbone.Comparator");

      orders = orders.split(splitter);

      // Loop through order declarations until condition is satisfied
      // Will only run through loop more than once if equal values are encountered
      while(orders.length) {
        // Split on space to get value and order direction
        order = orders.shift().split(' ');

        // Default to ascending order
        direction = order[1] === 'desc' ? 1 : -1;

        // Get desired comparator value
        aResult = getResult(a, order[0]);
        bResult = getResult(b, order[0]);

        // Do the actual comparison
        if (aResult < bResult) return direction;
        if (aResult > bResult) return -direction;
      }

      return 0;
    }
  };

}));
