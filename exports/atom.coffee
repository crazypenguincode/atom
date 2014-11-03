{Point, Range} = require 'text-buffer'
{Emitter, Disposable, CompositeDisposable} = require 'event-kit'
{deprecate} = require 'grim'

module.exports =
  BufferedNodeProcess: require '../src/buffered-node-process'
  BufferedProcess: require '../src/buffered-process'
  GitRepository: require '../src/git-repository'
  Point: Point
  Range: Range

# The following classes can't be used from a Task handler and should therefore
# only be exported when not running as a child node process
unless process.env.ATOM_SHELL_INTERNAL_RUN_AS_NODE
  {$, $$, $$$, View} = require '../src/space-pen-extensions'

  module.exports.Emitter = Emitter
  module.exports.Disposable = Disposable
  module.exports.CompositeDisposable = CompositeDisposable

  module.exports.$ = $
  module.exports.$$ = $$
  module.exports.$$$ = $$$
  module.exports.View = View
  module.exports.TextEditorElement = require '../src/text-editor-element'

  module.exports.Task = require '../src/task'
  module.exports.WorkspaceView = require '../src/workspace-view'
  module.exports.Workspace = require '../src/workspace'
  module.exports.React = require 'react-atom-fork'
  module.exports.Reactionary = require 'reactionary-atom-fork'

  # Export deprecated SpacePen views.
  # Adjust their prototype chain to inherit from our extend version of SpacePen
  SpacePenViews = require 'atom-space-pen-views'
  class TextEditorView extends SpacePenViews.TextEditorView
  class ScrollView extends SpacePenViews.ScrollView
  class SelectListView extends SpacePenViews.SelectListView

  TextEditorView.prototype.__proto__ = View.prototype
  ScrollView.prototype.__proto__ = View.prototype
  SelectListView.prototype.__proto__ = View.prototype

  module.exports.TextEditorView = TextEditorView
  module.exports.ScrollView = ScrollView
  module.exports.SelectListView = SelectListView


Object.defineProperty module.exports, 'Git', get: ->
  deprecate "Please require `GitRepository` instead of `Git`: `{GitRepository} = require 'atom'`"
  module.exports.GitRepository

Object.defineProperty module.exports, 'EditorView', get: ->
  deprecate "Please require `TextEditorView` instead of `EditorView`: `{TextEditorView} = require 'atom'`"
  module.exports.TextEditorView
