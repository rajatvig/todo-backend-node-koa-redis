'use strict';

var Todo = require('../models/todo'),
  helpers = require('./helpers');

module.exports = {
  active: function*(query, params, body, req) {
    var baseUrl = 'http://' + req.header.host + '/todos/';
    return helpers.Ok(yield Todo.createWithId(1, baseUrl));
  },
  states: function*(){
    return helpers.Ok({
      "TodoiOSClient": [
        "a todoitem with id 1 exists"
      ]
    });
  }
};
