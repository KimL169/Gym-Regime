How to set up
===========

- clone repo
git clone https://github.com/KimL169/WorkoutBook

- make sure all gems are there
cd logbook
bundle

- initialize and seed database
rake db:setup
rake db:populate

- start server
rails s


WorkoutBook
===========

A workout, bodystats and result tracking web app. 

Features
===========

- User sign up
- Email confirmation
- User profile/settings
- User profile update
- Contact Form (which sends email to admin)

- Workout creation (exercises, sets, reps) 
- Workout entry/logging of results.
- 1-rep max strength calculator and tracker.
- Bodystat input and tracking, including calory calculator.
- A display of results over time via graphs. 
- Display of previous workout results on entry of new results.

Frameworks, languages and libraries
==========

- Ruby on Rails
- Javascript 
- HTML5
- CSS/SASS
- (possibly) AJAX
- SQLite


Project idea/philosophy
==========
This is a logbook app for keeping track of workouts and bodycomposition changes. 
This app will (initially) be more oriented towards strength athletes and bodybuilding/fitness.



Bugs
=========
- validations segments
- update workout, remove an exercise doesn't work.

- problem with validations workout input. If the validations are triggered (ex. you don't enter a workout name) the fields are emptied out.

              <% if bodylog_by_date(workout.created_at) %>
                <% bodylog = bodylog_by_date(workout.created_at) %>
                <h2>Bodystats</h2>
                  <ul>
                    <% if bodylog.weight %> <li><b>Weight:</b> <%= bodylog.weight %></li> <% end %>
                    <% if  bodylog.bodyfat %> <li><b>Bodyfat:</b> <%= bodylog.bodyfat %></li><% end %>
                    <% if bodylog.kcal %> <li><b>Calories:</b> <%= bodylog.kcal %></li><% end %>
                  </ul>
              <% end %>