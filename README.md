# Blocipedia

A wiki application.  Create and contribute to wikis on any subject you can think of.

To view the case study for this application, please visit [my portfolio](sleekramer.github.io/portfolio/blocipedia).
## Summary

This app was built with Ruby on Rails, Haml, and Foundation.

Blocipedia is an application that allows users to create public and private wikis for any topic they desire. All wikis are Markdown-based, public wikis are free to be edited by all users, and private wikis are only able to be updated by designated collaborators. Creation of private wikis, however, is a privilege reserved for premium users, who have paid the $15 upgrade fee. Blocipedia serves as a great place for users to create and share knowledge and ideas about any subject. Private wikis are only accessible to collaborators.

## Features

* Users must create an account in order to view the site content
* Users can upgrade to a premium account for $15, which allows them to create and manage private wikis (viewable only to those they grant access, and admins)
* Standard users can view all public wikis and private wikis that they contribute to
* Admins have authority to CRUD all wikis
* Wiki content is markdown-based and users can see a live preview of their content as they create or edit it

## Running Locally

If you want to clone the repo and run the app locally, make sure you have Rails installed. Then, run:

```
$ bundle install
$ rake db:create
$ rake db:migrate
$ rails s
```
