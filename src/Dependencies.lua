--DEPENDENCIES

--In library directory
push = require 'library/push'
Class = require 'library/class'

-- Constant variables are stored in hereby
require 'source/constants'

--In objects directory
require 'source/objects/particles'
require 'source/objects/player'
require 'source/objects/Virus'
require 'source/objects/background'

--In controls directory
require 'source/controls/mouse'

-- In src & src/states directory
require 'src/PlayMenu'
require 'src/Scoring'
require 'src/StateMachine'
require 'src/Util'

require 'src/states/BaseState'
require 'src/states/TitleState'
require 'src/states/OptionState'
require 'src/states/PlayState'

-- For resetting entities
require 'source/reset'

