--DEPENDENCIES

--In library directory
push = require 'library/push'
Class = require 'library/class'

--In objects directory
require 'source/objects/player'
require 'source/objects/Virus'

--In controls directory
require 'source/controls/mouse'

-- In src & src/states directory
require 'src/StateMachine'

require 'src/states/BaseState'
require 'src/states/MenuState'
require 'src/states/OptionState'
require 'src/states/PlayState'

