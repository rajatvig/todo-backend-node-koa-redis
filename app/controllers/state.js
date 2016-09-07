'use strict';

var Todo = require('../models/todo'),
  helpers = require('./helpers');

module.exports = {
  active: function*(query, params, body, req) {
    let baseUrl = 'http://' + req.header.host + '/todos/';
    if (body.state.startsWith("some")) {
      return helpers.Ok(yield Todo.createMultiple(baseUrl));
    } else {
      return helpers.Ok(yield Todo.createWithId(1, baseUrl));
    }
  },
  states: function*(){
    return helpers.Ok({
      "TodoiOSClient": [
        "some todoitems exist",
        "a todoitem with id 1 exists"
      ]
    });
  }
};
