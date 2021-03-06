et_worker cookbook CHANGELOG
============================
This file is used to list changes made in each version of the et_worker cookbook.

v5.1.0 (2017-05-10)
-------------------

* Add AWS cleanup cron job
* Clean up test environment

v5.0.1 (2016-08-08)
-------------------

* Add a brief delay to each route53_record call to avoid throttling

v5.0.0 (2016-04-12)
-------------------

* Remove Berkshelf API server

v4.0.0 (2016-02-03)
-------------------

* Remove rds-s3-backups references
    - This broke w/ the removal of the ET Berkshelf API server in any case
* Remove Proby recipe & tests
    - v3.1.0 uninstalled this defunct monitoring, this strips the code out of this cookbook

v3.1.1 (2016-02-02)
-------------------

* Fix Proby removal to work without template
* Fix ChefSpec tests to work with Proby `only_if` guard

v3.1.0 (2016-02-02)
-------------------

* Remove Proby monitoring
    - Proby is defunct, so let’s delete it
    - A future release will drop this code entirely
* Provide ability to use an IAM Profile instead of AWS access & secret keys for the Route 53 zone manager
* Clean up code
* Shift to testing using EC2
* Automate testing using Travis CI
* Drop as much encrypted data bag items as possible from test suites
    - Made possible by the adoption of IAM profiles
* Upgrade to using `data_bag_item` for all loading, thanks to Chef 12
* Improve on ChefSpec data bag mocking thanks to recent improvements
* Drop Gem/Rakefile, thanks to Chef DK

v3.0.8 (2015-08-11)
-------------------

* Require minimum fog-aws gem version

v3.0.7 (2015-06-22)
-------------------

* Test on ubuntu 14.04
* Place build essential compile-time attribute in attributes file
* For runit_service resource: remove the action and include the cookbook where the template is located

v3.0.6 (2015-06-18)
-------------------

* Stop pinning the nginx checksum ([3a01b71](miketheman/nginx@3a01b71) resolved)

v3.0.5 (2015-05-22)
-------------------

* require fog/aws instead of fog/aws/dns (which is no longer a thing)

v3.0.4 (2015-05-22)
-------------------

* Bump berkshelf-api-server 2.1.1

v3.0.3 (2015-05-22)
-------------------

* Bump route53 to 0.4.0
* Remove the docker-registry cookbook

v3.0.2 (2015-03-13)
-------------------

* Relax postfix version constraint

v3.0.1 (2015-02-24)
-------------------

* Update nginx source checksum to work aroud [3a01b71](https://github.com/miketheman/nginx/commit/3a01b71b186f0005cf1d8486b7f22d8aa0408e68)

v3.0.0 (2014-10-29)
-------------------

* Bump berkshelf-api-server version to 2.1.0
* Set client.pem owner to berkshelf api owner
* Upgrade a bunch of Gems
* Remove (seemingly unnecessary) attributes file specifying berkshelf api version

v2.0.2 (2014-10-27)
-------------------

* Use community version of `route53` cookbook
    - Our fixes shipped upstream, and there's [other goodies too](https://supermarket.getchef.com/cookbooks/route53/versions/0.3.6#changelog)

v2.0.1 (2014-10-24)
-------------------

* Use pessimistic versioning for `rds-s3-backups` to pick up bugfixes

v2.0.0 (2014-10-23)
-------------------

* Uninstall RDS → S3 backup
* Refactor tests
* Clean up cruft

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
