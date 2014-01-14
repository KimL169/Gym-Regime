CONTROLLERS
============

- StaticpagesController
	- Home
	- About
	- Contact
	- Help
- UsersController
	- new
	- show
	- edit
	- create
	- update
- SessionsController
	- new
	- create
	- destory
- BodylogsController
	- index
	- new
	- edit
	- create
	- destroy
- WorkoutlogsController
	- index
	- new
	- create
	- destroy
	- update
- ContactFormsController
	- new
	- create

MODELS
=============

- User
	- Has_many :workouts
	- Has_many :bodylogs
- Bodylog
	- Belongs_to :user
- Workout
	- Has_many :exercises
	- Has_many :segments through: :exercise
- Exercise
	- Belongs_to :workout
	- Has_many :segments
- Segment
	- Belongs_to :exercise

TABLES
===============
- Users
	- name: string
	- passsword_digest: string
	- email :string
	- created_at :date_time
	- updated_at :date_time
	- remember_token :string
- Bodylogs
	- weight :float
	- kcal :integer
	- bodyfat :float
	- user_id :integer
	- created_at :date_time
	- updated_at :date_time

- Contact_forms
	- created_at :date_time
	- updated_at :date_time

- Workouts
	- name :string
	- comment :string
	- user_id :integer
	- created_at :date_time
	- updated_at :date_time

- Exercises
	- name :string
	- comment :string
	- workout_id :integer
	- user_id :integer
	- created_at :date_time
	- updated_at :date_time

- Segments
	- weight :float
	- reps :float
	- intensity: integer
	- created_at :date_time
	- updated_at :date_time


STYLEGUIDE
==================

Ruby on Rails
------------------
- Use UTF-8 as the source file encoding.
- Use two spaces per indentation level (aka soft tabs). No hard tabs.
- Don't use ; to separate statements and expressions. As a corollary - use one expression per line.
- Avoid single-line methods.
- Use spaces around operators, after commas, colons and semicolons, around { and before }
- No spaces after (, [ or before ], ).
- No space after !.
- Use spaces around the = operator when assigning default values to method parameters:
- Align the parameters of a method call if they span more than one line. When aligning parameters is not appropriate due to line-length constraints, single indent for the lines after the first is also acceptable.
- Align the elements of array literals spanning multiple lines.
- Limit lines to 80 characters.

CSS
-----------------
