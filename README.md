PHPUGL 5.4
==========

[PHPUGL](http://phpugl.de) demo box with PHP 5.4 from PPA.
Please don't use it to build fresh boxes, as `/manifests/default` is a complete mess.
Should work with Vagrant >= 0.9.7.

    gem install vagrant
    vagrant up

Wait a few seconds. Reload if necessary, or if you where offline during bootup.
(The box needs to be online to get fresh apt sources)

Now point your browser to http://33.33.33.96/ or alias the IP address to **phpugl.local**.

Features
--------
* nginx 0.7.65-1ubuntu2.2
* php-cli 5.4.0-3~lucid+4
* php-fpm 5.4.0-3~lucid+4
