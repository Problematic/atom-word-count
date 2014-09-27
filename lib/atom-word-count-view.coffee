{View} = require 'atom'

module.exports =
class AtomWordCountView extends View
  @content: ->
    @div class: 'atom-word-count overlay from-top', =>
      @div class: "message"

  initialize: (@editorView) ->
    atom.workspaceView.on 'focusout', '.editor:not(.mini)', => @detach()
    atom.workspaceView.on 'pane:before-item-destroyed', => @detach()
    atom.workspaceView.command "atom-word-count:toggle", => @toggle()

  destroy: ->
    @detach()

  toggle: ->
    return unless @editorView.isFocused

    if @hasParent()
      @detach()
    else
      editor = @editorView.editor

      text = editor.getSelectedText()
      text = editor.getText() if text.length == 0

      lineCount = text.split(/\n/).length
      wordCount = text.split(/\s+/).length

      @find('.message').html("
        <p>Lines: #{lineCount}</p>
        <p>Words: #{wordCount}</p>")

      atom.workspaceView.append(this)

      editor.onDidChange =>
        @detach()
