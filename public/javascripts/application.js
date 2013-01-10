// Generated by CoffeeScript 1.4.0
(function() {
  var $, NumberingListManager, TextFieldSet, a;

  $ = require('jquery');

  TextFieldSet = (function() {

    function TextFieldSet(number) {
      this.number = number;
      this.body = $(this._makeBody());
      this.inputTagForKey = $("<input class =\"span2\" name=\"variable[" + this.number + "][key]\" type=\"text\" placeholder=\"variable name\"/>");
      this.inputTagForValue = $("<input class =\"span3\" name=\"variable[" + this.number + "][value]\" type=\"text\" placeholder=\"value\" />");
      this.wrapDivTag = "<div class=\"controls controls-row\"></div>";
    }

    TextFieldSet.prototype.reNumbering = function(number) {
      this.number = number;
      this.inputTagForKey.attr("name", "variable[" + this.number + "][key]");
      return this.inputTagForValue.attr("name", "variable[" + this.number + "][value]");
    };

    TextFieldSet.prototype._wrapByDivTag = function(content) {
      return content.wrap($(this.wrapDivTag));
    };

    TextFieldSet.prototype._makeBody = function() {
      return this._wrapByDivTag(this.inputTagForKey.add(this.inputTagForValue));
    };

    return TextFieldSet;

  })();

  NumberingListManager = (function() {

    function NumberingListManager(elementClass) {
      this.elementClass = elementClass;
      this.elementList = [];
    }

    NumberingListManager.prototype.appendElement = function() {
      var textField;
      textField = this._getNextElement();
      return this.elementList.push(textField);
    };

    NumberingListManager.prototype.removeElementAt = function(index) {
      var array_index, removedElement;
      array_index = index - 1;
      removedElement = this.elementList.splice(array_index, 1);
      this._reNumberingAllElement();
      return removedElement;
    };

    NumberingListManager.prototype.renderTo = function(renderingPoint) {
      return renderingPoint.append(this._render());
    };

    NumberingListManager.prototype._render = function() {
      var element;
      return ((function() {
        var _i, _len, _ref, _results;
        _ref = this.elementList;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          element = _ref[_i];
          _results.push(element.body);
        }
        return _results;
      }).call(this)).join("\n");
    };

    NumberingListManager.prototype._getNextElement = function() {
      return new this.elementClass(this._nextElementIndex());
    };

    NumberingListManager.prototype._reNumberingAllElement = function() {
      var elem, idx, _i, _len, _ref, _results;
      _ref = this.elementList;
      _results = [];
      for (idx = _i = 0, _len = _ref.length; _i < _len; idx = ++_i) {
        elem = _ref[idx];
        _results.push(elem.reNumbering(idx));
      }
      return _results;
    };

    NumberingListManager.prototype._nextElementIndex = function() {
      return this.elementList.length;
    };

    return NumberingListManager;

  })();

  a = new TextFieldSet(1);

  console.log(a.inputTagForValue);

}).call(this);