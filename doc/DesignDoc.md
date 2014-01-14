CONTROLLERS
============

StaticpagesController
- Home
- About
- Contact
- Help
UsersController
- new
- show
- edit
- create
- update
SessionsController
- new
- create
- destory
BodylogsController
- index
- new
- edit
- create
- destroy
WorkoutlogsController
- index
- new
- create
- destroy
- update
ContactFormsController
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

