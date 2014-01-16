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
- ProfileController
	- new
	- show
	- update
	- create
	- destroy
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

- Use soft-tabs with a two space indent.
- Put spaces after : in property declarations.
- Put spaces before { in rule declarations.
- Use hex color codes #000 unless using rgba.
- Use // for comment blocks (instead of /* */).
- Document styles with KSS.
- Use px for font-size, because it offers absolute control over text. Additionally, unit-less line-height is preferred because it does not inherit a percentage value of its parent element, but instead is based on a multiplier of the font-size.
- use meaningful or generic ID class names
- user ID and cass names that are as short as possible but as long as necessary.
- seperate rules by new lines.

- Group sections by section comment

HTML
-----------------

- Doctype: use HTML5
- Use valid HTML wherever possible
- Use HTML according to its purpose
- Seperate structure from presentation from behavior (seperation of concerns)
- Use new line for every block, list or table element indent every child element
- When quoting attributes, use double qoutation marks.


JAVASCRIPT
---------------

- always use var to declare variables
- always end lines with a semi-colon
- use standard rather that non-standard features
- use camelCaseNames and UPPERCASE constants, but avoid the const keyword which isn’t supported in IE
- use namespacing techniques
- avoid eval() except for deserialization (strangely, JSON.Parse isn’t mentioned as an alternative)
- avoid with() on objects and for-in on arrays
- use array and object literals rather than more verbose declarations
- be aware of truthy and falsy rules
- do not use IE conditional comments in your JavaScript source
- don’t modify the prototypes of built-in objects — that’s a shame since it’s one of JavaScripts more powerful features, but you know it’ll lead to problems
- use closures carefully and do not introduce circular references

