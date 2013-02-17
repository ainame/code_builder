class FieldSet
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

class TextFieldSet extends FieldSet
  constructor: (@number, listLength, params)->
    @_inputTagForKey = $("<input class =\"span2\" type=\"text\" placeholder=\"variable name\" />")
    @_inputTagForValue = $("<input class =\"span3\" type=\"text\" placeholder=\"value\" />")
    @_inputTagForKey.attr "value", params["key"] if params["key"]
    @_inputTagForValue.attr "value", params["value"] if params["value"]
    @_wrapperDivTag= $("<div class=\"controls controls-row\" />")
    @_removeButtonTag = $("<button type=\"button\" class=\"btn removeTextFeildSetButton\">delete</button><br />")
    @body = $(@_makeBody(listLength))
  reNumbering: (@number, listLength)->
    @_modifyRemoveButton(listLength)
    @_inputTagForKey.attr "name", "variables[#{@number}][key]"
    @_inputTagForValue.attr "name", "variables[#{@number}][value]"
  _makeBody: (listLength)->
    @_modifyRemoveButton(listLength)
    @reNumbering(@number, listLength)
    @_wrapByDivTag(@_inputTagForKey.add(@_inputTagForValue).add(@_removeButtonTag))

class TemplateFieldSet extends FieldSet
  constructor: (@number, listLength, params)->
    @_inputTag = $("<input class=\"span5\" placeholder=\"template name\" type=\"text\" />")
    @_textAreaTag = $("<textarea class=\"span6\" rows=\"10\"></textarea>")
    @_wrapperDivTag = $("<div class=\"controls controls-row\" />")
    @_removeButtonTag = $("<button type=\"button\" class=\"btn removeTemplateFeildSetButton span1\">remove</button>")
    @body = $(@_makeBody(listLength))
  reNumbering: (@number, listLength)->
    @_modifyRemoveButton(listLength)
    @_inputTag.attr "name", "package[templates_attributes][#{@number}][name]"
    @_textAreaTag.attr "name", "package[templates_attributes][#{@number}][body]"
  _makeBody: (listLength)->
    @_modifyRemoveButton(listLength)
    @reNumbering(@number, listLength)
    @_wrapByDivTag(@_inputTag.add(@_removeButtonTag).add($("<br />")).add(@_textAreaTag))
  _attachRemoveButton: ->
    @_removeButtonTag.insertAfter(@body.children().first())

$ ->
  textFieldGroup = new NumberingListManager(TextFieldSet, $("#textFieldGroup"))
  $("#addTextFieldButton").click ()->
    textFieldGroup.appendElement()
  $(".removeTextFeildSetButton").live 'click', (event)->
    textFieldGroup.removeElementAt($(event.currentTarget).parent())

  params_json = $("#textFieldGroup").data("variables")
  if params_json?
    textFieldGroup.appendElement({key: key, value: value}) for key, value of params_json
  else
    textFieldGroup.appendElement()

  templateFieldGroup = new NumberingListManager(TemplateFieldSet, $("#templateFieldGroup"))
  $("#addTemplateFieldButton").click ()->
    templateFieldGroup.appendElement()
  $(".removeTemplateFeildSetButton").live 'click', (event)->
    templateFieldGroup.removeElementAt($(event.currentTarget).parent())
  templateFieldGroup.appendElement()
