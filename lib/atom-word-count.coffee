AtomWordCountView = require './atom-word-count-view'

module.exports =
  views: []

  activate: ->
    atom.workspaceView.eachEditorView (editorView) =>
      if editorView.attached and editorView.getPane()
        @views.push new AtomWordCountView(editorView)

  deactivate: ->
    view.destroy() for view in @views
