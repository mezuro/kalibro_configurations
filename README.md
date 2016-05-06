[<img
src="https://codeclimate.com/github/mezuro/kalibro_configurations/badges/gpa.s
vg" />](https://codeclimate.com/github/mezuro/kalibro_configurations)
## README - Kalibro Configurations

Kalibro Configurations is a source code analysis configuration web service
which is also part of the Mezuro project. It is free software under the AGPLv3
license.

It was strongly based on the vintage Kalibro (https://github.com/mezuro/kalibro)
written in Java mostly by Carlos Morais (carlos88morais at gmail dot com)
on his MSc dissertation (in portuguese http://www.teses.usp.br/teses/disponiveis/45/45134/tde-25092013-142158/en.php)

---

### Contributing

Please, have a look at the wiki pages about development workflow and code
standards:

* https://github.com/mezuro/prezento/wiki/Development-workflow
* https://github.com/mezuro/prezento/wiki/Standards


---

### Development

* System dependencies (Ubuntu package names)

  * build-essential

  * curl

  * postgresql-server-dev-9.3


  **NOTE:** The version of postgresql may vary accordingly with your system
  version

* Ruby version

  2.3.0

  You can easily install it through the Ruby Version Manager - RVM.
  Instructions on how to do it can be found at http://rvm.io

  It is expected to work with:

  * 2.1.5 Debian 8
  * 2.0.0 CentOS 7


  **NOTE:** If you are using the gnome-shell, or any derivative like
  terminator, you have to mark on your profile the option to use a "login
  bash".

* Configuration

      ./bin/setup

  This will create all the configuration files with defaults for Ubuntu and
  initialize your database.

* How to run the test suite

      rake

* Deployment instructions

  Deployment is made through Capistrano
  (https://github.com/capistrano/capistrano)

      cap production deploy

  In order to do this, you must have your ssh key set at the target server.

  Otherwise, you can also modify the deployment file at `config/deploy.rb`.


---

### Install

* First Deploy

  1.  Make sure that the deployment files (`config/deploy.rb`
      `config/deploy/production.rb` are correctly configured to the
      installation server;
  2.  Also, make sure that the installation server already has rvm
      installed;

      * It should already have the ruby version installed with the gemset created as well

  1.  Check if everything is OK for deploy:
          cap production deploy:check

  2.  Finally deploy with:
          cap production deploy



---

### License

Copyright (c) 2014-2016 The Authors.

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.

---

### Authors

Please see the humans.txt (at the `public` folder) file with the authors

---

### Acknowledgments

The authors have been supported by organizations:

University of São Paulo (USP) FLOSS Competence Center http://ccsl.ime.usp.br
