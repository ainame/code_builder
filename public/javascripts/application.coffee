class TextFieldSet
  constructor: (@number, listLength, params)->
    @_inputTagForKey = $("<input class =\"span2\" type=\"text\" placeholder=\"variable name\" />")
    @_inputTagForValue = $("<input class =\"span3\" type=\"text\" placeholder=\"value\" />")
    @_inputTagForKey.attr "value", params["key"] if params["key"]
    @_inputTagForValue.attr "value", params["value"] if params["value"]
    @_wrapperDivTag= $("<div class=\"controls controls-row\" />")
    @_removeButtonTag = $("<button type=\"button\" class=\"btn removeTextFeildSetButton\">消</button><br />")
    @body = $(@_makeBody(listLength))
  reNumbering: (@number, listLength)->
    @_modifyRemoveButton(listLength)
    @_inputTagForKey.attr "name", "variables[#{@number}][key]"
    @_inputTagForValue.attr "name", "variables[#{@number}][value]"
  _makeBody: (listLength)->
    @_modifyRemoveButton(listLength)
    @reNumbering(@number, listLength)
    @_wrapByDivTag(@_inputTagForKey.add(@_inputTagForValue).add(@_removeButtonTag))
  _wrapByDivTag: (content)->
    @_wrapperDivTag.append(content)
  _modifyRemoveButton: (listLength)->
    if @number == 0 and listLength == 1
      @_detachRemoveButton()
    else if @number == 0 and listLength > 1
      @_attachRemoveButton()
  _attachRemoveButton: ->
    @_removeButtonTag.appendTo(@body)
  _detachRemoveButton: ->
    @_removeButtonTag.remove()

class NumberingListManager
  constructor: (@elementClass, @renderPoint)->
    @elementList = []
  appendElement: (params = {})->
    textField = @_getNextElement(params)
    @elementList.push textField
    @_reNumberingAllElement()
    @_renderTo()
  removeElementAt: (element)->
    index = @_getIndexOf(element)
    removedElement = @elementList.splice(index, 1)
    @_reNumberingAllElement()
    @_renderTo()
  _renderTo: ->
    @renderPoint.html(@_render())
  _render: ->
    listTag = $();
    listTag = listTag.add(element.body) for element in @elementList
    listTag
  _getNextElement: (params)->
    new @elementClass(@_nextElementIndex(), @elementList.length, params)
  _reNumberingAllElement: ->
    for elem, idx in @elementList
      elem.reNumbering(idx, @elementList.length)
  _nextElementIndex: ->
    @elementList.length
  _getIndexOf: (targetElement)->
    domList = (elem.body.get(0) for elem in @elementList)
    domList.indexOf(targetElement.get(0))

$ ->
  group = new NumberingListManager(TextFieldSet, $("#textFieldGroup"))
  $("#addTextFieldButton").click ()->
    group.appendElement()
  $(".removeTextFeildSetButton").live 'click', (event)->
    group.removeElementAt($(event.currentTarget).parent())

  params_json = $("#textFieldGroup").data("variables")
  if params_json?
    group.appendElement({key: key, value: value}) for key, value of params_json
  else
    group.appendElement()
