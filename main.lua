-- Title: LivesAndTimers
-- Name: Ryoma Scott
-- Course: ICS2O/3C
-- This program

--variables for the timer
local totalSeconds = 5
local secondsLeft = 5
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2
local heart3
local heart4
--------------------------------------------------------------------
--Add local variable for: incorrect object, points object, points
--------------------------------------------------------------------

----hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background", 0/255, 20/255, 100/255)

--create local variables

local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local randomOperator
local userAnswer
local correctAnswer

--local functions

local function AskQuestion()
	--generate 2 random numbers between a max. and a min. number
	randomNumber1 = math.random(0, 15)
	randomNumber2 = math.random(0, 30)
	randomOperator = math.random(1,3)

	-- subtraction
	if (randomOperator == 1) then
	correctAnswer = randomNumber1 - randomNumber2 
	questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "


	-- multiplication
	elseif (randomOperator == 2) then
		correctAnswer = randomNumber1 * randomNumber2
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

	-- addition
	elseif (randomOperator == 3) then
		correctAnswer = randomNumber1 + randomNumber2
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

		
		
	end

	

end

local function HideCorrect()
	correctObject.isVisible = false
	incorrectObject.isVisible = false
	AskQuestion()
end

local function NumericFieldListener( event )

	--User begins editing "numericField"
	if ( event.phase == "began" ) then


		elseif event.phase == "submitted" then

			--when the answer is submitted (enter key is pressed) set user input to user's answer
			userAnswer = tonumber(event.target.text)

			--if the users answer and the correct answer are the same:
			if (userAnswer == correctAnswer) then
				correctObject.isVisible = true
				timer.performWithDelay(2000, HideCorrect)
				event.target.text = ""
			
			elseif (userAnswer ~= correctAnswer) then
				incorrectObject.isVisible = true
				timer.performWithDelay(2000, HideIncorrect)
				event.target.text = ""

		end
	end
end


	--Object creation

	--displays a question and sets the colour
	questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 40 )
	questionObject:setTextColor(255/255, 255/255, 0/255)

	--create the correct text object and make it invisible
	correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight/3, nil, 50 )
	correctObject:setTextColor(38/255, 90/255, 200/255)
	correctObject.isVisible = false

	--create the incorrect text object and make it invisible
	incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
	incorrectObject:setTextColor(100/255, 255/255, 10/255)
	incorrectObject.isVisible = false

--create numeric field
numericField = native.newTextField( display.contentWidth/2.1, display.contentHeight/2, 90, 80 )
numericField.inputType = "number"

--add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

--fucntion calls

--call the function to ask the question
AskQuestion()
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--local functions

local function UpdateTime()

	--decrement the number of seconds
	secondsLeft = secondsLeft - 1

	--display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0 ) then
		--reset the number of seconds left
		secondsLeft = totalSeconds
		lives = lives - 1

		--IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A YOU LOSE IMAGE
		--AND CANCEL THE TIMER   REMOVE THE 3RD HEART BY MAKING IT INVISIBLE
		if (lives == 2) then
			heart2.isVisible = false
			elseif (lives == 1) then
				heart1.isVisible = false
			end

			--CALL THE FUNCTION TO ASK A NEW QUESTION

		end
	end

	--function that calls the timer
	local function StartTimer()
		--create a countdown timer that loops infinitely
		countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
	end

------------------------------------------------------------------------
--OBJECT CREATION
------------------------------------------------------------------------

--create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7