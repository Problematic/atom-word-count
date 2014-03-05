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
      lines = editor.buffer.lines.length
      words = editor.buffer.cachedText.split(/\s+/)
      wordCount = words.length

      @find('.message').html("<p>Lines: #{lines}</p><p>Words: #{wordCount}</p>")

      atom.workspaceView.append(this)
