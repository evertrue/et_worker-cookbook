et_worker cookbook CHANGELOG
============================
This file is used to list changes made in each version of the et_worker cookbook.

v1.8.3 (2014-09-04)
-------------------

* Include ssh known hosts cacher

v1.8.2 (2014-07-27)
-------------------

* Remove empty zones definition from attributes

v1.8.1 (2014-07-26)
-------------------

* Make apt-get update conditional on being a debian system

v1.8.0 (2014-06-27)
-------------------

* Add Zone Manager functionality


v1.7.1 (2014-06-09)
-------------------

* Fix typos etc. as a result of not updating various pieces to follow along with update to berkshelf-api-server v1.4.0


v1.7.0 (2014-06-09)
-------------------

* Use v1.4.0 of newly-renamed, community-site-provided, berkshelf-api-server cookbook


v1.6.1 (2014-05-21)
-------------------
* Remove Chef Community site from Berkshelf API endpoints


v1.6.0 (2014-05-16)
-------------------
* Remove GitHub as a Berkshelf API server endpoint


v1.5.2 (2014-05-16)
-------------------
* Fix syntax of Berkshelf API config (arrays do not have named items)


v1.5.1 (2014-05-16)
-------------------
* Fix setting of Berkshelf API configuration, as the endpoints in `node['berkshelf_api']['config'` need to be wrapped in an `endpoints` array inside the config hash


v1.5.0 (2014-05-16)
-------------------
* Break out Berkshelf API setup to separate recipe, and adjust ChefSpec tests to follow suit
* DRY up ChefSpec tests’ mocking & stubbing


v1.4.1 (2014-05-15)
-------------------
* Fix setting of GitHub token used by Berkshelf API in default recipe


v1.4.0 (2014-05-15)
-------------------
* Fix up to use Berkshelf 3
* Clean up Test Kitchen config
* Foodcritic & Rubocop fixes
* Use GitHub for stale-node-checker cookbook source
* Use berkshelf-api cookbook v1.3.1 instead of deprecated berkshelf-cookbook
* Add ChefSpec tests (all passing!)


v1.3.0 (2014-03-25)
--------------

* Add Berks API server

v1.2.9 (2014-03-07)
--------------

* Add stale node checker

v1.2.8 (2014-01-06)
--------------

* Fix attribute used by postfix cookbook
* Clean up Ruby code as per Rubocop

v1.2.7 (2013-12-05)
--------------

* Bump to postfix ~> 3.0.4

v1.2.6 (2013-12-02)
--------------

* Tweaked Gemfile to use:
    * Berkshelf 2.10.0
    * Test Kitchen 1.0.0
    * kitchen-vagrant 0.12.0
* Use generic email address for maintainer

v1.2.5 (2013-10-16)
--------------

* Use v1.1.4 of rds-s3-backups

v1.2.4 (2013-10-16)
--------------

* Use rds-s3-backup v.1.13

v1.2.3 (2013-10-15)
--------------

* Use v1.1.2 of rds-s3-backups

v1.2.2 (2013-10-10)
---------------

* Revert to ~> 2.1 of postfix

v1.2.1 (2013-10-03)
---------------

* Bump version to bring in postfix tweaks from v1.1.12 (briefly lost due to merging)

v1.2.0 (2013-10-02)
-------------------

* Use v1.1.0 of rds-s3-backups cookbook

v1.1.2 (2013-10-03)
-------------------

* Update postfix attribute & constrain postfix cookbook to ~> 3.0

v1.1.1 (2013-09-04)
---------------

* Bump rds-s3-backups to 1.0.2

v1.1.0 (2013-09-04)
---------------

* Add CHANGELOG
* Add Proby Monitor

v1.0.1 (2013-08-23)
---------------

* First rev
